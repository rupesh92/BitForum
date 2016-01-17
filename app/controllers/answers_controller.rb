require 'httparty'

#Aids in Adding answers to the Model
class AnswersController < ApplicationController

  #Redirects to /show_question after adding the answer to the database.
  def add
  	Answer.create(:body => params[:answer] , :question_id => params[:question_id] , :user_id => session[:user_id])

  	redirect_to show_question_path(:question_id => params[:question_id])
  end

end
