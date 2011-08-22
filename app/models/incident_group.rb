class IncidentGroup
  include Mongoid::Document
  field :group_title, type: String, index: true
  field :first_occurrence, type: DateTime, default: -> { Time.now.utc }, index: true
  has_many :incidents, :dependent => :delete

end