class CocktailsController < ApplicationController
skip_before_action :authenticate_user!, only: :index, raise: false
  def index
    if params[:query].present?
      @cocktails = Cocktail.where("name ILIKE ?", "%#{params[:query]}%")

    else
      @cocktails = Cocktail.all
    end
  end


  def show
    @cocktail = Cocktail.find(params[:id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktails_path
    else
      render 'cocktails/show'
    end

  end

  def new
    @cocktail = Cocktail.new
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end

end
