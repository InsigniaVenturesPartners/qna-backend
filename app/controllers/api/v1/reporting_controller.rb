class Api::V1::ReportingController < Api::V1::BaseController
  def total_user
    total_user = User.count
    total_insignia = User.where('email LIKE ?', '%@insignia.vc').count

    total_not_insignia = User.where('email NOT LIKE ?', '%@insignia.vc').count
    total_not_insignia_in_rafael = User.where('email NOT LIKE ?', '%@insignia.vc').where('insignia_uid IS NOT NULL').count
    
    return render :json => {
      users: total_user,
      insignia_users: total_insignia,
      portfolio: {
        total: total_not_insignia,
        connected_to_rafael: total_not_insignia_in_rafael
      }
    }
  end

  def total_question_posted
    question = Question.group('DATE(created_at)').order('DATE(created_at) DESC')
    if params[:ds] && params[:ds] != ''
      question = question.where('DATE(created_at) >= ?', params[:ds])
    end
    if params[:de] && params[:de] != ''
      question = question.where('DATE(created_at) <= ?', params[:de])
    end
    question = question.count
    return render :json => question
  end

  def total_answer_posted
    answer = Answer.where(question_id: Question.select('id')).group('DATE(created_at)').order('DATE(created_at) DESC')
    if params[:ds] && params[:ds] != ''
      answer = answer.where('DATE(created_at) >= ?', params[:ds])
    end
    if params[:de] && params[:de] != ''
      answer = answer.where('DATE(created_at) <= ?', params[:de])
    end
    answer = answer.count
    return render :json => answer
  end

  def insignia_answer_posted
    answer = Question.select('questions.id, questions.body,
      answers.id as answer_id, answers.body as answer_body,
      answers.created_at as answer_created_at, answers.updated_at as answer_updated_at, 
      users.id as answer_author_id, users.email as answer_author_email, users.name as answer_author_name, users.pro_pic_url as answer_author_pro_pic_urls')
      .joins('INNER JOIN answers ON questions.id = answers.question_id
      INNER JOIN users ON users.id = answers.author_id')
      .where("users.email LIKE ?", '%@insignia.vc').load
    if params[:ds] && params[:ds] != ''
      answer = answer.where('DATE(answers.created_at) >= ?', params[:ds])
    end
    if params[:de] && params[:de] != ''
      answer = answer.where('DATE(answers.created_at) <= ?', params[:de])
    end
    return render :json => {
      total: answer.size,
      data: answer
    }
  end

end
