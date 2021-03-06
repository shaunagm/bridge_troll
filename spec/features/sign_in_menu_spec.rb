require 'rails_helper'
require Rails.root.join('spec', 'services', 'omniauth_responses')

describe "sign in lightbox" do
  before do
    @user = create(:user)
  end

  it "should show on home page on click" do
    visit "/"
    page.find('#sign_in_dialog', :visible => false)
    click_link('Sign In')
    page.find('#sign_in_dialog', :visible => true)
  end

  it "should not show if signed in" do
    sign_in_as(@user)
    visit "/"
    page.should have_link("Sign Out")
    page.should_not have_link("Sign in")
  end

  describe "when the user visits an authenticated page, then leaves and goes to an unauthenticated one", js: true do
    before do
      visit "/users"
      within '.alert' do
        page.should have_content('sign in')
      end
      visit "/about"
      page.should have_content('About RailsBridge')
    end

    context "with password auth" do
      it "always returns the user to the current page, instead of the last path Devise remembers" do
        within ".navbar" do
          click_on 'Sign In'
        end

        sign_in_with_modal(@user)

        page.should have_content('Signed in successfully')
        page.should have_content('About RailsBridge')
      end
    end

#    context "with omniauth" do
#      let(:facebook_response) { OmniauthResponses.facebook_response }

#      before do
#        OmniAuth.config.test_mode = true
#        OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(facebook_response)
#        @user.authentications.create(provider: :facebook, uid: facebook_response[:uid])
#      end

#      it "always returns the user to the current page, instead of the last path Devise remembers" do
#        within ".navbar" do
#          click_on 'Sign In'
#        end

#        within "#sign_in_dialog" do
#          click_on 'Facebook'
#        end

 #       page.should have_content('Facebook login successful')
 #       page.should have_content('About RailsBridge')
 #     end
 #   end
  end
end

describe "user" do
  before do
    @user = create(:user)
  end

  it "should be able to sign in from the home page" do
    visit "/"
    within("#sign_in_dialog") do
      fill_in "Email", :with => @user.email
      fill_in "Password", :with => @user.password
      click_button "Sign in"
    end
    page.should have_content("Signed in successfully")
  end
end
