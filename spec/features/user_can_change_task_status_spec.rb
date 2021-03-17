require 'rails_helper'

feature 'User can change task status' do
  let(:user) { create(:user) }

  before do
    create(:profile, user: user)
    login_as(user)
  end

  scenario 'On show page from incomplete to complete' do
    task = create(:task, status: 'incomplete', user: user)

    visit task_path(task)
    click_on 'Complete task'

    expect(Task.last.status).to eq('complete')
    expect(user.tasks.completed.count).to eq(1)
  end

  scenario 'On show page from complete to incomplete' do
    task = create(:task, status: 'complete', user: user)

    visit task_path(task)
    click_on 'Open task'

    expect(Task.last.status).to eq('incomplete')
    expect(user.tasks.completed.count).to eq(0)
  end

  scenario 'And must be owner' do
    other_user = create(:user)
    task = create(:task, status: 'complete', user: other_user)

    visit task_path(task)

    expect(page).not_to have_content('Open task')
  end
end
