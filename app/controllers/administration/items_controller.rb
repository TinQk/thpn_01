# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    def index; end

    def update
      update_percentage = Item.find(params[:id])
      if item_params[:discount_percentage].to_i <= 100 && item_params[:discount_percentage].to_i >= 0
      	update_percentage.update(item_params)
      	if update_percentage.discount_percentage != 0
      	  update_percentage.update(has_discount: true)
      	else
      	  update_percentage.update(has_discount: false)
        end
        flash[:notice] = "Modification enregistrée!"
      else
      	flash[:alert] = "Le pourcentage doit être une valeur comprise entre 0 et 100"
      end

      redirect_to root_path
    end
 
    private

    def item_params
      params.require(:item).permit(:discount_percentage)
    end
  end
end
