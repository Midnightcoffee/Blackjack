require 'rails_helper'

#FIXME: how should I include business logic in rpsec tests?
describe "Game Api" do
  before do
    @player = FactoryGirl.create(:player, :total_chips => 100)
    @game = FactoryGirl.create(:game, :player_id => @player.id, :level => "Beginner")  
  end

  #Show
  describe "Get player/#/games/#" do

    it "responds with game level" do

      get "/api/v1/players/#{@player.id}/games/#{@game.id}"
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['level']).to eql("Beginner")
    end
  end

  #Index
  describe "Get player/1/games/" do

    it "responds with game level" do

      get "/api/v1/players/#{@player.id}/games/"
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.count).to eql(@player.games.count)
    end
  end
  
  #Create
  describe "Successful create" do

    it "responds with game level" do
      count = Game.count

      params = { "level" => "High Roller"}.to_json
      post "/api/v1/players/#{@player.id}/games/", params, 
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }
      expect(response).to be_success
      expect(response.status).to eql(201)
      expect(response.content_type).to eql(Mime::JSON)

      json = JSON.parse(response.body)
      expect(Game.count).to eql(count + 1)
      game = Game.find(json["game_id"])
      expect(game.level) == "High Roller"
    end
  end

  describe "Un-Successful create" do

    it "does not create Games with invalid levels" do

      params = { "level" => "HACKS!"}.to_json
      post "/api/v1/players/#{@player.id}/games/", params, 
        { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

        expect(response.status).to eql(422)
      expect(response.content_type).to eql(Mime::JSON)
      json = JSON.parse(response.body)
      expect(json['error']).to eql("Not acceptable level - HACKS!")
    end
  end
end
