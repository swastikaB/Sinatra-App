require 'dm-core'
require 'dm-migrations'
require 'dm-timestamps'

#DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Comment
    include DataMapper::Resource

    property :id, Serial
    property :name, String
    property :description, Text
    property :created_at, DateTime
    
end

DataMapper.finalize

get '/comments' do 
    @title = "Comments"
    @comment = Comment.all
    erb :'commentViews/display_comments'
end

get '/comments/create' do 
    @title = "Write a New Comment"
    @comment = Comment.new
    erb :'commentViews/create_comment'
end

post '/comments/create' do
    comment = Comment.create(params[:comment])
    redirect to('/comments')
end

get '/comments/:id' do
    @comment = Comment.get(params[:id])
    erb :'commentViews/view_comment'
end



