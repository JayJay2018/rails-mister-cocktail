class CocktailsController < ApplicationController
skip_before_action :authenticate_user!, only: :index, raise: false
before_action :set_cocktails, only: [ :show, :edit, :update, :destroy ]
  def index
    if params[:query].present?
      @cocktails = policy_scope(Cocktail).where("name ILIKE ?", "%#{params[:query]}%")

    else
      @cocktails = policy_scope(Cocktail)
    end
  end


  def show
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    @cocktail.user = current_user
    authorize @cocktail
    if @cocktail.save
      redirect_to cocktails_path, notice: "#{@cocktail.name} created. "
    else
      render 'cocktails/show'
    end

  end

  def new
    @cocktail = Cocktail.new
    authorize @cocktail
  end

  def edit
    @dose = Dose.new

  end

  def update
    @dose = Dose.new
    authorize @cocktail
    if @cocktail.update(cocktail_params)
      redirect_to cocktails_path, notice: "You succesfully updated #{@cocktail.name} at #{Time.now}."
    else
      render :new
    end

  end

  def destroy
    @dose = Dose.new
    authorize @cocktail
    if @cocktail.destroy
      redirect_to cocktails_path, notice: "You removed #{@cocktail.name} which you created at #{@cocktail.created_at}."
    else
      render :show
    end
  end

  private

  def set_cocktails
    @cocktail = Cocktail.find(params[:id])
    authorize @cocktail
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end

end
