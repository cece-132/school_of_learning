class StudentsController < ApplicationController
  def index
    @search = Student.ransack(params[:q])
    @students = @search.result(distinct: true)
    if params[:q].blank?
      @students = @students.order(:created_at)
    elsif params[:q]["s"] == "otg asc" 
      @students = @students.where(otg:true)
    else #params[:q]["s"] == "otg desc"
      @students = @students.order(:created_at)
    end
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

  def destroy
    student = Student.find(params[:student_id])
    student.destroy
    redirect_to '/students'
  end

  private

  def student_params
    params.permit(:name, :otg, :max_classes, :teacher_id)
  end
end