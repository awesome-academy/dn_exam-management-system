puts "Seeding data"
admin = User.new(
  first_name: "admin",
  last_name: "admin",
  email: "admin@gmail.com",
  password: "123123",
  password_confirmation: "123123",
  role: 0
)
admin.skip_confirmation!
admin.save!
user = User.new(
  first_name: "user",
  last_name: "user",
  email: "user@gmail.com",
  password: "123123",
  password_confirmation: "123123",
  role: 1
)
user.skip_confirmation!
user.save!
user2 = User.new(
  first_name: "user2",
  last_name: "user2",
  email: "user2@gmail.com",
  password: "123123",
  password_confirmation: "123123",
  role: 1
)
user2.skip_confirmation!
user2.save!

50.times do |n|
  subject_name = "Môn học của " + Faker::Name.name
  Subject.create!(
    user_id: User.first.id,
    content: "Đây là content thứ #{n+1}",
    name: subject_name
  )
end

50.times do |n|
  subject_name = "Môn học của " + Faker::Name.name
  Subject.create!(
    user_id: User.first.id,
    content: "Đây là content thứ #{n+1}",
    status: false,
    name: subject_name
  )
end

10.times do |n|
  Question.create!(
    subject_id: 50,
    content: Faker::Emotion.noun
  )
end

10.times do |n|
  Question.create!(
    subject_id: 49,
    content: Faker::Emotion.noun
  )
end

questions = Question.all
questions.each do |question|
  4.times do |m|
    true_asnwer = m == 0 ? :true_answer : :false_answer
    q = question.answers.build content: Faker::Emotion.noun, is_correct: true_asnwer
    q.save!
  end
end

users = User.all
users.each do |user|
  5.times do |n|
    Exam.create!(
      user_id: user.id,
      subject_id: n + 1,
      spent_time: 120,
      score: n%11
    )
  end
end


puts "Done!!!"
