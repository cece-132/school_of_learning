class TeachersController < ApplicationController
  def index
    @teachers = Teacher.order(:created_at)
  end

  def show
    @teacher = Teacher.find(params[:teacher_id])
  end

  def new
  end

  def create
    new_teacher = Teacher.create(teacher_params)
    redirect_to '/teachers'
  end

  def edit
    @teacher = Teacher.find(params[:teacher_id])
  end

  def update
    teacher = Teacher.find(params[:teacher_id])
    updated_teacher = teacher.update(teacher_params)
    redirect_to "/teachers/#{teacher.id}"
  end

  private

  def teacher_params
    params.permit(:name, :license_issued, :renew_license, :max_students)
  end
end