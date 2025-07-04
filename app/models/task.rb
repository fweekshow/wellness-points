class Task < ApplicationRecord
  belongs_to :user
  belongs_to :ally
  
  validates :title, presence: true
  validates :description, presence: true
  validates :points, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true
  validates :due_date, presence: true
  
  enum status: {
    pending: 'pending',
    in_progress: 'in_progress',
    completed: 'completed',
    overdue: 'overdue'
  }
  
  scope :active, -> { where(status: ['pending', 'in_progress']) }
  scope :completed, -> { where(status: 'completed') }
  scope :overdue, -> { where('due_date < ? AND status != ?', Date.current, 'completed') }
  
  before_save :set_overdue_status
  after_initialize :set_default_status, if: :new_record?
  
  def accept!
    update!(status: 'in_progress')
  end

  def complete!
    transaction do
      update!(status: 'completed')
      # Create a point transaction when task is completed
      PointTransaction.create!(
        giver: user,
        receiver: ally.ally_user,
        task: title,
        points: points,
        claimed: false
      )
    end
  end
  
  def overdue?
    due_date < Date.current && status != 'completed'
  end
  
  private
  
  def set_overdue_status
    if overdue?
      self.status = 'overdue'
    end
  end

  def set_default_status
    self.status ||= 'pending'
  end
end
