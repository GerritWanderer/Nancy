class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates_inclusion_of :role, :in => %w( trainee editor admin )
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :firstname, :lastname, :hours, :holidays, :password, :password_confirmation, :remember_me

  has_many :days
  has_many :works
  has_many :expenses
  has_and_belongs_to_many :projects
end
