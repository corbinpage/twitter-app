require 'spec_helper'

describe ApplicationController do
	describe 'GET #home' do
		it 'renders the :home template' do
			get :home
			expect(response).to render_template :home
		end
	end

	describe 'GET #update' do
		# it 'assigns Tweets to @tweet' do
		# 	get :update
		# 	@tweet = create(:tweet)
		# 	expect(response.body).to eq(response.body.to_json)
		# end
	end
end