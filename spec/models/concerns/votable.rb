require 'rails_helper'

shared_examples_for 'votable' do
  let(:model) { described_class }
  let(:user) { create(:user) }
  let(:votable) { create(model.to_s.underscore.to_sym) }

  describe '#vote_up' do
    it 'voiting up'
  end

  describe '#vote_down' do
    it 'voiting down'
  end

  describe '#vote_cancel' do
    it 'vote_cancel'
  end

  describe '#sum_value' do
    it 'sum_value'
  end
end
