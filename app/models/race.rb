class Race < ApplicationRecord
  belongs_to :course

  has_many :race_results

  def self.g1_races
    Race.where(grade: 'g1')
  end

  def self.g2_races
    Race.where(grade: 'g2')
  end

  def self.g3_races
    Race.where(grade: 'g3')
  end

end
