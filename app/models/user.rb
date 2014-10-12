class User < ActiveRecord::Base 

  include Sluggable

	has_many :posts
	has_many :comments
	has_many :votes
	
	has_secure_password validations: false

	validates :username, presence: true, uniqueness: true, length: {minimum: 5}
	validates :password, presence: true, on: :create, length: {minimum: 5}
 
  sluggable_column :username

	def two_factor_auth?
		!self.phone.blank?
	end
	
	def generate_pin!
		self.update_column(:pin, rand(10 ** 6)) # generates random 6 digit pin
	end
	
	def remove_pin!
		self.update_column(:pin, nil)
	end

	def send_pin_to_twilio
    account_sid = 'AC1cfa65543fd65e3e14bd023b64062b0e' 
    auth_token = '612592df0b3e4d934f6b1ff4996df05a' 
     
    client = Twilio::REST::Client.new account_sid, auth_token 
    
    msg = "Please enter your pin to proceed: #{self.pin}"

    client.account.messages.create({
      :from => '+14088053664', 
      :to => "#{self.phone}",
      :body => msg,  
    })

	end

	def admin?
		self.role == 'admin'
	end

	def moderator?
		self.role == 'moderator'
	end

end
