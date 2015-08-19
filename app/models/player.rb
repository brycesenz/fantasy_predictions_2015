require 'active_record'

class Player < ActiveRecord::Base
  has_many :performances

  attr_accessible :name, :position
  validates :name, presence: true
  validates :position, presence: true

  class << self
    def create_or_update_with_db_row(db_row)
      player = create_or_update_player(db_row)
      player.create_or_update_performance(db_row)
      player
    end

    def create_or_update_player(db_row)
      existing = self.find_by_name(db_row.player_name)
      if existing.present?
        existing.update_attributes(position: db_row.position)
        existing
      else
        self.create(name: db_row.player_name, position: db_row.position)
      end
    end
  end

  def find_or_build_performance(year, week)
    performance = performances.find(:first, conditions: { year: year.to_i, week: week.to_i })
    performance.present? ? performance : self.performances.build
  end

  def create_or_update_performance(db_row)
    performance = find_or_build_performance(db_row.year, db_row.week)
    performance.update_from_db_row(db_row)
    performance
  end
end
