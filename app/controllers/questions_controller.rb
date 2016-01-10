class QuestionsController < ApplicationController
  def ask
  	@question = Question.new
  end
  def post
  	debugger
  end
end
