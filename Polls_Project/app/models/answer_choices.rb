# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  answer      :string
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class AnswerChoices < ActiveRecord::Base
  validates :answer, :question_id, :presence => true

  belongs_to :question,
    foreign_key: :question_id,
    primary_key: :id,
    class_name: 'Question'

  has_many :responses,
    foreign_key: :answer_choice_id,
    primary_key: :id,
    class_name: 'Response'

end
