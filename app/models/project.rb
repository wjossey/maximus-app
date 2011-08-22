class Project
  include Mongoid::Document
  field :api_key, type: String, index: true
  field :name, type: String
  has_many :incident_groups
  belongs_to :user
  attr_reader :generate_api_key

  validates_presence_of :name
  before_create :generate_api_key

  private
  def generate_api_key
    self.api_key ||= Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[1..32]
  end

end