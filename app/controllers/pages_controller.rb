class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home, raise: false
  layout 'homepage'

  def home
  end
end
