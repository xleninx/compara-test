class GamesController < ApplicationController

  after_action :renew_token, only: :play

  def index
    generate_token
  end

  def play
    @dealer = DealerService.new(session[:token])
    @first_hand = @dealer.get_hand(5)
    @second_hand = @dealer.get_hand(5)
  end

  def renew_token
    generate_token if @dealer.expired_token?
  end

end