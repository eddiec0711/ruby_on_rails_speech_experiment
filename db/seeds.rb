# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(
    email: 'test@test.com', 
    password: 'password', 
    password_confirmation: 'password',
    name: 'Test User',
    country: 'United Kingdom',
    research_level: 'Undergraduate',
    admin: true
  )
  user.save!

client_account = User.new(
    email: 'c.montgomery@sheffield.ac.uk', 
    password: 'password', 
    password_confirmation: 'password',
    name: 'Chris Montgomery',
    country: 'United Kingdom',
    research_level: 'Staff',
    admin: true
  )
  client_account.save!

# experiment = user.experiments.create(name: "Test experiment", description: "An experiment to test user dashboard")
# qtask1 = QuestionTask.create(name: "Test question task")
# qtask2 = QuestionTask.create(name: "A different test question task")
# stask1 = SampleTask.create(name: "Test sample task")
# stask2 = SampleTask.create(name: "Test sample task 2")
# experiment.tasks << [qtask1, stask1, qtask2, stask2]
# ltask1 = ListeningTask.create(name: "Test listening task")
# ltask2 = ListeningTask.create(name: "Test listening task sample 2")
# ctask1 = ClickTask.create(name: "Test click task", prompt: "A test click task prompt")
# qtask3 = QuestionTask.create(name: "Test sample question task")
# stask1.tasks << [ltask1.acting_as, ctask1.acting_as, qtask3.acting_as]
# stask2.tasks << [ltask2.acting_as]
# t1 = Question::Text.create(prompt: 'First name')
# d1 = Question::Dropdown.create(prompt: 'Title')
# t2 = Question::Text.create(prompt: 'Last name')
# op1 = Option.create(contents: 'Mr.')
# op2 = Option.create(contents: 'Mrs.')
# r1 = Question::Rating.create(prompt: 'Rate this experiment')
# s1 = Scale.create(bins: 7, high: 'Good', low: 'Bad')
# rd1 = Question::Radio.create(prompt: 'Religion')
# op3 = Option.create(contents: 'None')
# op4 = Option.create(contents: 'Christian')
# c1 = Question::Checkbox.create(prompt: 'Have you visited')
# op5 = Option.create(contents: 'UK')
# op6 = Option.create(contents: 'Australia')
# t3 = Question::Text.create(prompt: 'Example question')
# t4 = Question::Text.create(prompt: 'Sample question')


# r1.scale = s1
# qtask1.questions << [t1, d1, r1, t2, rd1, c1]
# qtask2.questions << [t3]
# qtask3.questions << [t4]
# d1.options << [op1, op2]
# rd1.options << [op3, op4]
# c1.options << [op5, op6]

