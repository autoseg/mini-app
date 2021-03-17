require 'rails_helper'

feature 'User can Delete Tasks' do

  let(:user) { create(:user) }

  before do
    create(:profile, user: user)
    login_as(user)
  end

  scenario 'Successfully' do
    task = create(:task, user: user)

    visit task_path(task)
    click_on 'Delete'

    expect(page).to have_content('Task Deleted!')
    expect(user.tasks).to be_blank
    expect { Task.find(task.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  scenario 'And Must be owner' do
    other_user = create(:user)
    task = create(:task, user: other_user)

    visit task_path(task)

    expect(page).not_to have_selector(:link_or_button, 'Delete')
  end
end
