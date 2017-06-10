class DealerService

  def initialize(token)
    @token = token
  end

  def get_hand(num_cards = 5)
    @token.present? ? get_cards(num_cards) : false
  end

  def get_cards(num_cards)
    begin
      response = RestClient.get(dealer_url(num_cards), {})
      response.body
    rescue RestClient::ExceptionWithResponse
      false
    end
  end

  private

  def dealer_url(num_cards)
    "https://services.comparaonline.com/dealer/deck/#{@token}/deal/#{num_cards}"
  end

end