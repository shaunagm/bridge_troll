require 'rails_helper'

describe 'creating or editing an rsvp' do
  context "for a teaching event" do
    let(:no_preference_text) { 'No preference' }
    before do
      @event = create(:event)
      @user = create(:user)
      sign_in_as @user
    end

    context "given a new volunteer rsvp" do
      before do
        visit volunteer_new_event_rsvp_path(@event)
      end

      it "should not show checkboxes for events with only one session" do
        @event.event_sessions.length.should == 1
        page.should_not have_content(@event.event_sessions.first.name)
      end

      it "should show option for any class level" do
        page.should have_content no_preference_text
      end

      it "should have a code of conduct checkbox" do
        page.should have_unchecked_field('coc')
      end

      context "with a valid RSVP" do
        before do
          fill_in "rsvp_subject_experience", with: "asdfasdfasdfasd"
          fill_in "rsvp_teaching_experience", with: "asdfasdfasdfasd"
          choose Course.find_by_name('OSCTCfull').levels[0][:title]
        end

        it "should allow the user to update their gender" do
          expect(page.find("#user_gender").value).to eq(@user.gender)
          fill_in "user_gender", with: "human"
          click_on "Submit"
          visit edit_user_registration_path
          expect(page.find("#user_gender").value).to eq("human")
        end

        it "should allow the user to affiliate themselves with the event's chapter" do
          check 'affiliate_with_chapter'
          expect {
            click_on "Submit"
          }.to change { @user.chapters.count }.by(1)
          visit edit_event_rsvp_path(@event, Rsvp.last)
          expect(page.find("#affiliate_with_chapter").value).to eq("1")
        end
      end

      describe 'code of conduct' do
        let(:coc_text) { 'I accept the Code of Conduct' }

        context 'for new records', js: true do
          it "must be checked before the RSVP is accepted" do
            page.should have_content(coc_text)

            page.should have_button 'Submit', disabled: true
            check('coc')
            page.should have_button 'Submit', disabled: false
          end

          it "preserves checked-ness on errors" do
            page.should have_unchecked_field('coc')
            check('coc')

            click_on 'Submit'

            page.should have_css('#error_explanation')
            page.should have_checked_field('coc')
          end
        end

        context 'for existing records' do
          let(:rsvp) { create(:rsvp, user: @user) }

          it 'is not shown' do
            visit edit_event_rsvp_path rsvp.event, rsvp
            page.should have_no_content(coc_text)
          end
        end
      end

      context 'with an invalid RSVP' do
        it 'should maintain state when the form is submitted' do
          check 'Vegetarian'

          click_on 'Submit'

          expect(find_field('Vegetarian')).to be_checked
        end
      end
    end

    context 'given an rsvp with dietary restrictions' do
      let(:rsvp) {
        create(:rsvp,
          user: @user,
          dietary_restrictions: [build(:dietary_restriction, restriction: 'vegetarian')]
        )
      }
      let(:form_url) { edit_event_rsvp_path(rsvp.event, rsvp) }

      it 'allows user to change them' do
        visit form_url
        check 'Vegan'
        uncheck 'Vegetarian'
        click_on 'Submit'

        visit form_url
        expect(find_field('Vegan')).to be_checked
        expect(find_field('Vegetarian')).not_to be_checked
      end
    end

    describe "a new learn rsvp" do
      it "should show rails levels for rails events" do
        visit learn_new_event_rsvp_path(@event)
        page.should have_content Course.find_by_name('OSCTCfull').levels[0][:title]
      end

      it "should show frontend levels for frontend events" do
        @event.update_attributes(:course_id => Course::OSCTCFULL.id)
        @event.save!

        visit learn_new_event_rsvp_path(@event)
        page.should have_content Course.find_by_name('OSCTCfull').levels[0][:title]
      end

      it "should not allow students to have 'No preference'" do
        visit learn_new_event_rsvp_path(@event)
        page.should_not have_content no_preference_text
      end

    end
  end

  context "for a non-teaching event" do
    before do
      @event = create(:event, course_id:nil)
      @user = create(:user)
      sign_in_as @user
      visit volunteer_new_event_rsvp_path(@event)
    end

    it "should not show teaching UI" do
      page.should_not have_content "What's your experience with teaching?"
      page.should_not have_content "Teaching"
      page.should_not have_content "TAing"
      page.should_not have_content "Do you have a class level preference?"
    end

    it "should require subject experience" do
      fill_in "rsvp_subject_experience", with: "I organized the February workshop after attending one in January"
      click_on "Submit"
      page.should have_content "Thanks for signing up!"
    end
  end
end
