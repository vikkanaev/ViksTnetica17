class QuestionsChannel < ApplicationCable::Channel
  def follow
    stream_from "questions#{params['id']}"
  end
end
