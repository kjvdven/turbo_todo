# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "📝 Seeding tasks..."

# Optional: destroy all tasks to start with a clean database
Task.destroy_all

# Fill the database with data from the fixtures
system("bin/rails db:fixtures:load FIXTURES=tasks")

# Find invalid tasks
invalid_tasks = Task.all.reject(&:valid?)

# Remove invalid tasks
if invalid_tasks.any?
  puts "\n❌ Removing invalid tasks:"
  invalid_tasks.each do |task|
    puts "- #{task.title}: #{task.errors.full_messages.join(', ')}"
    task.destroy
  end
end

puts "✅ Seeding completed! #{Task.count} tasks created."

# Load all fixtures
# system("bin/rails db:fixtures:load")
