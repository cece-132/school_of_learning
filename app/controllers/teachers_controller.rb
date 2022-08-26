class TeachersController < ApplicationController
  def index
    if !params["sort"]
      @teachers = Teacher.all.order(:created_at)
    else #params[:q]["s"] == "otg desc" || params[:q].blank? 
      @teachers = Teacher.order(name: :asc)
    end
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

  def destroy
    teacher = Teacher.find(params[:teacher_id])
    teacher.destroy
    redirect_to '/teachers'
  end

  private

  def teacher_params
    params.permit(:name, :license_issued, :renew_license, :max_students)
  end
end