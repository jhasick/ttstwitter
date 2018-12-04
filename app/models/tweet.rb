class Tweet < ApplicationRecord

	before_validation :link_check, on: :create
	validates :message, length: {maximum: 140}, on: :create
	after_validation :apply_link, on: :create

	belongs_to :user

	has_many :tweet_tags

	has_many :tags, through: :tweet_tags

	def link_check
		check = false
		if self.message.include? "http://"
			check = true
		elsif self.message.include? "https://"
			check = true
		end

		if check == true
			arr = self.message.split
			index = arr.map{ |x| x.include? "http" }.index(true)
			self.link = arr[index]
			if arr[index].length > 23
				arr[index] = "#{arr[index][0..20]}..."
			end
			self.message = arr.join(" ")
		end
	end

	def apply_link
		arr = self.message.split
		index = arr.map{ |x| x.include?("http://") || x.include?("https://") }.index(true)
		if index != nil
			shortened_url = arr[index]
			arr[index] = "<a href='#{self.link}' target='_blank'>#{shortened_url}</a>"
		end
		self.message = arr.join(" ")
	end
end


