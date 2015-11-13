# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  body       :text
#  poll_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :body, :poll_id, :presence => true

  has_many :question_choices,
    foreign_key: :question_id,
    primary_key: :id,
    class_name: "AnswerChoices"

  belongs_to :poll,
    foreign_key: :poll_id,
    primary_key: :id,
    class_name: "Poll"

  has_many :responses,
    through: :question_choices,
    source: :responses

end
