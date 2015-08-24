require 'active_record'

class Player < ActiveRecord::Base
  has_many :performances

  attr_accessible :name, :position, :preseason_rank_2010,
    :preseason_rank_2011, :preseason_rank_2012, :preseason_rank_2013,
    :preseason_rank_2014, :preseason_rank_2015

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

  # TODO: Scopes don't work for some reason...
  # scope :quarterback,     where('position = ?', 'QB')
  # scope :running_back,    where('position = ?', 'RB')
  # scope :wide_receiver,   where('position = ?', 'WR')
  # scope :tight_end,       where('position = ?', 'TE')
  # scope :kicker,          where('position = ?', 'K')
  # scope :defense,         where('position = ?', 'DST')

  # SAVING DATA
  def find_or_build_performance(year, week)
    performance = performances.find(:first, conditions: { year: year.to_i, week: week.to_i })
    performance.present? ? performance : self.performances.build
  end

  def create_or_update_performance(db_row)
    performance = find_or_build_performance(db_row.year, db_row.week)
    performance.update_from_db_row(db_row)
    performance
  end

  # METRICS
  def datapoints_in(year)
    aggregate_data(year).count
  end

  def preseason_rank_in(year)
    send("preseason_rank_#{year.to_s}")
  end

  PERF_METRICS = [ :points, :passing_attempts, :passing_completions, :passing_yards, 
    :passing_touchdowns, :passing_interceptions, :passing_two_points,
    :rushing_attempts, :rushing_yards, :rushing_touchdowns, 
    :rushing_two_points, :receiving_receptions, :receiving_yards,
    :receiving_touchdowns, :receiving_two_points, 
    :fumble_fumbles, :fumble_touchdowns, 
    :pat_attempts, :pat_made, :fg_attempts, :fg_made, :fifty_yd_fg_made,
    :defensive_sacks, :defensive_interceptions, :defensive_safeties,
    :defensive_fumble_recoveries, :defensive_blocked_kicks, :defensive_touchdowns,
    :defensive_points_against, :defensive_passing_yards_allowed, 
    :defensive_rushing_yards_allowed, :defensive_total_yards_allowed ]

  PERF_METRICS.each do |metric|
    define_method "#{metric}_in" do |year|
      map_reduce_data(year, metric)
    end
  end

  private
  def aggregate_data(year)
    performances.where(year: year.to_i)
  end

  def map_reduce_data(year, fieldname)
    arr = aggregate_data(year).map(&fieldname.to_sym)
    arr = arr.grep(Integer) #Remove nil entries
    if arr.empty? 
      nil
    else 
      arr.instance_eval { reduce(:+) / size.to_f }
    end
  end
end
