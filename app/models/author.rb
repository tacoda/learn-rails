class Author < ApplicationRecord
  has_many :books, dependent: destroy
end


# through
#
# class Physician < ApplicationRecord
#   has_many :appointments
#   has_many :patients, through: :appointments
# end
#
# class Appointment < ApplicationRecord
#   belongs_to :physician
#   belongs_to :patient
# end
#
# class Patient < ApplicationRecord
#   has_many :appointments
#   has_many :physicians, through: :appointments
# end
#
# class Supplier < ApplicationRecord
#   has_one :account
#   has_one :account_history, through: :account
# end
#
# class Account < ApplicationRecord
#   belongs_to :supplier
#   has_one :account_history
# end
#
# class AccountHistory < ApplicationRecord
#   belongs_to :account
# end
#
# polymorphic
#
#
# class Picture < ApplicationRecord
#   belongs_to :imageable, polymorphic: true
# end
#
# class Employee < ApplicationRecord
#   has_many :pictures, as: :imageable
# end
#
# class Product < ApplicationRecord
#   has_many :pictures, as: :imageable
# end