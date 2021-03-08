class HomeController < ApplicationController

  def index
    render(component: 'Home', props: { greeting: 'Casper' }) 
  end


end
