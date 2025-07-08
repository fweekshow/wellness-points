class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  # Associations
  has_many :allies, dependent: :destroy
  has_many :sent_transactions, class_name: 'PointTransaction', foreign_key: 'giver_id', dependent: :destroy
  has_many :received_transactions, class_name: 'PointTransaction', foreign_key: 'receiver_id', dependent: :destroy
  has_many :assigned_tasks, class_name: 'Task', foreign_key: 'user_id', dependent: :destroy

  # Returns tasks where this user is the actual ally (not just the owner)
  def received_tasks
    Task.joins(:ally).where(allies: { ally_user_id: id })
  end

  # Returns display name (alias or email)
  def display_name
    self[:alias].presence || email
  end

  def self.from_omniauth(access_token)
    # Try to find user by provider/uid first
    user = User.where(provider: access_token.provider, uid: access_token.uid).first

    # If not found, try to find by email and link the account
    unless user
      data = access_token.info
      user = User.find_by(email: data['email'])

      if user
        # Link Google account to existing user
        user.update(provider: access_token.provider, uid: access_token.uid)
      else
        # Create a new user if none exists
        user = User.create(
          email: data['email'],
          password: Devise.friendly_token[0, 20],
          alias: data['name'],
          provider: access_token.provider,
          uid: access_token.uid
        )
      end
    end
    user
  end
end
