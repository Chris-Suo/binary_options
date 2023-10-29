class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable

  # has_paper_trail
  devise :database_authenticatable, :trackable, :timeoutable, :rememberable, :registerable

  audited only: %i[username quota level active admin]

  has_associated_audits
  has_many :trials, dependent: :destroy

  enum level: { basic: 0, premium: 1, admin: 2 }

  belongs_to :created_by_user, class_name: 'User', optional: true, foreign_key: "created_by"
  has_many :created_users, class_name: 'User', foreign_key: "created_by"

  after_update_commit :broadcast_quota

  def broadcast_quota
    ActionCable.server.broadcast("user_channel_#{self.id}", { quota: self.quota })
  end
end
