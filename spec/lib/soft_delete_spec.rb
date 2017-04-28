require 'spec_helper'

describe SoftDelete, type: :lib do
  before(:all) do
    DatabaseCleaner.clean_with :truncation
    DatabaseCleaner.strategy = :transaction
  end


  describe 'soft delete' do
    it "should soft delete the record and it association" do
      task_1 = FactoryGirl.create(:task, name: "task1")
      task_2 = FactoryGirl.create(:task, name: "task2")
      document_1 = FactoryGirl.create(:document, task_id: task_1.id)
      document_2 = FactoryGirl.create(:document, task_id: task_2.id)
      expect(Task.count).to eq(2)
      expect(Document.count).to eq(2)
      puts  "**task****count***#{Task.count}****before soft delete*********"
      puts  "**document****count***#{Document.count}****before soft delete*********"
      task_1.soft_delete
      puts  "**task****count***#{Task.count}****after soft delete*********"
      puts  "**document****count***#{Document.count}****after soft delete*********"
       expect(Task.count).to eq(1)
      expect(Document.count).to eq(1)
    end
  end

  describe 'hard delete' do
    it "should soft delete the record and it association" do
      task_1 = FactoryGirl.create(:task, name: "task1")
      task_2 = FactoryGirl.create(:task, name: "task2")
      document_1 = FactoryGirl.create(:document, task_id: task_1.id)
      document_2 = FactoryGirl.create(:document, task_id: task_2.id)
      expect(Task.count).to eq(3)
      expect(Document.count).to eq(3)
      puts  "**task****count***#{Task.count}****before soft delete*********"
      puts  "**document****count***#{Document.count}****before soft delete*********"
      task_1.hard_delete
      puts  "**task****count***#{Task.count}****after soft delete*********"
      puts  "**document****count***#{Document.count}****after soft delete*********"
       expect(Task.count).to eq(2)
      expect(Document.count).to eq(2)
    end
  end
end
