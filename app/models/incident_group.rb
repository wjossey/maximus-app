class IncidentGroup
  include Mongoid::Document
  field :group_title, type: String
  field :first_occurrence, type: DateTime, default: -> { Time.now.utc }
  has_many :incidents, :dependent => :delete

end