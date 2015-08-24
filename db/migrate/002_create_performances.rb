class CreatePerformances < ActiveRecord::Migration
  def change
    create_table :performances do |t|
      t.references :player,                null: false
      t.integer :year,                     null: false
      t.integer :week,                     null: false
      t.string :player_team,               null: false
      t.string :opposing_team,             null: false
      t.string :position,                  null: false
      t.boolean :home,                     null: false, default: false
      t.integer :points,                   null: false, default: 0
      t.integer :passing_attempts
      t.integer :passing_completions
      t.integer :passing_yards
      t.integer :passing_touchdowns
      t.integer :passing_interceptions
      t.integer :passing_two_points
      t.integer :rushing_attempts
      t.integer :rushing_yards
      t.integer :rushing_touchdowns
      t.integer :rushing_two_points
      t.integer :receiving_receptions
      t.integer :receiving_yards
      t.integer :receiving_touchdowns
      t.integer :receiving_two_points
      t.integer :fumble_fumbles
      t.integer :fumble_touchdowns
    end
  end
end
