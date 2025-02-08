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

Task.destroy_all # Optioneel: Verwijder bestaande taken om dubbele records te voorkomen

tasks = [
  { title: "Boodschappen doen", description: "Koop melk, eieren en brood", status: "open" },
  { title: "Workout", description: "30 minuten cardio en krachttraining", status: "open" },
  { title: "Boek lezen", description: "Lees 20 pagina's van je huidige boek", status: "completed" },
  { title: "Project starten", description: "Begin met de eerste feature van je Rails-project", status: "open" }
]

tasks.each do |task|
  Task.create!(task)
end

puts "✅ Seeding completed! #{Task.count} tasks created."
