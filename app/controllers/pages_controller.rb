class PagesController < ApplicationController
  def about
    @heading = 'Страничка о нас!'
    @text = 'Немного текста'
  end

end
