require 'rails_helper'

feature 'User can generate pdf tasks report' do
  let(:user) { create(:user) }

  before do
    login_as(user)
    create(:profile, user: user)
  end

  scenario 'Successfully' do
    create(:task, :complete, user: user)
    create(:task, :incomplete, user: user)

    visit root_path
    click_on 'Tasks Report'
    click_on 'Generate PDF'

    expect(page).to have_selector('tbody tr', count: user.tasks.count)
    expect(page).to have_content('Tasks Report')
  end

  scenario 'And must have at least one task if all is selected' do
    visit report_path
    click_on 'Generate PDF'

    expect(page).to have_content('You need at least one task to generate the report')
    expect(page).to have_selector(:css, "p.alert")
  end

  scenario 'And must have at least one task of chosen status' do
    create(:task, :complete, user: user)

    visit report_path
    click_on 'Incomplete'
    click_on 'Generate PDF'

    expect(page).to have_content('You need at least one task to generate the report')
    expect(page).to have_selector(:css, "p.alert")
  end

end
