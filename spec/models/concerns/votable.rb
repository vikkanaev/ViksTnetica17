require 'rails_helper'

shared_examples_for 'votable' do
  let(:model) { described_class }
  let(:user) { create(:user) }
  let(:votable) { create(model.to_s.underscore.to_sym) }

  describe '#vote_up' do
    it 'Create new votable entry with value 1' do
      expect { votable.vote_up(user) }.to change(votable.votes, :count).by(1)
      expect( votable.votes.last.score ).to eq(1)
    end
  end

  describe '#vote_down' do
    it 'Create new votable entry with value -1' do
      expect { votable.vote_down(user) }.to change(votable.votes, :count).by(1)
      expect( votable.votes.last.score ).to eq(-1)
    end
  end

  describe '#vote_cancel' do
    before { votable.vote_up(user) }
    it 'Destroy votable entry if exists' do
      expect { votable.vote_cancel(user) }.to change(votable.votes, :count).by(-1)
    end
  end

  describe '#sum_score' do
    let!(:vote_up) { create_list(:vote, 5, :up, votable: votable) }
    let!(:vote_down) { create_list(:vote, 3, :down, votable: votable) }

    it 'Retern sum of all votable scores' do
      expect( votable.sum_score ).to eq(2)
    end
  end
end
