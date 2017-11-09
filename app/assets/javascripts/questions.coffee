# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

editQuestion = ->
  $('.answers').on 'click', '.edit-question-link', (e) ->
    e.preventDefault();
    $(this).hide();
    question_id = $(this).data('questionId');
    $('form#edit-question-' + question_id).show();

setBestAnswer = ->
  $('.answers').on 'click', '.best-answer-link', (ba) ->
    ba.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId');
    question_id = $(this).data('questionId');
    $.ajax({
            method: "PATCH",
            url: '/questions/'+ question_id + '/set_best_answer_ever/' + answer_id,
            data: {
              'best_answer_id': answer_id,
              'id': question_id,
              }
        });

$(document).ready(setBestAnswer)
$(document).ready(editQuestion)
