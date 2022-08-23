class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all
  end

  def show
    @teacher = Teacher.find(params[:teacher_id])
    binding.pry
  end
end