class TagsController < ApplicationController
  def show
    @tag = Tag.find_by(id: params[:id])
    @users = User.all
  end
end