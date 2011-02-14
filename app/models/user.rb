class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates_inclusion_of :role, :in => %w( trainee worker admin )
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :firstname, :lastname, :hours, :holidays, :password, :password_confirmation, :remember_me

  has_many :day_sequences
end
