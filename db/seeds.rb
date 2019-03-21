# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
demo_user = User.find_by(email: "user01@mail.com")
unless demo_user
	demo_user = User.create(
		email: "user01@mail.com",
		name: "User Demo",
		pro_pic_url: "https://media.licdn.com/dms/image/C5103AQFAqlxQSZu0tA/profile-displayphoto-shrink_200_200/0?e=1555545600&v=beta&t=MlW4D4Ksi0wD-251j_FDkQPLsiGIYP4-xR-6j2F5b7Q",
		access_token: "ya29.GlzSBjgyQmkLKy7crAk_-3UnmZ9UgQh2tFxB-MZxpIPBwuRR9rGVRIM-ViV9m0PMFWib-knTBk83k_A4_hFvqajjMFPFeJYIVW5dl-xPzI87Ipv0viHSGfsCj8l3Eg")
end

w1 = UserWhitelist.find_or_create_by(email: "yinglan@insignia.vc")
w2 = UserWhitelist.find_or_create_by(email: "ridy@insignia.vc")
w3 = UserWhitelist.find_or_create_by(email: "aldi@insignia.vc")
w4 = UserWhitelist.find_or_create_by(email: "indra@insignia.vc")
w4 = UserWhitelist.find_or_create_by(email: "hendrik@insignia.vc")


#Create Questions
q1 = Question.find_or_create_by(body: 'How to hire great engineers?', author_id: demo_user.id)
q2 = Question.find_or_create_by(body: 'What is series A funding for a startup?', author_id: demo_user.id)

#Create Topics
t1 = Topic.find_or_create_by(name: "Business", pic_url: "https://s3-ap-southeast-1.amazonaws.com/qna-resources/assets/business.png", description: "")
t2 = Topic.find_or_create_by(name: "Hiring", pic_url: "https://s3-ap-southeast-1.amazonaws.com/qna-resources/assets/hiring.png", description: "")
t3 = Topic.find_or_create_by(name: "Marketing", pic_url: "https://s3-ap-southeast-1.amazonaws.com/qna-resources/assets/marketing.png", description: "")
t4 = Topic.find_or_create_by(name: "Product", pic_url: "https://s3-ap-southeast-1.amazonaws.com/qna-resources/assets/product.png", description: "")
t5 = Topic.find_or_create_by(name: "Technology", pic_url: "https://s3-ap-southeast-1.amazonaws.com/qna-resources/assets/technology.png", description: "")

a2 = Answer.find_or_create_by(body: "<p>1. Use many candidate sources. Recruiting is ultimately a numbers game. Increase your chances of “winning” by boosting the top of your funnel. At Storyblocks we’ve used many channels successfully: former co-workers; referrals; filtered “marketplaces” like Hired.com and Vettery; job boards like HackerNews, StackOverflow, AngelList; an inbound career site; on-campus college recruiting; and of course recruiters.</p><p><br></p><p>2. Structure your interview process. We employ two phone screens and an onsite with five technical interviews plus a culture screen during lunch. We use a scorecard for grading candidates on a common set of skills / traits from 1 to 4. Everyone on our engineering team is invited to the follow up discussion. Successful hiring decisions require at least one “champion” (overall score of 4). Anyone involved in the hiring process can veto a hire. While you don’t necessarily need to use our system, you should employ some system that everyone on your team understands. Not only does it make hiring easier, it makes your team look more professional from the candidate’s perspective and gives you a better chance of closing a hire.</p><p><br></p><p>3. Look for the right things. Evaluation is an extremely important part of the hiring process. Ideally you can develop a methodology that allows you to distinguish 1x from 10x from 100x engineers. While assessing candidates’ technical abilities is a no brainer, you should also consider seven other skills / traits: grit, rigor, impact, teamwork, ownership, curiosity, and polish. There’s also another framework you could use to evaluate candidates, the “ABCEF’s of Technical Hiring”: agility, brains, communication, drive, empathy, and fit.</p>", author_id: demo_user.id, question_id: q1.id)
a1 = Answer.find_or_create_by(body: "<p><span style=\"color: rgb(51, 51, 51);\">There is no 'right' answer to this question, but usually when one refers to a 'Series A' investment, they are referring to their first institutional round of capital (i.e. from a venture capital firm). Most startups raise a seed or angel round between $25K and $1M. Seed and angel investment are usually made by high net worth individuals.&nbsp;</span></p><p><br></p><p><span style=\"color: rgb(51, 51, 51);\">Once you've reached certain milestones (ironically, none of them are set in stone) one of two things will happen 1) you'll begin to talk to venture capital firms about making an investment or 2) venture capital firms will begin calling you about making an investment. If you are lucky enough to close on this investment you'll call it your 'Series A'. The next round will be Series B and so on until you file for an IPO or get bought/sold.&nbsp;</span></p><p><br></p><p><span style=\"color: rgb(51, 51, 51);\">There is nothing magical about these terms, but they make it easier for everyone to understand your stage.</span></p>", author_id: demo_user.id, question_id: q2.id)

#Add Questions to Topics
q1.topics += [t2]
q2.topics += [t1]

#Create comments
c1 = Comment.build_from(a1, demo_user.id, "Hope this will be helpful")
c2 = Comment.build_from(a2, demo_user.id, "Thank you for reading")

c3 = Comment.build_from(q1, demo_user.id, "Hope this will be helpful")
c4 = Comment.build_from(q2, demo_user.id, "Thank you for reading")

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
