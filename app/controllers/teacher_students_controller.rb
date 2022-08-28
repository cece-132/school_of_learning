class TeacherStudentsController < ApplicationController
  def index
    @teacher = Teacher.find(params[:teacher_id])
    @students = @teacher.students
      if !params[:sort].blank?
        if params["sort"]["alpha"]
          @students = @students.order(:name)
        elsif params["sort"]["otg"]
          @students = @students.where(otg:true)
        else
          @students = @teacher.students
        end
      elsif !params[:search].blank?
        @students = @teacher.student_classes(params[:search])
      else
        @students = @teacher.students
      end
  end

  def new
    @teacher = Teacher.find(params[:teacher_id])
  end

  def create
    new_student = Student.create(teacher_student_params)
    redirect_to "/teachers/#{params[:teacher_id]}/students"
  end

  private

  def teacher_student_params
    params.permit(:name, :otg, :max_classes, :teacher_id, :search)
  end

end