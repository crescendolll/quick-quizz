require 'faker'

puts "Destroying all quiz results..."
QuizResult.destroy_all
puts "Destroying all answers..."
Answer.destroy_all
puts "Destroying all choices..."
Choice.destroy_all
puts "Destroying all questions..."
Question.destroy_all
puts "Destroying all recommendations..."
Recommendation.destroy_all
puts "Destroying all quizzes..."
Quiz.destroy_all
puts "Destroying all users..."
User.destroy_all

puts "Setting back primary key sequences..."
ActiveRecord::Base.connection.reset_pk_sequence!(QuizResult.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(Answer.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(Choice.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(Question.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(Recommendation.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(Quiz.table_name)
ActiveRecord::Base.connection.reset_pk_sequence!(User.table_name)

puts "Seeding new data..."
puts "Creating users..."
20.times do
  User.create!(
    email: Faker::Internet.email,
    username: Faker::Internet.username,
    password: '123456'
  )
end

puts "Creating quizzes (with questions and choices) for the second User..."

puts "...Panopticon quiz for the second User..."
panopt = Quiz.create!(user: User.second, title: "Panopticon", seed: true)
panopt.questions.create!([{ question: "What is the central concept of Foucault's view of panopticons?" },
                          { question: "According to Foucault, what effect does the panopticon design have on individuals?" },
                          { question: "The panopticon serves as a metaphor for which aspect of societal control?" },
                          { question: "In Foucault's view, what is the primary mechanism of power within the panopticon?" },
                          { question: "What does Foucault suggest is the ultimate goal of panoptic surveillance?" }])

panopt.questions.first.choices.create!([ { choice: "Totalitarian control", correct: false },
                                        { choice: "Individual autonomy", correct: false },
                                        { choice: "Constant surveillance", correct: true },
                                        { choice: "Collective freedom", correct: false } ])
panopt.questions.second.choices.create!([ { choice: "It fosters a sense of security", correct: false },
                                        { choice: "It encourages rebellion and resistance", correct: false },
                                        { choice: "It induces self-discipline and conformity", correct: true },
                                        { choice: "It promotes creativity and innovation", correct: false } ])
panopt.questions.third.choices.create!([ { choice: "Authoritarianism", correct: false },
                                        { choice: "Anarchism", correct: false },
                                        { choice: "Discipline", correct: true },
                                        { choice: "Democracy", correct: false } ])
panopt.questions.fourth.choices.create!([ { choice: "Physical force", correct: false },
                                        { choice: "Psychological manipulation", correct: true },
                                        { choice: "Economic coercion", correct: false },
                                        { choice: "Social norms", correct: false } ])
panopt.questions.fifth.choices.create!([ { choice: "Rehabilitation of individuals", correct: false },
                                        { choice: "Prevention of crime", correct: false },
                                        { choice: "Preservation of social order", correct: true },
                                        { choice: "Promotion of individual liberty", correct: false } ])
panopt.save!

puts "...taking the Panopticon quiz..."
qr1 = QuizResult.create!(quiz: panopt, user: User.second, result: 0, seed: true)
a1 = Answer.create!( choice: panopt.questions.first.choices.sample, quiz_result: qr1 )
a2 = Answer.create!( choice: panopt.questions.second.choices.sample, quiz_result: qr1 )
a3 = Answer.create!( choice: panopt.questions.third.choices.sample, quiz_result: qr1 )
a4 = Answer.create!( choice: panopt.questions.fourth.choices.sample, quiz_result: qr1 )
a5 = Answer.create!( choice: panopt.questions.fifth.choices.sample, quiz_result: qr1 )

puts "... and calculating the result based on the answers..."
qr1.result = qr1.answers.map(&:choice).select(&:correct).count / qr1.answers.count.to_f
qr1.save!

puts "...Iterators quiz for the second User..."
iterators = Quiz.create!(user: User.second, title: "Iterators in Ruby", seed: true)
iterators.questions.create!([{ question: "What is an iterator in the context of Ruby programming?" },
                            { question: "Which method is commonly used to implement iterators in Ruby?" },
                            { question: "What is the purpose of an iterator in Ruby?" },
                            { question: "What is the primary advantage of using iterators in Ruby?" },
                            { question: "What is the typical syntax for using an iterator in Ruby?" }])
iterators.questions.first.choices.create!([ { choice: "A data structure for storing elements", correct: false },
                                          { choice: "A control structure for looping through elements", correct: true },
                                          { choice: "A method for modifying elements", correct: false },
                                          { choice: "A class for defining custom elements", correct: false } ])
iterators.questions.second.choices.create!([ { choice: "each", correct: true },
                                          { choice: "map", correct: false },
                                          { choice: "select", correct: false },
                                          { choice: "reduce", correct: false } ])
iterators.questions.third.choices.create!([ { choice: "To iterate over a collection of elements", correct: true },
                                          { choice: "To modify the elements in a collection", correct: false },
                                          { choice: "To create a new collection of elements", correct: false },
                                          { choice: "To compare elements in a collection", correct: false } ])
iterators.questions.fourth.choices.create!([ { choice: "Simplicity and readability", correct: true },
                                          { choice: "Efficiency and performance", correct: false },
                                          { choice: "Flexibility and extensibility", correct: false },
                                          { choice: "Scalability and maintainability", correct: false } ])
iterators.questions.fifth.choices.create!([ { choice: "collection.each { |element| block }", correct: true },
                                          { choice: "collection.map { |element| block }", correct: false },
                                          { choice: "collection.select { |element| block }", correct: false },
                                          { choice: "collection.reduce { |element| block }", correct: false } ])
iterators.save!

puts "...taking the Iterators quiz..."
qr2 = QuizResult.create!(quiz: iterators, user: User.second, result: 0, seed: true)
a1 = Answer.create!( choice: iterators.questions.first.choices.sample, quiz_result: qr2 )
a2 = Answer.create!( choice: iterators.questions.second.choices.sample, quiz_result: qr2 )
a3 = Answer.create!( choice: iterators.questions.third.choices.sample, quiz_result: qr2 )
a4 = Answer.create!( choice: iterators.questions.fourth.choices.sample, quiz_result: qr2 )
a5 = Answer.create!( choice: iterators.questions.fifth.choices.sample, quiz_result: qr2 )

puts "... and calculating the result based on the answers..."
qr2.result = qr2.answers.map(&:choice).select(&:correct).count / qr2.answers.count.to_f
qr2.save!

puts "...adding a How to Study quiz for the second User..."
study = Quiz.create!(user: User.second, title: "How to Study Quickly", seed: true)
study.questions.create!([{ question: "What is the primary goal of studying quickly?" },
                        { question: "What are some effective strategies for studying quickly?" },
                        { question: "What role does time management play in studying quickly?" },
                        { question: "How can one maintain focus and concentration while studying quickly?" },
                        { question: "What are some potential drawbacks of studying quickly?" }])
study.questions.first.choices.create!([ { choice: "To memorize information for exams", correct: false },
                                      { choice: "To understand and retain information efficiently", correct: true },
                                      { choice: "To finish assignments and projects on time", correct: false },
                                      { choice: "To impress teachers and peers with knowledge", correct: false } ])
study.questions.second.choices.create!([ { choice: "Active reading and note-taking", correct: true },
                                      { choice: "Cramming and last-minute studying", correct: false },
                                      { choice: "Multitasking and distractions", correct: false },
                                      { choice: "Procrastination and time-wasting", correct: false } ])
study.questions.third.choices.create!([ { choice: "It allows for prioritization of tasks", correct: true },
                                      { choice: "It creates unnecessary pressure and stress", correct: false },
                                      { choice: "It limits the amount of information that can be studied", correct: false },
                                      { choice: "It leads to burnout and exhaustion", correct: false } ])
study.questions.fourth.choices.create!([ { choice: "Minimize distractions and set specific study goals", correct: true },
                                      { choice: "Take frequent breaks and avoid time limits", correct: false },
                                      { choice: "Multitask and switch between subjects rapidly", correct: false },
                                      { choice: "Use stimulants and energy drinks to stay awake", correct: false } ])
study.questions.fifth.choices.create!([ { choice: "Superficial understanding and retention of information", correct: true },
                                      { choice: "Increased stress and anxiety levels", correct: false },
                                      { choice: "Decreased motivation and interest in learning", correct: false },
                                      { choice: "Improved long-term memory and critical thinking skills", correct: false } ])
study.save!

puts "...adding a Roots of Techno quiz for the second User..."
techno = Quiz.create!(user: User.second, title: "Roots of Techno", seed: true)
techno.questions.create!([{question: "Where did techno music originate in the 1980s?"},
                          {question: "Who are considered the pioneers of techno music?"},
                          {question: "Which electronic instrument played a significant role in the creation of techno music?"},
                          {question: "What musical genres influenced the development of techno music?"},
                          {question: "What characteristics distinguish techno music from other electronic music genres?"}])
techno.questions.first.choices.create!([{choice: "London, England", correct: false},
                                        {choice: "Detroit, Michigan", correct: true},
                                        {choice: "Chicago, Illinois", correct: false},
                                        {choice: "Berlin, Germany", correct: false}])
techno.questions.second.choices.create!([{choice: "The Chemical Brothers", correct: false},
                                        {choice: "Kraftwerk", correct: false},
                                        {choice: "Juan Atkins, Derrick May, and Kevin Saunderson", correct: true},
                                        {choice: "Daft Punk", correct: false}])
techno.questions.third.choices.create!([{choice: "Drum machine", correct: true},
                                        {choice: "Synthesizer", correct: false},
                                        {choice: "Electric guitar", correct: false},
                                        {choice: "Theremin", correct: false}])
techno.questions.fourth.choices.create!([{choice: "Jazz and Classical", correct: false},
                                        {choice: "Rock and Roll", correct: false},
                                        {choice: "Funk and Disco", correct: true},
                                        {choice: "Country and Reggae", correct: false}])
techno.questions.fifth.choices.create!([{choice: "Heavy use of vocal samples", correct: false},
                                        {choice: "Slow tempo and relaxed beats", correct: false},
                                        {choice: "Emphasis on melody and harmony", correct: false},
                                        {choice: "Repetitive rhythms and synthetic sounds", correct: true}])
techno.save!

puts "...adding a Philips curve quiz for the second User..."
philips = Quiz.create!(user: User.second, title: "Philips curve", seed: true)
philips.questions.create!([{question: "The Phillips curve depicts the relationship between which two economic variables?"},
                          {question: "According to the Phillips curve, what is the typical relationship between inflation and unemployment?"},
                          {question: "The Phillips curve suggests that when unemployment is low, what tends to happen to inflation?"},
                          {question: "Which economist introduced the concept of the Phillips curve in the 1950s?"},
                          {question: "What critique has been leveled against the Phillips curve theory in modern economics?"}])
philips.questions.first.choices.create!([{choice: "Inflation and unemployment", correct: true},
                                        {choice: "GDP and interest rates", correct: false},
                                        {choice: "Exchange rates and trade balance", correct: false},
                                        {choice: "Income inequality and poverty rate", correct: false}])
philips.questions.second.choices.create!([{choice: "They have a positive correlation", correct: false},
                                        {choice: "They have a negative correlation", correct: true},
                                        {choice: "They are independent of each other", correct: false},
                                        {choice: "They have a curvilinear relationship", correct: false}])
philips.questions.third.choices.create!([{choice: "It increases", correct: true},
                                        {choice: "It decreases", correct: false},
                                        {choice: "It remains constant", correct: false},
                                        {choice: "It becomes unpredictable", correct: false}])
philips.questions.fourth.choices.create!([{choice: "John Maynard Keynes", correct: false},
                                        {choice: "Milton Friedman", correct: false},
                                        {choice: "A.W. Phillips", correct: true},
                                        {choice: "Paul Samuelson", correct: false}])
philips.questions.fifth.choices.create!([{choice: "It fails to account for supply-side factors", correct: true},
                                        {choice: "It is too simplistic and outdated", correct: false},
                                        {choice: "It relies too heavily on mathematical models", correct: false},
                                        {choice: "It only applies to closed economies", correct: false}])
philips.save!


puts "Creating 4 quizzes (with questions, choices and recommendationsd and results) owned by other users..."
puts "botanical person's 2 quizzes and quizzresults..."
katie = User.where.not(id: 2).sample
botanical = Quiz.create!(user: katie, title: "Botanical Oils", seed: true)
botanical.questions.create!([{question: "What are botanical oils derived from?"},
                            {question: "Which of the following is NOT a common use for botanical oils?"},
                            {question: "What is the primary benefit of using botanical oils in skincare products?"},
                            {question: "What is the difference between essential oils and carrier oils?"},
                            {question: "What are some popular botanical oils used in aromatherapy?"}])
botanical.questions.first.choices.create!([{choice: "Plants and flowers", correct: true},
                                        {choice: "Animals and insects", correct: false},
                                        {choice: "Minerals and rocks", correct: false},
                                        {choice: "Synthetic chemicals", correct: false}])
botanical.questions.second.choices.create!([{choice: "Cooking and baking", correct: true},
                                        {choice: "Aromatherapy and massage", correct: false},
                                        {choice: "Skincare and haircare", correct: false},
                                        {choice: "Cleaning and disinfecting", correct: false}])
botanical.questions.third.choices.create!([{choice: "Nourishes and hydrates the skin", correct: true},
                                        {choice: "Repels insects and pests", correct: false},
                                        {choice: "Enhances the flavor of food", correct: false},
                                        {choice: "Promotes relaxation and stress relief", correct: false}])
botanical.questions.fourth.choices.create!([{choice: "Essential oils are concentrated and volatile, while carrier oils are mild and stable", correct: true},
                                        {choice: "Essential oils are used for cooking, while carrier oils are used for skincare", correct: false},
                                        {choice: "Essential oils are extracted from flowers, while carrier oils are extracted from fruits", correct: false},
                                        {choice: "Essential oils are edible, while carrier oils are toxic if ingested", correct: false}])
botanical.questions.fifth.choices.create!([{choice: "Lavender, Peppermint, and Eucalyptus", correct: true},
                                        {choice: "Olive, Coconut, and Almond", correct: false},
                                        {choice: "Lemon, Orange, and Grapefruit", correct: false},
                                        {choice: "Rose, Jasmine, and Sandalwood", correct: false}])
botanical.save!

qr1 = QuizResult.create!(quiz: botanical, user: katie, result: 0, seed: true)
a1 = Answer.create!( choice: botanical.questions.first.choices.sample, quiz_result: qr1 )
a2 = Answer.create!( choice: botanical.questions.second.choices.sample, quiz_result: qr1 )
a3 = Answer.create!( choice: botanical.questions.third.choices.sample, quiz_result: qr1 )
a4 = Answer.create!( choice: botanical.questions.fourth.choices.sample, quiz_result: qr1 )
a5 = Answer.create!( choice: botanical.questions.fifth.choices.sample, quiz_result: qr1 )
qr1.result = qr1.answers.map(&:choice).select(&:correct).count / qr1.answers.count.to_f
qr1.save!

wild = Quiz.create!(user: katie, title: "Wild Botanicals in Rural UK", seed: true)
wild.questions.create!([{question: "What are wild botanicals?"},
                        {question: "What are some common wild botanicals found in rural UK?"},
                        {question: "What are the traditional uses of wild botanicals in rural UK?"},
                        {question: "What are some modern applications of wild botanicals in rural UK?"},
                        {question: "What are the potential benefits of foraging for wild botanicals in rural UK?"}])
wild.questions.first.choices.create!([{choice: "Plants and flowers that grow in the wild", correct: true},
                                      {choice: "Invasive species and non-native plants", correct: false},
                                      {choice: "Genetically modified organisms", correct: false},
                                      {choice: "Artificial and synthetic plants", correct: false}])
wild.questions.second.choices.create!([{choice: "Nettles, Dandelions, and Elderflowers", correct: true},
                                      {choice: "Roses, Lavender, and Chamomile", correct: false},
                                      {choice: "Mint, Thyme, and Basil", correct: false},
                                      {choice: "Lemon balm, Sage, and Rosemary", correct: false}])
wild.questions.third.choices.create!([{choice: "Medicinal remedies and herbal treatments", correct: true},
                                      {choice: "Cooking and culinary ingredients", correct: false},
                                      {choice: "Aromatherapy and essential oils", correct: false},
                                      {choice: "Decorative and ornamental purposes", correct: false}])
wild.questions.fourth.choices.create!([{choice: "Natural skincare products and organic cosmetics", correct: true},
                                      {choice: "Industrial manufacturing and commercial production", correct: false},
                                      {choice: "Biotechnology and genetic engineering", correct: false},
                                      {choice: "Pharmaceutical drugs and synthetic medications", correct: false}])
wild.questions.fifth.choices.create!([{choice: "Sustainable and eco-friendly sourcing of ingredients", correct: true},
                                      {choice: "Increased exposure to toxic chemicals and pollutants", correct: false},
                                      {choice: "Greater convenience and accessibility to modern products", correct: false},
                                      {choice: "Enhanced flavor and aroma in culinary dishes", correct: false}])
wild.save!

qr2 = QuizResult.create!(quiz: wild, user: katie, result: 0, seed: true)
a1 = Answer.create!( choice: wild.questions.first.choices.select(&:correct).first, quiz_result: qr2 )
a2 = Answer.create!( choice: wild.questions.second.choices.select(&:correct).first, quiz_result: qr2 )
a3 = Answer.create!( choice: wild.questions.third.choices.select(&:correct).first, quiz_result: qr2 )
a4 = Answer.create!( choice: wild.questions.fourth.choices.select(&:correct).first, quiz_result: qr2 )
a5 = Answer.create!( choice: wild.questions.fifth.choices.select(&:correct).first, quiz_result: qr2 )
qr2.result = qr2.answers.map(&:choice).select(&:correct).count / qr2.answers.count.to_f
qr2.save!

puts "another person's 2 IT quizzes and quizresults..."
nolan = User.where.not(id: 2).sample
osint = Quiz.create!(user: nolan, title: "OSINT", seed: true)
osint.questions.create!([{question: "What does 'OSINT' stand for in the context of intelligence gathering?"},
                        {question: "Which of the following is NOT a step in the OSINT model?"},
                        {question: "What is the first step in the OSINT process?"},
                        {question: "Which phase involves verifying the credibility and reliability of gathered information in the OSINT model?"},
                        {question: "What is the final step in the OSINT process?"}])
osint.questions.first.choices.create!([{choice: "Open Source Intelligence", correct: true},
                                      {choice: "Operational Security Integration", correct: false},
                                      {choice: "Online Surveillance and Investigation", correct: false},
                                      {choice: "Off-Site Information Network", correct: false}])
osint.questions.second.choices.create!([{choice: "Collection", correct: false},
                                      {choice: "Analysis", correct: false},
                                      {choice: "Hacking", correct: true},
                                      {choice: "Dissemination", correct: false}])
osint.questions.third.choices.create!([{choice: "Analysis", correct: false},
                                      {choice: "Collection", correct: false},
                                      {choice: "Dissemination", correct: false},
                                      {choice: "Planning", correct: true}])
osint.questions.fourth.choices.create!([{choice: "Collection", correct: false},
                                      {choice: "Analysis", correct: true},
                                      {choice: "Hacking", correct: false},
                                      {choice: "Dissemination", correct: false}])
osint.questions.fifth.choices.create!([{choice: "Collection", correct: false},
                                      {choice: "Analysis", correct: false},
                                      {choice: "Dissemination", correct: true},
                                      {choice: "Planning", correct: false}])
osint.save!

qr3 = QuizResult.create!(quiz: osint, user: nolan, result: 0, seed: true)
a1 = Answer.create!( choice: osint.questions.first.choices.select(&:correct).first, quiz_result: qr3 )
a2 = Answer.create!( choice: osint.questions.second.choices.select(&:correct).first, quiz_result: qr3 )
a3 = Answer.create!( choice: osint.questions.third.choices.select(&:correct).first, quiz_result: qr3 )
a4 = Answer.create!( choice: osint.questions.fourth.choices.select(&:correct).first, quiz_result: qr3 )
a5 = Answer.create!( choice: osint.questions.fifth.choices.select(&:correct).first, quiz_result: qr3 )
qr3.result = qr3.answers.map(&:choice).select(&:correct).count / qr3.answers.count.to_f
qr3.save!

cyber = Quiz.create!(user: nolan, title: "Cybersecurity Basics", seed: true)
cyber.questions.create!([{question: "What is the primary goal of cybersecurity?"},
                        {question: "What are some common threats to cybersecurity?"},
                        {question: "What are some best practices for maintaining cybersecurity?"},
                        {question: "What is the role of encryption in cybersecurity?"},
                        {question: "What are some potential consequences of a cybersecurity breach?"}])
cyber.questions.first.choices.create!([{choice: "To prevent unauthorized access and protect sensitive data", correct: true},
                                      {choice: "To monitor and track user activity on the internet", correct: false},
                                      {choice: "To restrict the use of digital devices and online services", correct: false},
                                      {choice: "To detect and eliminate malware and viruses", correct: false}])
cyber.questions.second.choices.create!([{choice: "Malware, Phishing, and DDoS attacks", correct: true},
                                      {choice: "Social media addiction and cyberbullying", correct: false},
                                      {choice: "Online shopping and digital payments", correct: false},
                                      {choice: "Internet censorship and surveillance", correct: false}])
cyber.questions.third.choices.create!([{choice: "Regular software updates and strong, unique passwords", correct: true},
                                      {choice: "Sharing personal information and login credentials", correct: false},
                                      {choice: "Using public Wi-Fi networks and unsecured websites", correct: false},
                                      {choice: "Ignoring security alerts and warnings", correct: false}])
cyber.questions.fourth.choices.create!([{choice: "It protects data from unauthorized access and interception", correct: true},
                                      {choice: "It prevents malware and viruses from infecting digital devices", correct: false},
                                      {choice: "It monitors and tracks user activity on the internet", correct: false},
                                      {choice: "It restricts the use of digital devices and online services", correct: false}])
cyber.questions.fifth.choices.create!([{choice: "Data breaches, identity theft, and financial fraud", correct: true},
                                      {choice: "Enhanced privacy and security for online activities", correct: false},
                                      {choice: "Improved user experience and convenience", correct: false},
                                      {choice: "Increased trust and confidence in digital technologies", correct: false}])
cyber.save!

qr4 = QuizResult.create!(quiz: cyber, user: nolan, result: 0, seed: true)
a1 = Answer.create!( choice: cyber.questions.first.choices.sample, quiz_result: qr4 )
a2 = Answer.create!( choice: cyber.questions.second.choices.sample, quiz_result: qr4 )
a3 = Answer.create!( choice: cyber.questions.third.choices.sample, quiz_result: qr4 )
a4 = Answer.create!( choice: cyber.questions.fourth.choices.sample, quiz_result: qr4 )
a5 = Answer.create!( choice: cyber.questions.fifth.choices.sample, quiz_result: qr4 )
qr4.result = qr4.answers.map(&:choice).select(&:correct).count / qr4.answers.count.to_f
qr4.save!

puts "IT person takes the second users how to study quiz and answers everything correctly"
qr5 = QuizResult.create!(quiz: study, user: nolan, result: 0, seed: true)
a1 = Answer.create!( choice: study.questions.first.choices.select(&:correct).first, quiz_result: qr5 )
a2 = Answer.create!( choice: study.questions.second.choices.select(&:correct).first, quiz_result: qr5 )
a3 = Answer.create!( choice: study.questions.third.choices.select(&:correct).first, quiz_result: qr5 )
a4 = Answer.create!( choice: study.questions.fourth.choices.select(&:correct).first, quiz_result: qr5 )
a5 = Answer.create!( choice: study.questions.fifth.choices.select(&:correct).first, quiz_result: qr5 )
qr5.result = qr5.answers.map(&:choice).select(&:correct).count / qr5.answers.count.to_f
qr5.save!
