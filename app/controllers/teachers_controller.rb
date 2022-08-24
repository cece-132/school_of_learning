class TeachersController < ApplicationController
  def index
    binding.pry
    @teachers = Teacher.order(:created_at)
  end

  def show
    @teacher = Teacher.find(params[:teacher_id])
  end
end