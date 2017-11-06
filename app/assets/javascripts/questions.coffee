# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

editQuestion = ->
  $('.edit-question-link').on 'click', (e) ->
    e.preventDefault();
    $(this).hide();
    question_id = $(this).data('questionId');
    $('form#edit-question-' + question_id).show();

setBestAnswer = ->
  $('.best-answer-link').on 'click', (ba) ->
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
