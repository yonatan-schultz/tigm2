class User < ActiveRecord::Base
  has_many :hosted_games, foreign_key: 'host_id', class_name: 'Game'

  has_many :played_games
  has_many :games, :through => :played_games


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
