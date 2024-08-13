class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  before_create :set_user_id, :set_user_email
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def update_without_current_password(params, *options)
    params.delete(:current_password)  
    if params[:password].blank? && params[:password_confirmation].blank? 
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(name email)
  end

  def self.ransackable_associations(auth_object = nil)
    %w()
  end

  def avatar_url
    avatar.present? ? avatar.url : 'icon_user_1.png'
  end

  def set_user_id
    while self.id.blank? || User.find_by(id: self.id).present? do
      self.id = SecureRandom.base58
    end
  end

  def set_user_email
    while self.email.blank? || User.find_by(email: self.email).present? do
      random_string = SecureRandom.base58
      self.email = "#{random_string}@example.com"
    end
  end

  def self.guest_login
    random_pass = SecureRandom.base36
    random_email = SecureRandom.base58
    create!(name: "ゲストユーザー",
            email: "#{random_email}@example.com",
            password: random_pass,
            password_confirmation: random_pass,
            guest: true)
  end

  validates :name, presence: true
  validates :password, presence: true, on: :create, length: { minimum: 6 }
  validates :password_confirmation, presence: true, on: :create
end
