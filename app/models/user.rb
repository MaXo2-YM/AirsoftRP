require 'bcrypt'
class User < ActiveRecord::Base
	include BCrypt
	has_many :characters
	attr_accessor :password

	before_create :encrypt_password, :set_default
	before_save :encrypt_password
	after_save :clear_password


	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

	validates :username, presence: { message: "Le nom d'utilisateur (Pseudo) doit être renseigné." },
						 uniqueness:	{ message: "Le nom d'utilisateur (Pseudo) existe déjà."	},
						 :length => { :in => 3..20, message: "Le nom d'utilisateur (Pseudo) doit être compris entre 3 et 20 caractères." }

	validates :mail, presence: { message: "L'adresse e-mail doit être renseigné." },
					 uniqueness: { message: "L'adresse e-mail existe déjà." },
					 format: { with: EMAIL_REGEX, message: "L'adresse e-mail n'est pas valide." }

	validates :password, presence: { on: :create, message: "Vous devez entrer un mot de passe" },
						 confirmation: { on: :create, message: "Les deux mots de passe doivent être identiques" }, #password_confirmation attr
						 length: { on: :create, in: 6..20, too_short: "Le mot de passe doit faire plus de 6 characters", too_long: "Le mot de passe doit faire moins de 20 characters" }

	def encrypt_password
		unless password.blank?
	 		self.salt = BCrypt::Engine.generate_salt
			self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
	  	end
	end

	def clear_password
	    self.password = nil
		self.password_confirmation = nil
	end

	def set_default
		self.level = 3
		self.inscription_date = Time.now
	end

	def admin?
		self.level == 0
	end
end
