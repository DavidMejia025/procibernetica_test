class CategoriesController < ApplicationController
  def create
    @category = Category.new(name: params[:category][:name])

    if @category .save
      flash.now[:success] = "New Category was Successfully created"

      respond_to do |format|
        format.js { render js: "tasks/create" }
      end
    else
      flash.now[:error] = "New Category could not be created"
      redirect_to action: "tasks/create"
    end
  end
end
