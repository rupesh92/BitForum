class QuestionsController < ApplicationController
  def ask
  	@question = Question.new
  end
  def post
    user = User.find_by(id: session[:user_id]);
  	question = user.questions.create(:body => params[:question]);
  	tags = JSON.parse(params[:tags])

  	tags.each do |tag|
  		Tag.create(:body => tag.downcase , :question_id => question.id)
  	end
    render :js => "window.location = '#{root_path}'"
    return
  end

  def show
    @question = Question.where(:id => params[:question_id]).first
    @tags = Tag.where(:question_id => params[:question_id])
    @answers = Answer.where(:question_id => params[:question_id])
  end
end
