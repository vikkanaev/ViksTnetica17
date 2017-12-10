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
      console.log 'New data in question', data
      question = $.parseJSON(data['question'])
      return if gon.current_user_id == question.user_id
      console.log 'and now', question
      $(".questions").append(JST["templates/question"]({object: question}))
      $(".comments").html(JST["templates/comment"]({object: question}))
  })

showCommentForm = ->
    $('.main').on 'click', '.new-comment-link', (e) ->
        e.preventDefault();
        $(this).hide();
        comment_id = $(this)[0].id
        console.log 'comment_id', comment_id
        $('.create_comment#' + comment_id).show();

$(document).ready(showCommentForm)
$(document).ready(editQuestion)
$(document).ready(questionsChannel)
$(document).on('turbolinks:load', editQuestion )
$(document).on('turbolinks:load', showCommentForm )
