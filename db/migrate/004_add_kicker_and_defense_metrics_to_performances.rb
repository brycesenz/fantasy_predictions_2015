class AddKickerAndDefenseMetricsToPerformances < ActiveRecord::Migration
  def up
    # Kicker Fields
    add_column :performances, :pat_attempts, :integer
    add_column :performances, :pat_made, :integer
    add_column :performances, :fg_attempts, :integer
    add_column :performances, :fg_made, :integer
    add_column :performances, :fifty_yd_fg_made, :integer

    # Defense/Special Teams Fields
    add_column :performances, :defensive_sacks, :integer
    add_column :performances, :defensive_interceptions, :integer
    add_column :performances, :defensive_safeties, :integer
    add_column :performances, :defensive_fumble_recoveries, :integer
    add_column :performances, :defensive_blocked_kicks, :integer
    add_column :performances, :defensive_touchdowns, :integer
    add_column :performances, :defensive_points_against, :integer
    add_column :performances, :defensive_passing_yards_allowed, :integer
    add_column :performances, :defensive_rushing_yards_allowed, :integer
    add_column :performances, :defensive_total_yards_allowed, :integer
  end

  def down
    # Kicker Fields
    remove_column :performances, :pat_attempts
    remove_column :performances, :pat_made
    remove_column :performances, :fg_attempts
    remove_column :performances, :fg_made
    remove_column :performances, :fifty_yd_fg_made

    # Defense/Special Teams Fields
    remove_column :performances, :defensive_sacks
    remove_column :performances, :defensive_interceptions
    remove_column :performances, :defensive_safeties
    remove_column :performances, :defensive_fumble_recoveries
    remove_column :performances, :defensive_blocked_kicks
    remove_column :performances, :defensive_touchdowns
    remove_column :performances, :defensive_points_against
    remove_column :performances, :defensive_passing_yards_allowed
    remove_column :performances, :defensive_rushing_yards_allowed
    remove_column :performances, :defensive_total_yards_allowed
  end
end
