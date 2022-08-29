class StudentsController < ApplicationController
  def index
    @students = Student.order(:name)

    if params[:sort]
      @students = Student.where(otg:true)
    else 
      @students = Student.order(:created_at)
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

# <%= sort_link(@search, :otg, "Off Track to Graduate") %>