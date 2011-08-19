class Incident
  include Mongoid::Document
  field :message, type: String
  embeds_many :stack_traces

end