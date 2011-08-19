class StackTrace
  include Mongoid::Document

  field :content, type: String
  embedded_in :incident
end
