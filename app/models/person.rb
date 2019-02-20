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