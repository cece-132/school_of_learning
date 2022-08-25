class TeacherStudentsController < ApplicationController
  def index
    #can probably have within TeachersControllers through if-statement
    @teacher = Teacher.find(params[:teacher_id])
    @students = @teacher.students
  end
end