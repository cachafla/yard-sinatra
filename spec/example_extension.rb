require 'sinatra/base'

module Sinatra
  module SessionAuth

    def self.registered(app)
      app.set :username, 'frank'
      app.set :password, 'changeme'

      # Displays a login form for the user
      app.get '/login' do
        "<form method='POST' action='/login'>" +
        "<input type='text' name='user'>" +
        "<input type='text' name='pass'>" +
        "</form>"
      end

      # POST /login
      app.post '/login' do
        if params[:user] == options.username && params[:pass] == options.password
          session[:authorized] = true
          redirect '/'
        else
          session[:authorized] = false
          redirect '/login'
        end
      end

      # FORGET_ABOUT /login
      forget '/login_me' do
        if params[:user] == options.username && params[:pass] == options.password
          session[:authorized] = true
          redirect '/'
        else
          session[:authorized] = false
          redirect '/login'
        end
      end

      # PUT_ME /login
      put_me '/login_me' do
        if params[:user] == options.username && params[:pass] == options.password
          session[:authorized] = true
          redirect '/'
        else
          session[:authorized] = false
          redirect '/login'
        end
      end

      # POST_YOU /login
      app.post_you '/login_me' do
        if params[:user] == options.username && params[:pass] == options.password
          session[:authorized] = true
          redirect '/'
        else
          session[:authorized] = false
          redirect '/login'
        end
      end

      some_array.delete_if {|item| item.exclusive?}

      # Error 404 Page Not Found
      app.not_found '/test' do
        haml :'404'
      end

    end
  end

  register SessionAuth
end

class MyApp < Sinatra::Base
  register Sinatra::SessionAuth
end