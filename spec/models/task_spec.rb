require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'Is created with default share status nil' do
    expect(Task.new.share).to eq nil
  end

  it 'Is created with default \'status\' value os 0' do
    expect(Task.new.status.to_i).to eq 0
  end

  it 'Is created with default priority of 0' do
    expect(Task.new.priority.to_i).to eq 0
  end

  it 'Is valid' do
    valid_task = build(:task, title: 'Some title', description: 'Some description')
    valid_task.valid?

    expect(valid_task).to be_valid
  end

  context 'Is invalid' do
    it 'If title smaller then 4 characters' do
      invalid_task = build(:task, title: '')
      invalid_task.valid?

      expect(invalid_task).not_to be_valid
      expect(invalid_task.errors[:title]).to include('is too short (minimum is 4 characters)')
    end

    it 'If title bigger then 20 characters' do
      invalid_task = build(:task, title: 'a' * 21)
      invalid_task.valid?

      expect(invalid_task).not_to be_valid
      expect(invalid_task.errors[:title]).to include('is too long (maximum is 20 characters)')
    end

    it 'If description is blank' do
      invalid_task = build(:task, description: nil)
      invalid_task.valid?

      expect(invalid_task).not_to be_valid
      expect(invalid_task.errors[:description]).to include('can\'t be blank')
    end

    it 'If description bigger then 280 characters' do
      invalid_task = build(:task, description: 'a' * 281)
      invalid_task.valid?

      expect(invalid_task).not_to be_valid
      expect(invalid_task.errors[:description]).to include('is too long (maximum is 280 characters)')
    end
  end

  context '#order_by' do
    let(:user) { create(:user) }

    let!(:task1) { create(:task, title: 'BBBB', user: user, priority: 'medium', status: 0) }
    let!(:task2) { create(:task, title: 'AAAA', user: user, priority: 'low', status: 0) }
    let!(:task3) { create(:task, title: 'CCCC', user: user, priority: 'high', status: 10) }

    it 'Must be ordered by date(desc)' do
      tasks = user.tasks.order_by('newest')

      expect(tasks.first.title).to eq(task3.title)
    end

    it 'Must be ordered by date(asc)' do
      tasks = user.tasks.order_by('newest')
      tasks = user.tasks.order_by('oldest')

      expect(tasks.first.title).to eq(task1.title)
    end

    it 'Must be ordered by priority(desc)' do
      tasks = user.tasks.order_by('lowest_priority')
      expect(tasks.first.title).to eq(task2.title)
    end

    it 'Must be ordered by priority(asc)' do
      tasks = user.tasks.order_by('highest_priority')

      expect(tasks.first.title).to eq(task3.title)
    end

    it 'Must be ordered by status(desc)' do
      tasks = user.tasks.order_by('incomplete_first')
      tasks = user.tasks.order_by('complete_first')

      expect(tasks.first.status).to eq('complete')
    end

    it 'Must be ordered by status(asc)' do
      tasks = user.tasks.order_by('incomplete_first')

      expect(tasks.first.status).to eq('incomplete')
    end

    it 'Must be ordered by title(desc)' do
      tasks = user.tasks.order_by('title(desc)')

      expect(tasks.first.title).to eq(task3.title)
    end

    it 'Must be ordered by title(asc)' do
      tasks = user.tasks.order_by('title(asc)')

      expect(tasks.second.title).to eq(task1.title)
    end
  end
end
