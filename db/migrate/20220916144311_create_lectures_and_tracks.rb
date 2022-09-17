class CreateLecturesAndTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :tracks do |t|
      t.integer :lunch_id
      t.integer :networking_id

      t.timestamps
    end

    create_table :lectures do |t|
      t.string :name
      t.integer :duration
      t.time :start_time
      t.belongs_to :track

      t.timestamps
    end
  end
end
