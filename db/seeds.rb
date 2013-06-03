source = Source.where(name: 'twilio').first ||
           Source.create(name: 'twilio')

user = User.where(email: "example@example.com").first ||
         User.create(email: "example@example.com", password: "password")

oldest_time = Time.local(2013, 1, 1)
newest_time = Time.now

(1..100).each do |_|
  created_at = Time.at(oldest_time + rand * (newest_time.to_f - oldest_time.to_f))

  feeling = user.feelings.build(source: source,
                                source_event_id: rand(1000000),
                                score: rand(5) + 1)
  feeling.created_at = created_at
  feeling.save
end
