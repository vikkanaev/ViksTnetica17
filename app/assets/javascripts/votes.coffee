# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

showVote = ->
  $('.questions, .answers').bind 'ajax:success', (e, data, status, xhr) ->
    responce = $.parseJSON(xhr.responseText)

    votable = $("##{responce.type.toLowerCase()}-#{responce.id}")
    votable.find("#vote-score-summ").html(responce.score)

    if responce.have_vote
        votable.find(".vote-up").addClass('no_display_btn')
        votable.find(".vote-down").addClass('no_display_btn')
        votable.find(".vote-cancel").removeClass('no_display_btn')
    if responce.vote_cancal
        votable.find(".vote-up").removeClass('no_display_btn')
        votable.find(".vote-down").removeClass('no_display_btn')
        votable.find(".vote-cancel").addClass('no_display_btn')

$(document).ready(showVote)
$(document).on('turbolinks:load', showVote )
