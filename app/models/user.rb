class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable
  has_one :administration
  has_one :solver
  validates :email, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, :on => :create

  def superuser?
  	self.role == 1
  end

  def administration?
  	self.role == 2
  end

  def solver?
  	self.role == 3
  end

end
