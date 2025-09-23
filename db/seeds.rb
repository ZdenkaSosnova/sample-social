# 1. Main Admin User
admin = User.create!(
  name:  "Admin User",
  email: "admin@example.com",
  password:              "password",
  password_confirmation: "password",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

# 2. Regular Test User
alice = User.create!(
  name:  "Alice TestUser",
  email: "alice@example.com",
  password:              "password",
  password_confirmation: "password",
  activated: true,
  activated_at: Time.zone.now
)
alice.create_welcome_post

# 3. Another Regular User
bob = User.create!(
  name:  "Bob DemoUser",
  email: "bob@example.com",
  password:              "password",
  password_confirmation: "password",
  activated: true,
  activated_at: Time.zone.now
)
bob.create_welcome_post

# 4. Second Admin
admin2 = User.create!(
  name:  "Admin Two",
  email: "admin2@example.com",
  password:              "password",
  password_confirmation: "password",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

puts "Creating microposts..."

# Admin posts - professional announcements
admin.microposts.create!(
  content: "Welcome to SampleSocial! We're excited to have you here.",
  visibility: "public"
)

admin.microposts.create!(
  content: "Platform maintenance scheduled for this weekend. Stay tuned for updates.",
  visibility: "public"
)

# Alice's posts - mix of public and followers-only
alice.microposts.create!(
  content: "Just discovered this amazing coffee shop downtown! ☕",
  visibility: "public"
)

alice.microposts.create!(
  content: "Thoughts on the new project... might need your input, friends!",
  visibility: "followers_only"
)

alice.microposts.create!(
  content: "Beautiful sunset today! Nature never fails to amaze.",
  visibility: "public"
)

# Bob's posts - active user with varied content
bob.microposts.create!(
  content: "Started learning Ruby on Rails this week. Any tips for beginners?",
  visibility: "public"
)

bob.microposts.create!(
  content: "My secret recipe for chocolate chip cookies 🍪",
  visibility: "followers_only"
)

bob.microposts.create!(
  content: "Just finished reading 'The Pragmatic Programmer'. Highly recommend!",
  visibility: "public"
)

bob.microposts.create!(
  content: "Weekend hiking trip photos - only sharing with my close friends!",
  visibility: "followers_only"
)

# Admin2 posts - secondary admin content
admin2.microposts.create!(
  content: "New features rolling out next week. Check out our changelog!",
  visibility: "public"
)

puts "Creating polls..."

# Alice's poll
alice_poll = alice.polls.create!(
  question: "What's your favorite programming language?",
  poll_options_attributes: [
    { option_text: "Ruby" },
    { option_text: "Python" },
    { option_text: "JavaScript" }
  ]
)

# Bob's poll
bob_poll = bob.polls.create!(
  question: "Coffee or Tea?",
  poll_options_attributes: [
    { option_text: "Coffee" },
    { option_text: "Tea" },
    { option_text: "Coffee" },
    { option_text: "Tea" }
  ]
)

puts "Creating following relationships..."

# Alice follows Bob and admin
alice.follow(bob)
alice.follow(admin)

# Admin follows both regular users (to monitor content)
admin.follow(alice)
admin.follow(bob)

# Bob also follows the main admin for updates
bob.follow(admin)

puts "\n" + "="*60
puts " SEED DATA CREATED SUCCESSFULLY! "
puts "="*60

puts "\n📊 Database Summary:"
puts "  • #{User.count} users (#{User.where(admin: true).count} admins, #{User.where(admin: false).count} regular users)"
puts "  • #{Micropost.count} microposts (#{Micropost.where(visibility: 'public').count} public, #{Micropost.where(visibility: 'followers_only').count} followers-only)"
puts "  • #{Poll.count} polls with #{PollOption.count} total options"
puts "  • #{Relationship.count} following relationships"

puts "\n🔐 Login Credentials:"
puts "="*60
puts "  Admin Account:"
puts "    Email: admin@example.com"
puts "    Password: password"
puts ""
puts "  Regular Users:"
puts "    Alice - Email: alice@example.com | Password: password"
puts "    Bob   - Email: bob@example.com   | Password: password"
puts ""
puts "  Second Admin:"
puts "    Email: admin2@example.com"
puts "    Password: password"
puts "="*60

puts "\n📝 Following Relationships:"
puts "  • Alice follows: Bob, Admin"
puts "  • Bob follows: Admin"
puts "  • Admin follows: Alice, Bob"
puts "  • Admin2 follows: nobody"

puts "\n✅ You can now log in with any of the above credentials!"