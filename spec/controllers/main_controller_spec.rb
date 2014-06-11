require 'rails_helper'

RSpec.describe MainController, :type => :controller do

  describe "GET 'lobby'" do
    it "returns http success" do
      get 'lobby'
      expect(response).to be_success
    end
  end

end
