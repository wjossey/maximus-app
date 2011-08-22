class IncidentGroup
  include Mongoid::Document
  field :group_title, type: String, index: true
  field :first_occurrence, type: DateTime, default: -> { Time.now.utc }, index: true
  has_many :incidents, :dependent => :delete

  def incident_count
    Rails.cache.fetch(cache_key) do
      self.incidents.count
    end
  end

  def update_group_count
    count = Rails.cache.read(cache_key)
    count = count.nil ? self.incidents.count : count + 1
    Rails.cache.write(cache_key, count)
  end

  def cache_key
    "incident_group_count_cache/#{self._id}"
  end

end