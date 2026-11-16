class HiController < ApplicationController
  def index
    @stud    = 'Я - студент Руслан Залєвський'
    @time    = Time.now
    @message = 'прийшло з Контролера'
  end
end