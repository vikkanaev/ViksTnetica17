# Preview all emails at http://localhost:3000/rails/mailers/question_mailer
class QuestionMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/question_mailer/new_answer
  def new_answer
    QuestionMailer.new_answer(Answer.last)
  end

end
