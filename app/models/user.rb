require 'digest/sha2'

class User < ActiveRecord::Base
	# include ActiveModel::MassAssignmentSecurity
	after_destroy :ensure_an_admin_remains
	validates :name, :presence => true, :uniqueness => true
	validates :password, :confirmation => true #or :uid
	attr_accessor :password_confirmation
	attr_reader :password
	# attr_protected :uid, :provider, :name # see text for explanation

	validate :password_must_be_present unless :provider
	validate :auth_must_be_present unless :password

	def password=(password)
		@password = password

		if password.present?
			generate_salt
			self.hashed_password = self.class.encrypt_password(password, salt)
		end
	end

	def User.encrypt_password(password, salt)
		Digest::SHA2.hexdigest(password + "wobble" + salt)
	end

	def User.authenticate(name, password)
		if user = User.find_by_name(name)
			if user.hashed_password == encrypt_password(password, user.salt)
				user
			end
		end
	end


	def self.create_with_omniauth(auth)
		User.create!(
		:provider => auth["provider"],
	  :uid => auth["uid"],
	  :name => auth["info"]["name"])
	end

private

	def auth_must_be_present
		errors.add(:provider, "Missing provider") unless provider.present?
		errors.add(:uid, "Missing uid") unless uid.present?
		errors.add(:name, "Missing name") unless name.present?
	end

	def password_must_be_present
		errors.add(:password, "Missing password") unless hashed_password.present?
	end

	def generate_salt
		self.salt = self.object_id.to_s + rand.to_s
	end

	def ensure_an_admin_remains
      if User.count.zero?
        raise "Can't delete last user"
      end
    end
end
