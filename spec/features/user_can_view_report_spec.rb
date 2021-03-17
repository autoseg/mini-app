require 'rails_helper'

feature 'User can view completed tasks report' do

  let(:user) { create(:user) }

  context 'As a logged user' do

    before do
      login_as(user)
    end

    scenario 'Successfully' do
      create(:task, :complete, user: user)
      create(:task, :complete, user: user)
      create(:task, :complete, user: user)

      visit root_path
      click_on 'Tasks Report'

      expect(page).to have_content('Tasks Report')
      expect(page).to have_selector('tbody tr', count: user.tasks.count)
      expect(current_path).to eq(report_path)
    end

    context 'And filter by status' do
      before do
        create(:task, :complete, user: user)
        create(:task, :complete, user: user)
        create(:task, :incomplete, user: user)
        create(:task, :incomplete, user: user)

        visit root_path
        click_on 'Tasks Report'
      end

      scenario 'And show all tasks' do
        click_on 'Incomplete'
        click_on 'All'

        expect(page).to have_selector('tbody tr', count: 4)
        expect(page).to have_content(Task.first.title)
        expect(page).to have_content(Task.first.title)
      end

      scenario 'And show only complete tasks' do
        click_on 'Completed'

        expect(page).to have_selector('tbody tr', count: 2)
        expect(page).to have_content(Task.first.title)
        expect(page).not_to have_content(Task.last.title)
      end

      scenario 'And show only incomplete tasks' do
        click_on 'Incomplete'

        expect(page).to have_selector('tbody tr', count: 2)
        expect(page).to have_content(Task.last.title)
        expect(page).not_to have_content(Task.first.title)
      end
    end
  end

  scenario 'And must be loged in' do
    visit report_path

    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
