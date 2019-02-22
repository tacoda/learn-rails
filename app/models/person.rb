class Person < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2 }
  validates :terms_of_service, acceptance: true
  validates :email, confirmation: true, uniqueness: true
  validates :email_confirmation, presence: true
  validates :subdomain, exclusion: { in: %w(www us ca jp), message: "%{value} is reserved" }
  validates :legacy_code, format: { with: /\A[a-zA-Z]+\z/, message: "Only letters allowed" }
  validates :size, inclusion: { in: %w(small medium large), message: "%{value} is not a valid size" }
  validates :bio, length: { maxiumum: 500 }
  validates :points, numericality: true
  validates :card_number, presence: true, if: :paid_with_card?

  def paid_with_card
    payment_type == 'card'
  end
end

# p = Person.new("John Doe")
# p.new_record?
#
# create
# create!
# save
# save!
# update
# update!
# The bang versions (e.g. save!) raise an exception if the record is invalid.
# The non-bang versions don't: save and update return false, and create just returns the object.
#
# Skipping Validations
# decrement!
# decrement_counter
# increment!
# increment_counter
# toggle!
# touch
# update_all
# update_attribute
# update_column
# update_columns
# update_counters
# save(validate: false)
#
# p.valid?
#
# person = Person.new
# person.valid?
# person.errors[:name].any?
# person.errors.details[:name]
#
# Validation Helpers
# validates_associated
# absence
# validates_with
# validates_each
#
# Validation Options
# allow_nil
# allow_blank
# message
# on
#
# Conditional validation
#
# Errors
#
# person = Person.new
# person.valid?
# person.errors.messages
# person.errors[:name]
# person.errors.details[:name]
# person.errors.size
# person.errors.clear
#
# Errors in views
#
# <% if @article.errors.any? %>
#   <div id="error_explanation">
#      <h2><%= pluralize(@article.errors.count, "error") %> prohibited this article from being saved:</h2>
#
#     <ul>
#     <% @article.errors.full_messages.each do |msg| %>
#       <li><%= msg %></li>
#     <% end %>
#     </ul>
#      </div>
# <% end %>
#
#
# ===
#
# Attribute Methods
#
# The ActiveModel::AttributeMethods module can add custom prefixes and suffixes on methods of a class.
#
# class Person
#   include ActiveModel::AttributeMethods
#
#   attribute_method_prefix 'reset_'
#   attribute_method_suffix '_highest?'
#   define_attribute_methods 'age'
#
#   attr_accessor :age
#
#   private
#     def reset_attribute(attribute)
#       send("#{attribute}=", 0)
#     end
#
#     def attribute_highest?(attribute)
#       send(attribute) > 100
#     end
# end
#
# person = Person.new
# person.age = 110
# person.age_highest?  # => true
# person.reset_age     # => 0
# person.age_highest?  # => false
#
# ---
#
# Callbacks
#
# ActiveModel::Callbacks gives Active Record style callbacks. This provides an ability to define callbacks which run at appropriate times. After defining callbacks, you can wrap them with before, after and around custom methods.
#
#
# class Person
#   extend ActiveModel::Callbacks
#
#   define_model_callbacks :update
#
#   before_update :reset_me
#
#   def update
#     run_callbacks(:update) do
#       # This method is called when update is called on an object.
#     end
#   end
#
#   def reset_me
#     # This method is called when update is called on an object as a before_update callback is defined.
#   end
# end
#
# ---
#
# Conversion
#
# If a class defines persisted? and id methods, then you can include the ActiveModel::Conversion module in that class, and call the Rails conversion methods on objects of that class.
#
# class Person
#   include ActiveModel::Conversion
#
#   def persisted?
#     false
#   end
#
#   def id
#     nil
#   end
# end
#
# person = Person.new
# person.to_model == person  # => true
# person.to_key              # => nil
# person.to_param            # => nil
#
# ---
#
# Dirty
#
# An object becomes dirty when it has gone through one or more changes to its attributes and has not been saved. ActiveModel::Dirty gives the ability to check whether an object has been changed or not. It also has attribute based accessor methods.
#
#
# class Person
#   include ActiveModel::Dirty
#   define_attribute_methods :first_name, :last_name
#
#   def first_name
#     @first_name
#   end
#
#   def first_name=(value)
#     first_name_will_change!
#     @first_name = value
#   end
#
#   def last_name
#     @last_name
#   end
#
#   def last_name=(value)
#     last_name_will_change!
#     @last_name = value
#   end
#
#   def save
#     # do save work...
#     changes_applied
#   end
# end
#
#
# person = Person.new
# person.changed? # => false
#
# person.first_name = "First Name"
# person.first_name # => "First Name"
#
# # returns true if any of the attributes have unsaved changes.
# person.changed? # => true
#
# # returns a list of attributes that have changed before saving.
# person.changed # => ["first_name"]
#
# # returns a Hash of the attributes that have changed with their original values.
# person.changed_attributes # => {"first_name"=>nil}
#
# # returns a Hash of changes, with the attribute names as the keys, and the
# # values as an array of the old and new values for that field.
# person.changes # => {"first_name"=>[nil, "First Name"]}
#
#
# attr_name_changed?
# person.first_name # => "First Name"
# person.first_name_changed? # => true
#
#
# attr_name_was accessor
# person.first_name_was # => nil
#
# # attr_name_change
# person.first_name_change # => [nil, "First Name"]
# person.last_name_change # => nil
#
# ---
#
# Validations
#
# The ActiveModel::Validations module adds the ability to validate objects like in Active Record.
#
# class Person
#   include ActiveModel::Validations
#
#   attr_accessor :name, :email, :token
#
#   validates :name, presence: true
#   validates_format_of :email, with: /\A([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})\z/i
#   validates! :token, presence: true
# end
#
# person = Person.new
# person.token = "2b1f325"
# person.valid?                        # => false
# person.name = 'vishnu'
# person.email = 'me'
# person.valid?                        # => false
# person.email = 'me@vishnuatrai.com'
# person.valid?                        # => true
# person.token = nil
# person.valid?                        # => raises ActiveModel::StrictValidationFailed
#
# ---
#
# Naming
#
# ActiveModel::Naming adds a number of class methods which make naming and routing easier to manage. The module defines the model_name class method which will define a number of accessors using some ActiveSupport::Inflector methods.
#
#
# class Person
#   extend ActiveModel::Naming
# end
#
# Person.model_name.name                # => "Person"
# Person.model_name.singular            # => "person"
# Person.model_name.plural              # => "people"
# Person.model_name.element             # => "person"
# Person.model_name.human               # => "Person"
# Person.model_name.collection          # => "people"
# Person.model_name.param_key           # => "person"
# Person.model_name.i18n_key            # => :person
# Person.model_name.route_key           # => "people"
# Person.model_name.singular_route_key  # => "person"
#
# ---
#
# Model
#
# ActiveModel::Model adds the ability for a class to work with Action Pack and Action View right out of the box.
#
# When including ActiveModel::Model you get some features like:
#
# model name introspection
# conversions
# translations
# validations
#
# class EmailContact
#   include ActiveModel::Model
#
#   attr_accessor :name, :email, :message
#   validates :name, :email, :message, presence: true
#
#   def deliver
#     if valid?
#       # deliver email
#     end
#   end
# end
#
#
# email_contact = EmailContact.new(name: 'David',
#                                  email: 'david@example.com',
#                                  message: 'Hello World')
# email_contact.name       # => 'David'
# email_contact.email      # => 'david@example.com'
# email_contact.valid?     # => true
# email_contact.persisted? # => false
#
# ---
#
# Serialization
#
# ActiveModel::Serialization provides basic serialization for your object. You need to declare an attributes Hash which contains the attributes you want to serialize. Attributes must be strings, not symbols.
#
# class Person
#   include ActiveModel::Serialization
#
#   attr_accessor :name
#
#   def attributes
#     {'name' => nil}
#   end
# end
#
#
# person = Person.new
# person.serializable_hash   # => {"name"=>nil}
# person.name = "Bob"
# person.serializable_hash   # => {"name"=>"Bob"}
#
# class Person
#   include ActiveModel::Serializers::JSON
#
#   attr_accessor :name
#
#   def attributes
#     {'name' => nil}
#   end
# end
#
#
# person = Person.new
# person.as_json # => {"name"=>nil}
# person.name = "Bob"
# person.as_json # => {"name"=>"Bob"}
#
#
# class Person
#   include ActiveModel::Serializers::JSON
#
#   attr_accessor :name
#
#   def attributes=(hash)
#     hash.each do |key, value|
#       send("#{key}=", value)
#     end
#   end
#
#   def attributes
#     {'name' => nil}
#   end
# end
#
#
# json = { name: 'Bob' }.to_json
# person = Person.new
# person.from_json(json) # => #<Person:0x00000100c773f0 @name="Bob">
# person.name            # => "Bob"
#
# ---
#
# Translation
#
# ActiveModel::Translation provides integration between your object and the Rails internationalization (i18n) framework.
#
#
# class Person
#   extend ActiveModel::Translation
# end
#
# config/locales/app.pt-BR.yml:
# pt-BR:
#     activemodel:
#     attributes:
#     person:
#     name: 'Nome'
#
#
# Person.human_attribute_name('name') # => "Nome"
#
# ---
#
# Lint Tests
#
# ActiveModel::Lint::Tests allows you to test whether an object is compliant with the Active Model API.
#
#
# class Person
#   include ActiveModel::Model
# end
#
#
# require 'test_helper'
#
# class PersonTest < ActiveSupport::TestCase
#   include ActiveModel::Lint::Tests
#
#   setup do
#     @model = Person.new
#   end
# end
#
# rails test
#
# ---
#
# Secure Password
#
# ActiveModel::SecurePassword provides a way to securely store any password in an encrypted form. When you include this module, a has_secure_password class method is provided which defines a password accessor with certain validations on it.
#
# Requirements:
# ActiveModel::SecurePassword depends on bcrypt, so include this gem in your Gemfile to use ActiveModel::SecurePassword correctly. In order to make this work, the model must have an accessor named password_digest. The has_secure_password will add the following validations on the password accessor:
#
# Password should be present.
# Password should be equal to its confirmation (provided password_confirmation is passed along).
# The maximum length of a password is 72 (required by bcrypt on which ActiveModel::SecurePassword depends)
#
#
# class Person
#   include ActiveModel::SecurePassword
#   has_secure_password
#   attr_accessor :password_digest
# end
#
# person = Person.new
#
# # When password is blank.
# person.valid? # => false
#
# # When the confirmation doesn't match the password.
# person.password = 'aditya'
# person.password_confirmation = 'nomatch'
# person.valid? # => false
#
# # When the length of password exceeds 72.
# person.password = person.password_confirmation = 'a' * 100
# person.valid? # => false
#
# # When only password is supplied with no password_confirmation.
# person.password = 'aditya'
# person.valid? # => true
#
# # When all validations are passed.
# person.password = person.password_confirmation = 'aditya'
# person.valid? # => true