class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tasks

#  def set_lang(lang)
#    I18n.locale = lang || I18n.default_locale
#    self.lang = lang
#    self.save
#  end
end
