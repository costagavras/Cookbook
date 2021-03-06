class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @recipe = Recipe.find(params[:id])

  end

  def create
    @comment = Comment.new
    @comment.description = params[:comment][:description]
    @comment.user = current_user
    @comment.recipe = Recipe.find(params[:recipe_id])

    if @comment.save
      redirect_to recipe_url(@comment.recipe)
    else
      flash[:alert] = I18n.t("not_saved")
      redirect_to recipe_url(@comment.recipe)
    end
  end

end
