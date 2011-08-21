class Incident
  include Mongoid::Document
  field :title, type: String
  field :message, type: String
  field :occurred_at, type: DateTime, default: -> { Time.now.utc }
  field :backtrace, type: String
  field :file, type: String
  field :host_name, type: String
  field :url, type: String
  embedded_in :incident_group

end