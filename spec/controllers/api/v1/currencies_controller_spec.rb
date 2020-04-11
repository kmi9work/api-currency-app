require 'rails_helper'
RSpec.describe Api::V1::CurrenciesController do
  before(:each) do
    email = Faker::Internet.email
    password = Faker::Internet.password
    name = Faker::Internet.username
    user = User.create(email: email, password: password, name: name)
    @token = JsonWebToken.encode(user_id: user.id)
  end

  describe "Authorization fail" do
    before do
      get :index
    end
    it "returns http unauthorized" do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET #index" do
    let!(:currencies) { FactoryBot.create_list(:random_currency, 100) }
    before do
      request.headers["Authorization"] = @token
      get :index
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "JSON body response contains page (20) elements" do
      json_response = JSON.parse(response.body)
      expect(json_response["data"].count).to match(20)
    end
  end

  describe "GET #index page 2" do
    let!(:currencies) { FactoryBot.create_list(:random_currency, 21) }
    before do
      request.headers["Authorization"] = @token
      get :index, params: {page: 2}
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "JSON body response contains one element" do
      json_response = JSON.parse(response.body)
      expect(json_response["data"].count).to match(1)
    end
  end

  describe "GET #show" do
    rate = 75.1
    name = "USD"
    before do
      request.headers["Authorization"] = @token
      currency = Currency.create(name: name, rate: rate.to_s)
      get :show, params: {id: currency.id}
    end
    it "returns currency rate" do
      json_response = JSON.parse(response.body)
      expect(json_response["data"]["rate"].to_f).to match(rate)
      expect(json_response["data"]["name"]).to match(name)
    end
  end
end

