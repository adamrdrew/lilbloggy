require 'sinatra'
require 'sinatra/contrib'
require 'facets/hash/rekey'
require 'slim'
require 'lib/blog.rb'
require 'lib/post.rb'
require 'lib/page.rb'
require 'lib/auth.rb'
require 'lib/user.rb'

class LilBloggy < Sinatra::Base
    helpers Sinatra::Cookies

    configure do
        DB = Sequel.sqlite('data/auth.db')
    end

    get "/" do
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

    post'/api/auth_handshake' do
        name = JSON.parse(request.body.read)['name']
        auth_deets = AuthToken.get_user_salt(name)
        return json auth_deets
    end

    post '/api/auth_user' do
        j = JSON.parse(request.body.read)
        token = AuthToken.auth_user(j['name'], j['hash']);
        cookies[:uuid] = token[:uuid]
        cookies[:name] = token[:name]    
        return json({uuid: token['uuid']})
    end

    post '/api/name_available' do
        name = JSON.parse(request.body.read)['name']
        response = {taken: AuthToken.user_exists?(name)}
        return json response
    end

    post '/api/signup' do
        j = JSON.parse(request.body.read)
        token = AuthToken.new_token(j['name'], j['salt'], j['hash'])
        cookies[:uuid] = token[:uuid]
        cookies[:name] = token[:name]
        #new_user = User.new()
        #new_user.name = cookies[:name]
        #new_user.uuid = cookies[:uuid]
        #new_user.save
        return json({:auth => true})
    end

end