class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  private
    def generate_token
      token = DealerConnectionService.new.generate_token
      if token.present?
        session[:token] = token
        session[:valid_token] = true
      else
        generate_token
      end
    end
end
