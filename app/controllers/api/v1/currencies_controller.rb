class Api::V1::CurrenciesController < ApplicationController
  include Pagy::Backend
  after_action { pagy_headers_merge(@pagy) if @pagy }

  def index
    @pagy, @currencies = pagy(Currency.all)
    render json: {data: @currencies}
  end

  def show
    currency = Currency.find(params[:id])
    render json: {data: currency}
  end
end
