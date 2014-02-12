class CreateLtiCodeshareEngineEntries < ActiveRecord::Migration
  def change
    create_table :lti_codeshare_engine_entries do |t|
      t.string :uuid
      t.string :klass
      t.string :remote_id
      t.integer :revision
      t.string :username
      t.integer :num_views
      t.datetime :last_view

      t.timestamps
    end
  end
end
