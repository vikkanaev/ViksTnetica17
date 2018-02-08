shared_examples_for 'Votable' do
  scenario 'Authenticated user vote-up for question', js: true do
    sign_in(user_2)
    visit_page
    within "\##{vote_obj}-1" do
      click_on 'Vote_up'
      expect(page).to_not have_content 'Vote_up'
      expect(page).to_not have_content 'Vote_down'
      expect(page).to have_content 'Vote_cancel'
      expect(page).to have_content "#{vote_obj.capitalize} score 1"
    end
  end

  scenario 'Authenticated user vote-up for his question', js: true do
    sign_in(user_1)
    visit_page
    within "\##{vote_obj}-1" do
      expect(page).to_not have_content 'Vote_up'
      expect(page).to_not have_content 'Vote_down'
      expect(page).to_not have_content 'Vote_cancel'
    end
  end

  scenario 'Authenticated user vote-down for question', js: true do
    sign_in(user_2)
    visit_page
    within "\##{vote_obj}-1" do
      click_on 'Vote_down'
      expect(page).to_not have_content 'Vote_up'
      expect(page).to_not have_content 'Vote_down'
      expect(page).to have_content 'Vote_cancel'
      expect(page).to have_content "#{vote_obj.capitalize} score -1"
    end
  end

  scenario 'Authenticated user vote-down for his question', js: true do
    sign_in(user_1)
    visit_page
    within "\##{vote_obj}-1" do
      expect(page).to_not have_content 'Vote_up'
      expect(page).to_not have_content 'Vote_down'
      expect(page).to_not have_content 'Vote_cancel'
    end
  end

  scenario 'Authenticated user cancel vote for his question', js: true do
    sign_in(user_2)
    visit_page
    within "\##{vote_obj}-1" do
      click_on 'Vote_down'
      expect(page).to_not have_content 'Vote_up'
      expect(page).to_not have_content 'Vote_down'
      expect(page).to have_content 'Vote_cancel'
      expect(page).to have_content "#{vote_obj.capitalize} score -1"

      click_on 'Vote_cancel'
      expect(page).to have_content 'Vote_up'
      expect(page).to have_content 'Vote_down'
      expect(page).to_not have_content 'Vote_cancel'
      expect(page).to have_content "#{vote_obj.capitalize} score 0"
    end
  end
end
