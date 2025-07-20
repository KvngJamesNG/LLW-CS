class StaticPagesController < ApplicationController
  def home
    @message = " Hello LLW-CS version-whatever!!"
  end

  def learnmore
  end

  def team
  end

  def contactus
  end

  def joinus
  end

  def hireus
    respond_to do |format|
      format.html # renders hireus.html.erb
    end
  end

  def redirect
    respond_to do |format|
      format.html { redirect_to 'https://calendly.com/company-llw-cs/30min', allow_other_host: true }
    end
  end
  
end
