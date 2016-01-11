class QuestionsController < ApplicationController
  def ask
  	@question = Question.new
  end
  def post
  	question = Question.create(:body => params[:question]);
  	tags = JSON.parse(params[:tags])

  	tags.each do |tag|
  		Tag.create(:body => tag , :question_id => question.id)
  	end
  	debugger
  	redirect_to ask
  end
end
