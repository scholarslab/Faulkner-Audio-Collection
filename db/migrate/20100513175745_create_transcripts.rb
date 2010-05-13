class CreateTranscripts < ActiveRecord::Migration
  def self.up
    create_table :transcripts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :transcripts
  end
end
