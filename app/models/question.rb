class Question < ActiveRecord::Base
  
  validates :text, :poll_id, :presence  =>  true
  
  belongs_to(
  :poll,
  class_name: "Poll",
  foreign_key: :poll_id,
  primary_key: :id 
  )
  
  has_many(
  :answer_choices,
  class_name: "AnswerChoice",
  foreign_key: :question_id,
  primary_key: :id,
  dependent: :destroy
  )
  
  has_many(
  :responses,
  through: :answer_choices,
  source: :responses,
  dependent: :destroy 
  )
  
  def results
    result_hash = Hash.new(0)
    answer_pile = self.answer_choices.includes(:responses)
    answer_pile.each do |choice|
      result_hash[choice.text] += choice.responses.length
    end
    result_hash
  end
  
  def results_query
    result_hash = Hash.new(0)
    answer_pile = self.answer_choices
      .select("answer_choices.*, COUNT(responses.*) AS response_count")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .group("answer_choices.id")
                      
    answer_pile.map do |choice|
      result_hash[choice.text] += choice.response_count
    end
    result_hash
  end
  
end













