class AddLogoIsDarkToProvider < ActiveRecord::Migration
  def self.up
    add_column :providers, :logo_is_dark, :boolean
  end

  def self.down
    remove_column :providers, :logo_is_dark
  end
end
