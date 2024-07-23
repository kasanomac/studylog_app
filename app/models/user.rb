class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :user, optional: true
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

  validates :name,                            presence: true
  validates :password,                        presence: true, on: :create, length: { minimum: 6 } #文字数の正規表現
  validates :password_confirmation,           presence: true, on: :create
  
  
        
end
