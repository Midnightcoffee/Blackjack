class Game < ActiveRecord::Base
  belongs_to :player
  before_create :only_one_allowed
  # before_save :only_id_of_one_allowed

  def only_one_allowed
    if Game.count != 0
      return false
    end
  end

end
