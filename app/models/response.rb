
class Response < ActiveRecord::Base
  
  validates :user_id, :answer_choice_id, :presence => true
  validate :respondent_has_not_already_answered_question
  validate :does_not_respond_to_own_poll
  
  #returns other responses for the same question
  def sibling_responses
    if persisted?
      return self.question.responses
    elsif self.question.responses.includes(self)
      return self.question.responses.where("responses.id <> ?", self.id)
    end
  end
  
  def respondent_has_not_already_answered_question
    unless answer_choice_id.nil?
      if self.sibling_responses.where(:user_id => self.user_id).exists?
        errors[:user_id] << "Respondent has already responded to the post."
      end
    end
  end
  
  def does_not_respond_to_own_poll
    errors[:user_id] << ["Who do you think you are, Richard Nixon?"] if self.question.poll.author.id == self.user_id
  end
  
  belongs_to(
    :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id 
  )
  
  belongs_to(
    :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id,
  )
  
  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )
  
  
end