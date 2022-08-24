class TeacherStudentsController < ApplicationController
  def index
    @teacher = Teacher.find(params[:teacher_id])
    @students = @teacher.students
  end
end