class Horse < ApplicationRecord

  has_many :horse_race_infos

  def father
    Horse.find(father_id)
  end

  def mother
    Horse.find(mother_id)
  end

  def g_father
    Horse.find(g_father_id)
  end

  def brothers
    Horse.where(mother_id: mother_id)
  end

  def cousins
    Horse.where(g_father_id: g_father_id)
  end

  def winning_races
    self.horse_race_infos.where(order_of_placing: 1)
  end

  def titles
    self.winning_races.map do |race_info|
      race_info.race_result.race.name
    end
  end

end
