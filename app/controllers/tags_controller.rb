class TagsController < ApplicationController
  def search
  	tag = Tag.where(:body => params[:tag]).first
  	@user = User.find(session[:user_id])
  	if(tag==nil)
  		 flash[:success] = "Sorry no questions with the tag #{params[:tag]} found"
  		 redirect_to @user
  	else
	  	@user = User.find(session[:user_id])
	  	@questions = Question.where(:id => tag.question_id)
	  	@tags = []
	    @questions.each do |question|
	      temp = Tag.where(:question_id => question.id);
	      @tags.push(temp.to_json)  
	    end
	end
  end
end
