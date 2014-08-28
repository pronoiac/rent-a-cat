class CatsController < ApplicationController
  before_action :ensure_same_user, only: [:edit, :update]
  
  def index
    @cats = Cat.all
    render :index
  end
  
  def show
    @cat = Cat.find_by_id(params[:id])
    render :show
  end
  
  def new
    @cat = Cat.new()
    
    render :new
  end
  
  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id
    if @cat.save
      render :show
    else
      render(
        json: @cat.errors.full_messages, status: :unprocessable_entity
      )
    end
  end
  
  def edit
    #
    # @cat = current_user.cats.find(params[:id])
    render :edit
  end
  
  def update
    #
    # @cat = Cat.find_by_id(params[:id])
    
    if @cat.update_attributes(cat_params)
      render :json => @cat
    else 
      render( 
        :json => @cat.errors.full_messages, 
        :status => :unprocessable_entity 
      )
    end
  end
  
  private
  def cat_params
    params.require(:cat).permit(:name, :age, :color, :birth_date, :sex, :description)
  end
  
  def ensure_same_user
    @cat = Cat.find(params[:id])
    unless @cat.user_id == current_user.id
      flash[:errors] ||= [] << "This is not your cat!"
      redirect_to cat_url(@cat) #s_url
    end
    true
  end
end
