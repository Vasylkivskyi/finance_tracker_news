class PagesController < ApplicationController
  before_action :authenticate_user!, :homepage
  def homepage

  end
end
