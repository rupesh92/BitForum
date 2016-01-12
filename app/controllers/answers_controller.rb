class AnswersController < ApplicationController
  def add
  	Answer.create(:body => params[:answer] , :question_id => params[:question_id] , :user_id => session[:user_id])

  	redirect_to show_question_path(:question_id => params[:question_id])
  end
end
