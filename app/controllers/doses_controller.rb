class DosesController < ApplicationController
  before_action :set_cocktail, only: [ :create ]
  before_action :set_dose, only: [ :destroy ]


  def create
    @dose = Dose.new(dose_params)
    # @dose.cocktail.user = current_user
    @dose.cocktail = @cocktail
    authorize @dose
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      redirect_to cocktail_path(@cocktail), notice: "Creating failed. Please try again."
    end
  end

  def destroy
    @dose.cocktail = @cocktail
    authorize @dose
     if @dose.destroy
      redirect_to cocktails_path, notice: "You succesfully deleted #{@dose.ingredient.name}."
    else
      redirect_to cocktail_path(@cocktail), notice: "Something went wrong, please try again."
    end
  end

  private

  def set_cocktail
    @cocktail = policy_scope(Cocktail).find(params[:cocktail_id])
    authorize @cocktail
  end

  def set_dose
    @dose = policy_scope(Dose).find(params[:id])
    authorize @dose
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end

end

