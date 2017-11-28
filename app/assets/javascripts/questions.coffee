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
      $(".questions").append data
  })

$(document).ready(editQuestion)
$(document).ready(questionsChannel)
$(document).on('turbolinks:load', editQuestion )
