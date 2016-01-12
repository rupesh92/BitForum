class Tag < ActiveRecord::Base
	has_many :questions
	validates :body , uniqueness: true

end
