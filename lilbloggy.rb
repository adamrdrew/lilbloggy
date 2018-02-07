require 'sinatra'
require 'sinatra/contrib'
require 'facets/hash/rekey'
require 'slim'
require 'sequel'
require 'sqlite3'
require 'securerandom'
require 'json'
require './config/config'
require './lib/exceptions'

DB = Sequel.sqlite('data/lilbloggy.db')
require './lib/blog'
require './lib/post'
require './lib/page'
require './lib/auth'
require './lib/user'

class LilBloggy < Sinatra::Base
    helpers Sinatra::Cookies

    get '/config' do
        return json Config::APPCONFIG
    end
    
    get '/api/get_user' do
        raise NotAuthorizedException unless cookies[:uuid]
        user_hash = AuthToken.find(cookies[:uuid]).to_hash
        user_hash[:uuid] = cookies[:uuid]
        return json user_hash
    end

    post '/api/update_user' do
        response = JSON.parse(request.body.read).rekey
        raise NotAuthorizedException unless cookies[:uuid]
        user = AuthToken.find(cookies[:uuid])
        response.delete(:uuid)
        user.update_attributes(response)
        return json({success: true})
    end

    post'/user/auth/handshake' do
        name = JSON.parse(request.body.read)['name']
        auth_deets = AuthToken.get_user_salt(name)
        return json auth_deets
    end

    post '/user/auth' do
        j = JSON.parse(request.body.read)
        token = AuthToken.auth_user(j['name'], j['hash']);
        cookies[:uuid] = token[:uuid]
        cookies[:name] = token[:name]    
        return json({uuid: token[:uuid]})
    end

    post '/user/check_name' do
        raise SignupDisabledException unless Config::APPCONFIG[:signup_enabled]
        name = JSON.parse(request.body.read)['name']
        response = {taken: AuthToken.user_exists?(name)}
        return json response
    end

    post '/user/signup' do
        raise SignupDisabledException unless Config::APPCONFIG[:signup_enabled]
        j = JSON.parse(request.body.read)
        token = AuthToken.new_token(j['name'], j['salt'], j['hash'])
        cookies[:uuid] = token[:uuid]
        cookies[:name] = token[:name]
        new_user = User.new()
        new_user.name = cookies[:name]
        new_user.uuid = cookies[:uuid]
        new_user.save
        return json({:auth => true})
    end

    get '/post/range' do
        first = Post.first.id
        last  = Post.last.id
        ret = {first: first, last: last}
        return ret.to_json
    end

    get '/post/latest' do
        post  = Post.last
        return post.to_hash.to_json
    end

    get '/post/:id' do
        id = params['id']
        post = Post.where(id: id).first
        return post.to_hash.to_json
    end

    get "/*" do
        slim :index
    end
end