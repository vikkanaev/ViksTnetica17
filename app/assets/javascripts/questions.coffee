# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

editQuestion = ->
  $('.questions').on 'click', '.edit-question-link', (e) ->
    e.preventDefault();
    $(this).hide();
    question_id = $(this).data('questionId');
    $('form#edit-question-' + question_id).show();

questionsChannel = ->
  App.cable.subscriptions.create('QuestionsChannel', {
    connected: ->
      console.log 'New connect'
      @perform 'follow'
    ,

    received: (data) ->
      question = $.parseJSON(data['question'])
      return if gon.current_user_id == question.user_id
      $(".questions").append(JST["templates/question"]({object: question}))
  })

showCommentForm = ->
    $('.new-comment-link').on 'click', (e) ->
        e.preventDefault();
        $(this).hide();
        $('.create_comment').show();

$(document).ready(showCommentForm)
$(document).ready(editQuestion)
$(document).ready(questionsChannel)
$(document).on('turbolinks:load', editQuestion )
