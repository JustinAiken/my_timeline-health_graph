class CreateHealthGraphCardioActivities < ActiveRecord::Migration
  def change
    create_table :my_timeline_health_graph_cardio_activities do |t|
      t.datetime :happened_on
      t.float    :meters
      t.float    :duration
      t.integer  :calories
      t.string   :routefile
      t.string   :uri
      t.text     :notes
      t.string   :equipment
      t.float    :climb
      t.string   :activity_type

      t.references :event

      t.timestamps
    end
  end
end
