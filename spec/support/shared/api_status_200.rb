shared_examples_for 'API be_success' do
  it 'Returns 200 status' do
    expect(response).to be_success
  end
end
