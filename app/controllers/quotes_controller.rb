class QuotesController < ApplicationController

    def index 
        @quotes = Quote.all 
        render json: { quotes: @quotes }
    end 

    def create 
        authorization_header = request.headers[:authorization]

        if !authorization_header
            render status: :unauthorized
        else 
            token = authorization_header.split(" ")[1]
            secret_key = Rails.application.secrets.secret_key_base[0]
            decoded_token = JWT.decode(token, secret_key)

            user = User.find(decoded_token[0]["user_id"])

            @quote = Quote.create(
                author: params[:author],
                content: params[:content],
                user: user
            )

            render json: { quote: @quote }
        end
    end 

end
