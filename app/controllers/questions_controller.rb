class QuestionsController < ApplicationController
  
  # Generates a Form to ask Question. Redirects to /ask.
  def ask
  	@question = Question.new
  end

  # Posts a Question with tags - adds it to the database tables - Tag, TagQuestion, and Question. 
  def post
    user = User.find_by(id: session[:user_id]);
  	question = user.questions.create(:body => params[:question]);
  	tags = JSON.parse(params[:tags])

  	tags.each do |tag|
  		Tag.create(:body => tag.downcase , :question_id => question.id)
      tag_id = Tag.where(:body =>tag.downcase).first.id
      TagQuestion.create(:question_id => question.id, :tag_id => tag_id)
  	end
    render :js => "window.location = '#{root_path}'"
    return
  end

  # Displays the details of a particular Question - User, Question, Tags, Answer and tips.
  def show

    @question = Question.where(:id => params[:question_id]).first
    
    tagQuestions = TagQuestion.where(:question_id => params[:question_id])
    @tags = []
    tagQuestions.each do |tagQuestion|
      @tags << (Tag.where(:id => tagQuestion.tag_id)).first
    end
    @answers = Answer.where(:question_id => params[:question_id])
  end

  def show_status
  end
end
