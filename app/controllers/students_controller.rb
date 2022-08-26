class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:student_id])
  end

  def edit
    @student = Student.find(params[:student_id])
  end

  def update
    student = Student.find(params[:student_id])
    updated_student = student.update(student_params)
    redirect_to "/students/#{student.id}"
  end

  private

  def student_params
    params.permit(:name, :otg, :max_classes, :teacher_id)
  end
end