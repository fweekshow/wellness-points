class PointTransaction < ApplicationRecord
  belongs_to :giver, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  
  validates :task, presence: true
  validates :points, presence: true, numericality: { greater_than: 0 }
  validates :giver_id, presence: true
  validates :receiver_id, presence: true
  validate :giver_cannot_be_receiver
  
  # Points are now only incremented when claimed, not after create

  def claim!
    return if claimed?
    transaction do
      update!(claimed: true, claimed_at: Time.current)
      increment_receiver_points
    end
  end

  private
  
  def giver_cannot_be_receiver
    if giver_id == receiver_id
      errors.add(:base, "Giver cannot be the same as receiver")
    end
  end

  def increment_receiver_points
    receiver.increment!(:points, points)
  end
end
