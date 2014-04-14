require_relative '../feature_helper'

describe "Homepage" do
  it 'returns a 200' do
    visit '/'
    expect(page.status_code).to eq(200)
  end
end