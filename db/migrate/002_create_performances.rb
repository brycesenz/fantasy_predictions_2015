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
      t.integer :passing_attempts,         null: false, default: 0
      t.integer :passing_completions,      null: false, default: 0
      t.integer :passing_yards,            null: false, default: 0
      t.integer :passing_touchdowns,       null: false, default: 0
      t.integer :passing_interceptions,    null: false, default: 0
      t.integer :passing_two_points,       null: false, default: 0
      t.integer :rushing_attempts,         null: false, default: 0
      t.integer :rushing_yards,            null: false, default: 0
      t.integer :rushing_touchdowns,       null: false, default: 0
      t.integer :rushing_two_points,       null: false, default: 0
      t.integer :receiving_receptions,     null: false, default: 0
      t.integer :receiving_yards,          null: false, default: 0
      t.integer :receiving_touchdowns,     null: false, default: 0
      t.integer :receiving_two_points,     null: false, default: 0
      t.integer :fumble_fumbles,           null: false, default: 0
      t.integer :fumble_touchdowns,        null: false, default: 0
    end
  end
end
