class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 
  field :name
  field :api_key, type: String, index: true
  has_many :projects
  validates_presence_of :name
  validates_uniqueness_of :email, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :projects
  attr_reader :api_key

  recursively_embeds_many

  before_create :generate_api_key

  private
  def generate_api_key
    self.api_key ||= Digest::SHA1.hexdigest(Time.now.to_s + rand(12341234).to_s)[1..32]
  end

end
