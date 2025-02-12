require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "should be valid with valid attributes" do
    task = Task.new(title: "Test task", description: "Test description", status: "in_progress")
    assert task.valid?
  end

  test "should be invalid without a title" do
    task = Task.new(title: nil)
    assert_not task.valid?
    assert_includes task.errors[:title], "can't be blank"
  end

  test "should be invalid with a title longer than 100 characters" do
    task = Task.new(title: "a" * 101)
    assert_not task.valid?
    assert_includes task.errors[:title], "is too long (maximum is 100 characters)"
  end

  test "should be invalid with a description longer than 500 characters" do
    task = Task.new(title: "Test task", description: "a" * 501)
    assert_not task.valid?
    assert_includes task.errors[:description], "is too long (maximum is 500 characters)"
  end

  test "should be invalid with an invalid status" do
    assert_raises ArgumentError do
      Task.new(title: "Test task", status: "invalid_status")
    end
  end

  test "should default to in progress status" do
    task = Task.create(title: "Test task")
    assert_equal "in_progress", task.status
    assert task.in_progress?
  end

  test "can be marked as completed" do
    task = Task.create(title: "Test task")
    task.completed!
    assert_equal "completed", task.status
    assert task.completed?
  end

  test "can be marked as in progress" do
    task = Task.create(title: "Test task")
    task.completed!
    task.in_progress!
    assert_equal "in_progress", task.status
    assert task.in_progress?
  end
end
