# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

demo_user = User.find_or_create_by(email: "htekayadi@gmail.com", password: "password", name: "Hendrik Tekayadi", pro_pic_url: "https://media.licdn.com/dms/image/C5103AQFAqlxQSZu0tA/profile-displayphoto-shrink_200_200/0?e=1555545600&v=beta&t=MlW4D4Ksi0wD-251j_FDkQPLsiGIYP4-xR-6j2F5b7Q")

w1 = UserWhitelist.find_or_create_by(email: "yinglan@insignia.vc")
w2 = UserWhitelist.find_or_create_by(email: "ridy@insignia.vc")
w3 = UserWhitelist.find_or_create_by(email: "aldi@insignia.vc")
w4 = UserWhitelist.find_or_create_by(email: "indra@insignia.vc")
w4 = UserWhitelist.find_or_create_by(email: "hendrik@insignia.vc")


#Create Questions
q1 = Question.find_or_create_by(body: 'How do I build a team for my tech project?', author_id: demo_user.id)
q2 = Question.find_or_create_by(body: 'What is series A funding for a startup?', author_id: demo_user.id)

#Create Topics
t1 = Topic.find_or_create_by(name: "Business", pic_url: "https://s3-ap-southeast-1.amazonaws.com/qna-resources/assets/business.png")
t2 = Topic.find_or_create_by(name: "Hiring", pic_url: "https://s3-ap-southeast-1.amazonaws.com/qna-resources/assets/hiring.png")
t3 = Topic.find_or_create_by(name: "Marketing", pic_url: "https://s3-ap-southeast-1.amazonaws.com/qna-resources/assets/marketing.png")
t4 = Topic.find_or_create_by(name: "Product", pic_url: "https://s3-ap-southeast-1.amazonaws.com/qna-resources/assets/product.png")
t5 = Topic.find_or_create_by(name: "Technology", pic_url: "https://s3-ap-southeast-1.amazonaws.com/qna-resources/assets/technology.png")

a1 = Answer.find_or_create_by(body: "<p><span style=\"color: rgb(51, 51, 51);\">There is no 'right' answer to this question, but usually when one refers to a 'Series A' investment, they are referring to their first institutional round of capital (i.e. from a venture capital firm). Most startups raise a seed or angel round between $25K and $1M. Seed and angel investment are usually made by high net worth individuals.&nbsp;</span></p><p><br></p><p><span style=\"color: rgb(51, 51, 51);\">Once you've reached certain milestones (ironically, none of them are set in stone) one of two things will happen 1) you'll begin to talk to venture capital firms about making an investment or 2) venture capital firms will begin calling you about making an investment. If you are lucky enough to close on this investment you'll call it your 'Series A'. The next round will be Series B and so on until you file for an IPO or get bought/sold.&nbsp;</span></p><p><br></p><p><span style=\"color: rgb(51, 51, 51);\">There is nothing magical about these terms, but they make it easier for everyone to understand your stage.</span></p>", author_id: demo_user.id, question_id: q2.id)
a2 = Answer.find_or_create_by(body: "<p><strong>Stage#1: Forming</strong></p><blockquote>Where teams are formed, responsibilities are not understood properly yet, members are getting to know each other</blockquote><p>Points of failures during Forming stage:</p><ol><li>Getting people motivated enough to sign up &amp; go through your screening process</li><li>Assessing skills &amp; cultural fit accurately</li><li>Offer to join the team</li><li>On-boarding</li><li>Assigning right roles &amp; responsibilities aligning goals</li></ol><p><br></p><p><strong>Stage#2: Storming</strong></p><blockquote>Where members start understanding goals, their roles &amp; responsibilities and start doing tasks to achieve the goals</blockquote><p>Points of failures during Storming stage:</p><ol><li>Making sure that each team member understands their roles &amp; responsibilities</li><li>Making sure that each team member understands the goal</li><li>Identifying conflicts</li><li>Give team members chance to build relationships with other team members</li></ol><p><br></p><p><strong>Stage#3: Norming</strong></p><blockquote>Where group members are learning to work well with each other as a team, conflicts arise due to different working styles of each team member</blockquote><p>Points of failures during Storming stage:</p><ol><li>Let team members resolve conflicts themselves first, it makes the relationship and team stronger</li><li>Solve conflicts for the team which they can't</li><li>Establish process to support the team to resolve challenges</li></ol><p><br></p><p><strong>Stage#4: Performing</strong></p><blockquote>Where members are working very well&nbsp;<strong>as a team</strong>&nbsp;and moving forward. This is what we want to achieve.</blockquote><p>Here you have a performing team, you just need to nurture it to keep it consistent and you may fail at that if you fail in providing constructive feedback</p><p>I use this as definitive checklist while building teams, this enforces that I follow right path every-time. You should too, because failing at any step means a lot more work later on, sometimes outright failure.</p><p>P.S.: It takes time to internalize this completely. If you don’t have enough time/money to experiment(minimum 12 months to get this right), you should look for professional solutions.</p>", author_id: demo_user.id, question_id: q1.id)

#Add Questions to Topics
q1.topics += [t2]
q2.topics += [t1]

#Create comments
c1 = Comment.build_from(a1, demo_user.id, "Hope this will be helpful")
c2 = Comment.build_from(a2, demo_user.id, "Thank you for reading")

[c1,c2].each{|c| c.save!}


#Make users follow topics and questions
[t1, t2, q1, q2].each{|followable| demo_user.follow(followable)}

# #Make users upvote questions and answers
# [q3, a4, a3].each{|entity| demo_user.upvote(entity)}
# [q1, q3, q6, a4].each{|entity| user2.upvote(entity)}


# #Make users downvote questions and answers
# [a13, a2].each{|entity| demo_user.downvote(entity)}


# # give topics, questions, and answers a random amount of initial follows/upvotes
# Topic.all.each do |topic|
#   topic.update_attribute(:num_initial_follows, 10000*rand)
# end

# Question.all.each do |question|
#   question.update_attribute(:num_initial_follows, 500*rand)
# end

# Answer.all.each do |answer|
#   answer.update_attribute(:num_initial_upvotes, 1000*rand)
# end


# #Give queestions, answers, and comments fake timestamps
# Question.all.each do |question|
#   some_days_ago = Time.at(Time.now.to_f -  365.days.to_f*rand)

#   some_less_days_ago = Time.at(Time.now.to_f -  (Time.now.to_f-some_days_ago.to_f)*rand)

#   question.update_attributes(created_at: some_days_ago, updated_at: some_less_days_ago)
# end

# Answer.all.each do |answer|
#   question_created_ago = (Time.now.to_f - answer.question.created_at.to_f)

#   some_days_ago = Time.at(Time.now.to_f -  question_created_ago*rand)

#   some_less_days_ago = Time.at(Time.now.to_f -  some_days_ago.to_f*rand)

#   answer.update_attributes(created_at: some_days_ago, updated_at: some_less_days_ago)

#   answer.commentIds.each do |comment_id|
#     comment = Comment.find(comment_id)
#     comment_days_ago = Time.at(Time.now.to_f -  some_days_ago.to_f*rand)
#     comment_less_days_ago = Time.at(Time.now.to_f -  comment_days_ago.to_f*rand)
#     comment.update_attributes(created_at: comment_days_ago, updated_at: comment_less_days_ago)
#   end
# end
