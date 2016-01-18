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
      if tag.empty? == false
    		Tag.create(:body => tag.downcase , :question_id => question.id)
        tag_id = Tag.where(:body =>tag.downcase).first.id
        TagQuestion.create(:question_id => question.id, :tag_id => tag_id)
      end
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
     proxy = URI("http://10.3.100.207:8080")
     #options =   {http_proxyaddr: proxy.host,http_proxyport:proxy.port}
     options = {}
     address = '1qMBuZnrmGoAc2MWyTnSgoLuWReDHNYyF'
     key = '5adb0a94a6eb60cb3b8a626e774156521b2ab964'
     url = "https://api.blocktrail.com/v1/btc/address/#{address}/transactions?api_key=#{key}"
     @mutual_transactions = []
     @nonmutual_transactions = []
     responses = HTTParty.get(url,options).parsed_response["data"]
     btc_to_rupee = HTTParty.get("https://api.btcxindia.com/ticker/",options).parsed_response["avg"]
     commenters_address = User.where(:id => params[:commenters_id]).first.bitcoin_address
     responses.each do |response|
      response["outputs"].each do |output|
        output["value_in_rupee"] = (output["value"]*btc_to_rupee*0.00000001).round(2)
        if output["address"] ==  commenters_address
          @mutual_transactions << output
        else
          @nonmutual_transactions << output
        end
      end
     end

     
  end

  def show_latest
    @questions = Question.last(10).reverse
    @tags = []
    @questions.each do |question|
       tagQuestions = TagQuestion.where(:question_id => question.id)
       temp = []
        tagQuestions.each do |tagQuestion|
          temp << (Tag.where(:id => tagQuestion.tag_id)).first
        end
      @tags.push(temp.to_json)  
    end
  end
end
