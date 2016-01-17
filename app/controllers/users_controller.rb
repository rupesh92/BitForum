class UsersController < ApplicationController
  # Populates all questions and answers asked by the user and
  # hence helps the user/show view
  def show
    @questions = Question.where(:user_id => session[:user_id])
    @tags = []
    @questions.each do |question|
       tagQuestions = TagQuestion.where(:question_id => question.id)
       temp = []
        tagQuestions.each do |tagQuestion|
          temp << (Tag.where(:id => tagQuestion.tag_id)).first
        end
      @tags.push(temp.to_json)  
    end
    @user = User.find(params[:id])
  end
  # Helps the new user sugn-up
  def new
    @user = User.new
  end

  # Add the user to the database if data is correct,
  # else it redirects to the sign_up page
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      # Handle a successful save.
    else
      render 'new'
    end
  end

  # Assists in checking the signup form data
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :bitcoin_address , :phone_number)
    end
end