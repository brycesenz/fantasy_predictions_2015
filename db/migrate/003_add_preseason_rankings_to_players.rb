class AddPreseasonRankingsToPlayers < ActiveRecord::Migration
  def up
    add_column :players, :preseason_rank_2010, :integer
    add_column :players, :preseason_rank_2011, :integer
    add_column :players, :preseason_rank_2012, :integer
    add_column :players, :preseason_rank_2013, :integer
    add_column :players, :preseason_rank_2014, :integer
    add_column :players, :preseason_rank_2015, :integer
  end

  def down
    remove_column :players, :preseason_rank_2010
    remove_column :players, :preseason_rank_2011
    remove_column :players, :preseason_rank_2012
    remove_column :players, :preseason_rank_2013
    remove_column :players, :preseason_rank_2014
    remove_column :players, :preseason_rank_2015
  end
end
