Given(/^a player joins a rigged against them game$/) do
    #TODO: break into multiple steps
    visit '/#/games/1'
    @game = Game.find(1) 
    @game.deck_sleeve = "Diamond,Ace|Heart,Ace|Spade,8|Heart,9|Spade,9|Spade,10|" 
    @game.save
    @game.reload 
    
end

Then(/^they should bust$/) do
  #FIXME: better test need player feedback
  expect(page).to have_button("Bet") 
end

