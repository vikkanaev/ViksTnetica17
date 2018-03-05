class QuestionMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.question_mailer.new_answer.subject
  #
  def new_answer(answer)
    @answer = answer
    @question = answer.question

    mail to: answer.question.user.email
  end
end
