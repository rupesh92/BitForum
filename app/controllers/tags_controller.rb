class TagsController < ApplicationController
	# Searches for the input tag to find all related Questions and
	# populates variables for the view.
  def search
  	tag = Tag.where(:body => params[:tag]).first
  	@user = User.find(session[:user_id])
  	if(tag==nil)
  		 flash[:success] = "Sorry no questions with the tag #{params[:tag]} found"
  		 redirect_to @user
  	else

	  	@user = User.find(session[:user_id])
	  	@questions = []
	  	tagQuestions= TagQuestion.where(:tag_id =>tag.id)

	  	tagQuestions.each do |tagQuestion|
	  		@questions << Question.where(:id => tagQuestion.question_id).first
	  	end
	  	@tags = []
	    @questions.each do |question|
	    	tagQuestions = TagQuestion.where(:question_id => question.id)
	    	temp = []
	    	tagQuestions.each do |tagQuestion|
	    		temp << Tag.where(:id => tagQuestion.tag_id).first
	    	end
	      @tags.push(temp.to_json)  
	    end
	end
  end
end
