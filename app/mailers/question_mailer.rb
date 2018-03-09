class QuestionMailer < ApplicationMailer
  def new_answer(answer, user)
    @answer = answer
    @question = answer.question

    mail to: user.email
  end
end
