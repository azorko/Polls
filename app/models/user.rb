class User < ActiveRecord::Base
  
  validates :username, :presence  =>  true
  
  has_many(
  :authored_polls,
  class_name: "Poll",
  foreign_key: :author_id,
  primary_key: :id,
  dependent: :destroy
  )
  
  has_many(
  :responses,
  class_name: "Response",
  foreign_key: :user_id,
  primary_key: :id,
  dependent: :destroy
  )
  
  has_many(
  :participated_questions,
  through: :responses,
  source: :question
  )
  
  has_many(
  :participated_polls,
  -> { distinct },
  through: :participated_questions,
  source: :poll
  )
  
  def completed_polls
    questions = self.participated_questions
    polls = self.participated_polls.eager_load(:questions)
    polls.select do |poll|
      poll.questions.length == questions.where("poll_id = ?", poll.id).length
    end
  end
  
end