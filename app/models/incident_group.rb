class IncidentGroup
  include Mongoid::Document
  field :group_title, type: String
  embeds_many :incidents

end