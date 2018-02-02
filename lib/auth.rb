require 'sequel'
require 'sqlite3'
require 'securerandom'

DB = Sequel.sqlite('data/auth.db')

class DuplicateUserException < StandardError
end

class WrongPasswordException < StandardError
end

class UserNotFoundException < StandardError
end

class AuthToken < Sequel::Model

    def self.find(uuid)
        AuthToken.where(Sequel.ilike(:uuid, uuid)).all.first
    end

    def self.new_token(name,salt,hash)
        raise DuplicateUserException if self.user_exists?(name)
        token = AuthToken.new({uuid: gen_uuid, name: name, hash: hash, salt: salt})
        token.save
        token
    end

    def self.gen_uuid
        SecureRandom.uuid
    end

    def self.user_exists?(name)
        return false unless AuthToken.where(Sequel.ilike(:name, name)).all.first
        return true
    end

    def self.get_user_salt(name)
        token = AuthToken.where(Sequel.ilike(:name, name)).all.first
        raise UserNotFoundException unless token
        token_hash = token.to_hash
        token_hash.delete(:hash)
        token_hash
    end

    def self.auth_user(name, hash)
         token = AuthToken.where(Sequel.ilike(:name, name)).all.first
         raise UserNotFoundException  unless token
         raise WrongPasswordException unless token[:hash] == hash
         return token
    end

end