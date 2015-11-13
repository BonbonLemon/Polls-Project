# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  answer_choice_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, :presence => true
  validate :respondent_has_not_already_answered_question

  belongs_to :answer_choice,
    foreign_key: :answer_choice_id,
    primary_key: :id,
    class_name: 'AnswerChoices'

  belongs_to :respondent,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: 'User'

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    question
      .responses
      .where(":id IS NULL OR responses.id != :id", id: id)
  end

  private
  def respondent_has_not_already_answered_question
    sibling_responses.each do |response|
      if response.user_id == user_id
        errors[:one_response] << "can't respond twice"
      end
    end
  end

  def author_cant_respond_to_own_poll
    if question.poll.author.id == user_id
      errors[:author_response] << "author can't respond to this"
    end
  end
end
