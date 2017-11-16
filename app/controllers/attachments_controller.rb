class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @attachment = Attachment.find(params[:id])
    @parent =
    if current_user.author_of?(@attachment.attachmentable) && @attachment.destroy
      flash.now[:notice] = 'Your attachment successfully deleted.'
    else
      flash.now[:notice] = 'You can not delete this attachment.'
    end
  end
end
