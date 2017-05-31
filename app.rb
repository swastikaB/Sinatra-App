require 'sinatra'
require './student'
require './comment'

configure do
    set :environment, :development
    #set :port, 4567
    set :username, "Swastika"
    set :password, "Password"
    set :logged_in, false
    #To keep track of the previous page visited. 
    #Currently used to keep track of the page before 
    #landing on the login page.
    set :previous_pg, "/"
    #Currently used to display error messages while login
    set :message, ""
end
configure :development, :test do
    DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
end

configure :production do 
    DataMapper.setup(:default,ENV['DATABASE_URL'])
end


get '/' do
    erb :home
end

get '/about' do 
    @title = "About the application"
    erb :about
end

get '/contact' do 
    @title = "Contact"
    erb :contact
end

#check student.rb for student related routes

#check comment.rb for comments related routes

get '/video' do 
    @title = "Video"
    erb :video
end

post '/login' do 
    @title = "Login"
    #if successful then take to (Home page or to the previous page) else to login page
    if(params[:username] == settings.username && params[:password] == settings.password)
        settings.logged_in = true
        settings.message = "" #set error message to blank
        if(!settings.previous_pg.empty?)
            redirect to(settings.previous_pg)
        else
            redirect to('/')
        end
    else
        settings.message = "Try again"
        redirect to('/login')
    end
end

get '/login' do
    erb :login
end

get '/logout' do
    settings.logged_in = false
    redirect to('/login')
end


