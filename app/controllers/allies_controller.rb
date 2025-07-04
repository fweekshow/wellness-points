class AlliesController < ApplicationController
  before_action :set_ally, only: [:show, :edit, :update, :destroy]

  def index
    @allies = current_user.allies
  end

  def show
  end

  def new
    @ally = current_user.allies.build
  end

  def create
    @ally = current_user.allies.build(ally_params)
    
    if @ally.save
      redirect_to allies_path, notice: 'Ally was successfully added.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @ally.update(ally_params)
      redirect_to allies_path, notice: 'Ally was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ally.destroy
    redirect_to allies_path, notice: 'Ally was successfully removed.'
  end

  private

  def set_ally
    @ally = current_user.allies.find(params[:id])
  end

  def ally_params
    params.require(:ally).permit(:ally_email)
  end
end
