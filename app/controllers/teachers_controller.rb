class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all.order(:created_at)
    if params[:sort] == 'alpha'
      @teachers = Teacher.all.order(:name)
    elsif params[:sort] == 'student_count'
      @teachers = Teacher.order_student_count
    elsif !params[:name].blank?
      @teachers = Teacher.search_teacher(params[:name])
    else
      @teachers = Teacher.all.order(:created_at)
    end
    # if !params["sort"].blank?
    #   if params["sort"]["name"]
    #     @teachers = Teacher.all.order(:name)
    #   else #params[:sort][:count]
    #     redirect_to "/teachers/count"
    #   end
    # elsif !params[:name].blank?
    #   @teachers = Teacher.search_teacher(params[:name])
    # else
    #   @teachers = Teacher.all.order(:created_at)
    # end
  end

  def show
    @teacher = Teacher.find(params[:teacher_id])
  end

  def count
    @teachers = Teacher.order_student_count
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