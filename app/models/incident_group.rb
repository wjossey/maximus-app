class IncidentGroup
  include Mongoid::Document
  field :group_title, type: String
  has_many :incidents, :dependent => :delete

end