class AddUrlToProviders < ActiveRecord::Migration
  def self.up
    add_column :providers, :url, :string
  end

  def self.down
    remove_column :providers, :url
  end
end
