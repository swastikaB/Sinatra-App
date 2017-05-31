require 'dm-core'
require 'dm-migrations'



#DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Student
    include DataMapper::Resource
    property :id, Serial
    property :first_name, String
    property :last_name, String
    property :dob, Date
    property :address, Text

    def dob=date
        if(!date.empty?)
            begin 
                super Date.strptime(date, '%m/%d/%Y')
                #super Date.strptime(date, '%Y-%m-%d')
            rescue
                #settings.message = "Enter correct date"
                
                redirect to('/students/create')
            end
            
        end
    end

    def first_name= first_name
        super first_name.capitalize
    end

    def last_name= last_name
        super last_name.capitalize
    end
    
end

DataMapper.finalize

get '/students' do 
    @title = "Student Infomation"
    @student = Student.all
    erb  :'studentViews/display_students'
end

get '/students/edit/:id' do
    #only authorized person is allowed to edit a record
    if(settings.logged_in)
        @title = "Edit Student Info"
        @student = Student.get(params[:id])
        erb  :'studentViews/edit_student'
     else
        #redirect to login page
        redirect to('/login')
    end
end

get '/students/create' do
#only authorized person is allowed to create a record
    if(settings.logged_in)
        @title = "Enter New Student Information"
        @student = Student.new
        erb :'studentViews/create_student'
    else
        #redirect to login page
        settings.previous_pg = '/students/create'
        redirect to('/login')
    end
    
end

post '/students/create' do

    student = Student.create(params[:student])
    redirect to("/students")
end

get '/students/:id' do
    @student =  Student.get(params[:id])
    @title = @student.last_name + "'s Record"
    erb :'studentViews/view_student'
end

put '/students/:id' do
    student =  Student.get(params[:id])
    student.update(params[:student])
    redirect to("/students")
end

delete '/students/:id' do 
#only authorized person is allowed to delete a record
    if(settings.logged_in)
        Student.get(params[:id]).destroy
        redirect to('/students')
    else
        #redirect to login page
        redirect to('/login')  
    end
              
end








