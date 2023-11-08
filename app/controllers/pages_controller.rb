class PagesController < ApplicationController
  before_action :authenticate_user!, :homepage
  def homepage
    pp current_user
  end
end
