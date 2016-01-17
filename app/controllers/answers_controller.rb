require 'httparty'
class AnswersController < ApplicationController
  def add
  	Answer.create(:body => params[:answer] , :question_id => params[:question_id] , :user_id => session[:user_id])

  	redirect_to show_question_path(:question_id => params[:question_id])
  end

  def fetchJson
 #  	response = HTTParty.get('http://www.w3schools.com/json/myTutorials.js')
	# json = JSON.parse(response.body)
	debugger
	#var a = HTTParty.get("https://github.com" , {})
	safeurl = URI.parse(URI.encode("https://github.com", "[]"))
  	debugger
  end
end
