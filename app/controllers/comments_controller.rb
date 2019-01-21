class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @recipe = Recipe.find(params[:id])

  end

  def create
    @comment = Comment.new
    # @hunt = Hunt.find(params[:hunt_id])
    @comment.description = params[:comment][:description]
    @comment.user = current_user
    @comment.recipe = Recipe.find(params[:recipe_id])

    if @comment.save
      redirect_to recipe_url(@comment.recipe)
    else
      flash[:notice] = "Comment not saved!"
      redirect_to recipe_url(@comment.recipe)
    end
  end

end
