class PagesController < ApplicationController
  def home
    redirect_to campaigns_path if current_user
  end
end
