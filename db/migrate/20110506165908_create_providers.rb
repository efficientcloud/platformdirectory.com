class CreateProviders < ActiveRecord::Migration
  def self.up
    create_table :providers do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.boolean :on_ec2
      t.integer :status
      t.references :status

      t.timestamps
    end
    create_table :providers_platform do |t|
      t.references :providers
      t.references :platform
    end
    create_table :providers_countries do |t|
      t.references :providers
      t.references :countries
    end
  end

  def self.down
    drop_table :providers_countries
    drop_table :providers_platform
    drop_table :providers
  end
end
