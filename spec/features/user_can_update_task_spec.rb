require 'rails_helper'

feature 'User can update Tasks' do

  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  scenario 'And must be logged in' do
    visit '/tasks/1/edit'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  context 'As a logged user' do
    before do
      login_as(user)
      create(:profile, user: user)
    end

    scenario 'Successfully' do
      visit task_path(task)
      click_on 'Edit'

      fill_in 'Title', with: 'Edited Title'
      fill_in 'Description', with: 'Edited Description'
      select 'High', from: 'Priority'

      click_on 'Save'

      expect(page).to have_content('Task Updated!')
      expect(current_path).to eq(task_path(user.tasks.last))
      expect(Task.last.title).to eq('Edited Title')
      expect(Task.last.priority).to eq('high')
      expect(Task.last.description).to eq('Edited Description')
    end

    scenario 'And must fill all fields' do
      visit task_path(task)
      click_on 'Edit'

      fill_in 'Title', with: 'Test'
      fill_in 'Description', with: ''

      click_on 'Save'

      expect(page).to have_content('Description can\'t be blank')
    end

    scenario 'And Must be owner' do
      other_user = create(:user)
      other_task = create(:task, user: other_user)

      visit task_path(other_task)

      expect(page).not_to have_selector(:link_or_button, 'Edit')
    end

    scenario 'And Must be an incomplete task' do
      incomplete_task = create(:task, user: user, status: 'complete')

      visit task_path(incomplete_task)
      click_on 'Edit'

      expect(page).to have_content('Cannot edit completed task!')
    end
  end
end
