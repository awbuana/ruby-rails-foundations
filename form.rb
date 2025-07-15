require 'active_model'
require 'pry'

class SurveyInviter
  include ActiveModel::Model
  attr_accessor :recipients, :message, :sender, :survey

  validates :message, presence: true
  validates :recipients, length: { minimum: 1 }
  validates :sender, presence: true
  validates :survey, presence: true

  def invite
    if valid?
      puts "Valid"
    else
      puts self.errors.map {|e| [e.full_message]}
    end
  end
end


valid = SurveyInviter.new(recipients: ['a'], message: 'message', sender: 'sender', survey: 'survey')
valid.invite
# Valid

invalid = SurveyInviter.new(recipients: '', message: nil, sender: nil, survey: nil)
invalid.invite
# Message can't be blank
# Recipients is too short (minimum is 1 character)
# Sender can't be blank
# Survey can't be blank