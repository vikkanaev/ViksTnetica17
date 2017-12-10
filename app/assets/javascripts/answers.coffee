# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

editAnswer = ->
  $('.answers').on 'click', '.edit-answer-link', (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    $('form#edit-answer-' + answer_id).show();

answersChannel = ->
  App.cable.subscriptions.create('AnswersChannel', {
    connected: ->
      console.log 'New connect answer'
      #return unless gon.question_id
      @perform 'follow', id: gon.question_id
    ,

    received: (data) ->
      answer = $.parseJSON(data['answer'])
      return if gon.current_user_id == answer.user_id
      $(".answers").append(JST["templates/answer"]({object: answer}))
      $(".comments").html(JST["templates/comment"]({object: answer}))
  })


$(document).ready(editAnswer)
$(document).ready(answersChannel)
$(document).on('turbolinks:load', editAnswer )
