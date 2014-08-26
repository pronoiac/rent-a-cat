class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end
  
  def show
    @cat = Cat.find_by_id(params[:id])
    render :show
  end
  
  def new
    # @cat = Cat.new()
    render :new
  end
  
  private
  def cat_params
    params.require(:cat).permit(*params)
  end
  
end
