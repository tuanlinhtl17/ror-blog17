class TagsController < ApplicationController
  before_action :logged_in?

  def create
  end

  private

    def tag_params
      params.require(:tag).permit(:name)
    end
end
