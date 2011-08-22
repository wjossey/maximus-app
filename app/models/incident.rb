class Incident
  include Mongoid::Document
  field :title, type: String, index: true
  field :message, type: String, index: true
  field :occurred_at, type: DateTime, default: -> { Time.now.utc }, index: true
  field :backtrace, type: String
  field :file, type: String
  field :host_name, type: String
  field :url, type: String
  belongs_to :incident_group, index: true

  after_create :update_group_count

end