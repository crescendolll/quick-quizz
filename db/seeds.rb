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

main_character = User.second
main_character.update!(username: "test", email:"test@quick.quizz")

puts "Creating quizzes (with questions and choices) for the second User..."

puts "...adding a quiz about correct waste collection..."
waste = Quiz.create!(user: main_character, title: "Correct Waste Collection", seed: true
)
waste.questions.create!([{ question: "What is the primary goal of waste collection?" },
                        { question: "What are the main categories of waste?" },
                        { question: "What are the most common methods of waste disposal?" },
                        { question: "What are the potential environmental impacts of improper waste collection and disposal?" },
                        { question: "What are some best practices for reducing waste and promoting recycling?" }])
waste.questions.first.choices.create!([{ choice: "To prevent the accumulation of waste in public spaces", correct: false },
                                      { choice: "To minimize the environmental impact of waste", correct: true },
                                      { choice: "To generate revenue from waste management", correct: false },
                                      { choice: "To create jobs and employment opportunities", correct: false }])
waste.questions.second.choices.create!([{ choice: "Biodegradable and non-biodegradable", correct: false },
                                      { choice: "Organic and inorganic", correct: false },
                                      { choice: "Recyclable and non-recyclable", correct: false },
                                      { choice: "Hazardous and non-hazardous", correct: true }])
waste.questions.third.choices.create!([{ choice: "Landfilling and incineration", correct: true },
                                      { choice: "Composting and recycling", correct: false },
                                      { choice: "Dumping and littering", correct: false },
                                      { choice: "Reusing and repurposing", correct: false }])
waste.questions.fourth.choices.create!([{ choice: "Soil and water pollution", correct: true },
                                      { choice: "Air and noise pollution", correct: false },
                                      { choice: "Habitat destruction and loss of biodiversity", correct: false },
                                      { choice: "Climate change and global warming", correct: false }])
waste.questions.fifth.choices.create!([{ choice: "Reduce, Reuse, Recycle", correct: true },
                                      { choice: "Refuse, Reuse, Repurpose", correct: false },
                                      { choice: "Recycle, Reclaim, Renew", correct: false },
                                      { choice: "Recover, Reuse, Replenish", correct: false }])
waste.save!

puts "...taking the waste collection quiz..."
qr = QuizResult.create!(quiz: waste, user: main_character, result: 0, seed: true)
a1 = Answer.create!( choice: waste.questions.first.choices.sample, quiz_result: qr )
a2 = Answer.create!( choice: waste.questions.second.choices.sample, quiz_result: qr )
a3 = Answer.create!( choice: waste.questions.third.choices.sample, quiz_result: qr )
a4 = Answer.create!( choice: waste.questions.fourth.choices.sample, quiz_result: qr )
a5 = Answer.create!( choice: waste.questions.fifth.choices.sample, quiz_result: qr )

puts "... and calculating the result based on the answers..."
qr.result = qr.answers.map(&:choice).select(&:correct).count / qr.answers.count.to_f
qr.save!

puts "...adding a quiz about health codes for handling organic waste..."
health = Quiz.create!(user: main_character, title: "Health Codes for Handling Organic Waste", seed: true)
health.questions.create!([{ question: "What are the primary health risks associated with handling organic waste?" },
                          { question: "What are some common sources of organic waste in a residential setting?" },
                          { question: "What are the potential environmental impacts of organic waste?" },
                          { question: "What are some best practices for safely handling and disposing of organic waste?" },
                          { question: "What are the main components of a composting system for organic waste?" }])
health.questions.first.choices.create!([{ choice: "Exposure to pathogens and disease-causing microorganisms", correct: true },
                                      { choice: "Allergic reactions and respiratory issues", correct: false },
                                      { choice: "Chemical exposure and toxic contamination", correct: false },
                                      { choice: "Injuries and accidents from handling heavy materials", correct: false }])
health.questions.second.choices.create!([{ choice: "Food scraps and kitchen waste", correct: true },
                                      { choice: "Yard trimmings and garden debris", correct: false },
                                      { choice: "Paper and cardboard products", correct: false },
                                      { choice: "Animal waste and pet litter", correct: false }])
health.questions.third.choices.create!([{ choice: "Soil and water pollution", correct: true },
                                      { choice: "Air and noise pollution", correct: false },
                                      { choice: "Habitat destruction and loss of biodiversity", correct: false },
                                      { choice: "Climate change and global warming", correct: false }])
health.questions.fourth.choices.create!([{ choice: "Wear protective clothing and equipment", correct: false },
                                      { choice: "Wash hands and sanitize work surfaces", correct: false },
                                      { choice: "Store waste in airtight containers and sealed bags", correct: true },
                                      { choice: "Dispose of waste in designated collection bins and containers", correct: false }])
health.questions.fifth.choices.create!([{ choice: "Aeration, moisture, and temperature control", correct: false },
                                      { choice: "Layering, turning, and mixing", correct: false },
                                      { choice: "Balancing carbon and nitrogen ratios", correct: false },
                                      { choice: "Microbial activity and decomposition", correct: true }])
health.save!

puts "...taking the health codes quiz..."
qr = QuizResult.create!(quiz: health, user: main_character, result: 0, seed: true)
a1 = Answer.create!( choice: health.questions.first.choices.sample, quiz_result: qr )
a2 = Answer.create!( choice: health.questions.second.choices.sample, quiz_result: qr )
a3 = Answer.create!( choice: health.questions.third.choices.sample, quiz_result: qr )
a4 = Answer.create!( choice: health.questions.fourth.choices.sample, quiz_result: qr )
a5 = Answer.create!( choice: health.questions.fifth.choices.sample, quiz_result: qr )

puts "... and calculating the result based on the answers..."
qr.result = qr.answers.map(&:choice).select(&:correct).count / qr.answers.count.to_f
qr.save!

puts "...adding a Roots of Techno quiz for the second User..."
techno = Quiz.create!(user: main_character, title: "Roots of Techno", seed: true)
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

puts "...Architecture quiz for the second User..."
architecture = Quiz.create!(user: main_character, title: "Architecture", seed: true)
architecture.questions.create!([{ question: "What is the primary purpose of architecture?" },
                              { question: "What are some key elements of architectural design?" },
                              { question: "What role does sustainability play in modern architecture?" },
                              { question: "What are some examples of iconic architectural landmarks around the world?" },
                              { question: "What are some potential challenges and limitations of architectural design?" }])
architecture.questions.first.choices.create!([{ choice: "To create functional and aesthetically pleasing spaces", correct: true },
                                            { choice: "To maximize profits and minimize costs", correct: false },
                                            { choice: "To promote social and cultural values", correct: false },
                                            { choice: "To express individual creativity and personal style", correct: false }])
architecture.questions.second.choices.create!([{ choice: "Form, function, and structure", correct: true },
                                            { choice: "Color, texture, and pattern", correct: true },
                                            { choice: "Scale, proportion, and balance", correct: true },
                                            { choice: "Light, shadow, and reflection", correct: true }])
architecture.questions.third.choices.create!([{ choice: "It emphasizes energy efficiency and environmental impact", correct: true },
                                            { choice: "It prioritizes historical preservation and restoration", correct: false },
                                            { choice: "It focuses on luxury and opulence", correct: false },
                                            { choice: "It promotes technological innovation and advancement", correct: false }])
architecture.questions.fourth.choices.create!([{ choice: "Eiffel Tower, Paris, France", correct: true },
                                            { choice: "Sydney Opera House, Sydney, Australia", correct: true },
                                            { choice: "Taj Mahal, Agra, India", correct: true },
                                            { choice: "Burj Khalifa, Dubai, United Arab Emirates", correct: true }])
architecture.questions.fifth.choices.create!([{ choice: "Budget constraints and financial limitations", correct: true },
                                            { choice: "Regulatory restrictions and zoning laws", correct: true },
                                            { choice: "Material availability and construction techniques", correct: true },
                                            { choice: "Client preferences and design specifications", correct: true }])
architecture.save!

puts "...taking the Architecture quiz..."
qr = QuizResult.create!(quiz: architecture, user: main_character, result: 0, seed: true)
a1 = Answer.create!( choice: architecture.questions.first.choices.sample, quiz_result: qr )
a2 = Answer.create!( choice: architecture.questions.second.choices.sample, quiz_result: qr )
a3 = Answer.create!( choice: architecture.questions.third.choices.sample, quiz_result: qr )
a4 = Answer.create!( choice: architecture.questions.fourth.choices.sample, quiz_result: qr )
a5 = Answer.create!( choice: architecture.questions.fifth.choices.sample, quiz_result: qr )

puts "... and calculating the result based on the answers..."
qr.result = qr.answers.map(&:choice).select(&:correct).count / qr.answers.count.to_f
qr.save!

puts "...adding a how to design a landscape quiz for the second User..."

landscape = Quiz.create!(user: main_character, title: "How to Design a Landscape", seed: true)
landscape.questions.create!([{ question: "What are the primary goals of landscape design?" },
                            { question: "What are some key elements of landscape design?" },
                            { question: "What role does sustainability play in modern landscape design?" },
                            { question: "What are some examples of iconic landscaped gardens around the world?" },
                            { question: "What are the most common potential challenges and limitations of landscape design?" }])
landscape.questions.first.choices.create!([{ choice: "To create functional and aesthetically pleasing outdoor spaces", correct: true },
                                        { choice: "To maximize profits and minimize costs", correct: false },
                                        { choice: "To promote social and cultural values", correct: false },
                                        { choice: "To express individual creativity and personal style", correct: false }])
landscape.questions.second.choices.create!([{ choice: "Form, function, and structure", correct: false },
                                        { choice: "Color, texture, and pattern", correct: false },
                                        { choice: "Scale, proportion, and balance", correct: true },
                                        { choice: "Light, shadow, and reflection", correct: false }])
landscape.questions.third.choices.create!([{ choice: "It emphasizes water conservation and environmental impact", correct: true },
                                        { choice: "It prioritizes historical preservation and restoration", correct: false },
                                        { choice: "It focuses on luxury and opulence", correct: false },
                                        { choice: "It promotes technological innovation and advancement", correct: false }])
landscape.questions.fourth.choices.create!([{ choice: "Versailles Gardens, Versailles, France", correct: false },
                                        { choice: "Butchart Gardens, Victoria, Canada", correct: true },
                                        { choice: "Kew Gardens, London, England", correct: false },
                                        { choice: "Hakone Gardens, Tokyo, Japan", correct: false }])
landscape.questions.fifth.choices.create!([{ choice: "Budget constraints and financial limitations", correct: false },
                                        { choice: "Regulatory restrictions and zoning laws", correct: true },
                                        { choice: "Material availability and construction techniques", correct: false },
                                        { choice: "Client preferences and design specifications", correct: false }])
landscape.save!

puts "...taking the Landscape Design quiz..."
qr = QuizResult.create!(quiz: landscape, user: main_character, result: 0, seed: true)
a1 = Answer.create!( choice: landscape.questions.first.choices.sample, quiz_result: qr )
a2 = Answer.create!( choice: landscape.questions.second.choices.sample, quiz_result: qr )
a3 = Answer.create!( choice: landscape.questions.third.choices.sample, quiz_result: qr )
a4 = Answer.create!( choice: landscape.questions.fourth.choices.sample, quiz_result: qr )
a5 = Answer.create!( choice: landscape.questions.fifth.choices.sample, quiz_result: qr )

puts "... and calculating the result based on the answers..."
qr.result = qr.answers.map(&:choice).select(&:correct).count / qr.answers.count.to_f


puts "...CAD design quiz for the second User where only one choice per question is correct..."
cad = Quiz.create!(user: main_character, title: "CAD Design", seed: true)
cad.questions.create!([{ question: "What does 'CAD' stand for in the context of design and engineering?" },
                      { question: "What are some common applications of CAD software?" },
                      { question: "What are the primary advantages of using CAD software for design and drafting?" },
                      { question: "What are some potential drawbacks and limitations of CAD software?" },
                      { question: "What are some essential skills and competencies for using CAD software effectively?" }])
cad.questions.first.choices.create!([{ choice: "Computer-Aided Design", correct: true },
                                    { choice: "Computer-Assisted Drafting", correct: false },
                                    { choice: "Creative Architecture and Design", correct: false },
                                    { choice: "Collaborative Analysis and Development", correct: false }])
cad.questions.second.choices.create!([{ choice: "Architectural design and urban planning", correct: true },
                                    { choice: "Choosing a hairstyle", correct: false },
                                    { choice: "Deciding on textures for a fashion project", correct: false },
                                    { choice: "Wireframing for apps", correct: false }])
cad.questions.third.choices.create!([{ choice: "Division of labour", correct: false },
                                    { choice: "Flexibility and adaptability to changing requirements", correct: true },
                                    { choice: "All-in-one solution", correct: false },
                                    { choice: "Automation of prototyping", correct: false }])
cad.questions.fourth.choices.create!([{ choice: "Endless options for creativity", correct: false },
                                    { choice: "Dependency on hardware and software compatibility", correct: true },
                                    { choice: "Too easy to learn", correct: false },
                                    { choice: "Year-long traings needed", correct: false }])
cad.questions.fifth.choices.create!([{ choice: "Technical drawing and geometric modeling", correct: true },
                                    { choice: "Problem-solving and critical thinking", correct: false },
                                    { choice: "Communication and collaboration with team members", correct: false },
                                    { choice: "Adaptability and flexibility in design and development", correct: false }])
cad.save!

puts "...taking the CAD Design quiz..."
qr = QuizResult.create!(quiz: cad, user: main_character, result: 0, seed: true)
a1 = Answer.create!( choice: cad.questions.first.choices.select(&:correct).first, quiz_result: qr )
a2 = Answer.create!( choice: cad.questions.second.choices.select(&:correct).first, quiz_result: qr )
a3 = Answer.create!( choice: cad.questions.third.choices.select(&:correct).first, quiz_result: qr )
a4 = Answer.create!( choice: cad.questions.fourth.choices.select(&:correct).first, quiz_result: qr )
a5 = Answer.create!( choice: cad.questions.fifth.choices.select(&:correct).first, quiz_result: qr )

puts "... and calculating the result based on the answers..."
qr.result = qr.answers.map(&:choice).select(&:correct).count / qr.answers.count.to_f
qr.save!

puts "...Panopticon quiz for the second User..."
panopt = Quiz.create!(user: main_character, title: "Panopticon", seed: true)
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
qr1 = QuizResult.create!(quiz: panopt, user: main_character, result: 0, seed: true)
a1 = Answer.create!( choice: panopt.questions.first.choices.sample, quiz_result: qr1 )
a2 = Answer.create!( choice: panopt.questions.second.choices.sample, quiz_result: qr1 )
a3 = Answer.create!( choice: panopt.questions.third.choices.sample, quiz_result: qr1 )
a4 = Answer.create!( choice: panopt.questions.fourth.choices.sample, quiz_result: qr1 )
a5 = Answer.create!( choice: panopt.questions.fifth.choices.sample, quiz_result: qr1 )

puts "... and calculating the result based on the answers..."
qr1.result = qr1.answers.map(&:choice).select(&:correct).count / qr1.answers.count.to_f
qr1.save!

puts "...Iterators quiz for the second User..."
iterators = Quiz.create!(user: main_character, title: "Iterators in Ruby", seed: true)
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
qr2 = QuizResult.create!(quiz: iterators, user: main_character, result: 0, seed: true)
a1 = Answer.create!( choice: iterators.questions.first.choices.sample, quiz_result: qr2 )
a2 = Answer.create!( choice: iterators.questions.second.choices.sample, quiz_result: qr2 )
a3 = Answer.create!( choice: iterators.questions.third.choices.sample, quiz_result: qr2 )
a4 = Answer.create!( choice: iterators.questions.fourth.choices.sample, quiz_result: qr2 )
a5 = Answer.create!( choice: iterators.questions.fifth.choices.sample, quiz_result: qr2 )

puts "... and calculating the result based on the answers..."
qr2.result = qr2.answers.map(&:choice).select(&:correct).count / qr2.answers.count.to_f
qr2.save!

puts "...adding a How to Study quiz for the second User..."
study = Quiz.create!(user: main_character, title: "How to Study Quickly", seed: true)
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

puts "...adding a career changer quiz for the second User..."
career = Quiz.create!(user: main_character, title: "Career Change", seed: true)
career.questions.create!([{ question: "What are some common reasons for considering a career change?" },
                          { question: "What are the most common potential challenges and obstacles of changing careers?" },
                          { question: "What are the first essential steps for planning and executing a successful career change?" },
                          { question: "What role does self-assessment and reflection play in the process of changing careers?" },
                          { question: "What are ineffective strategies for overcoming fear of change?" }])
career.questions.first.choices.create!([ { choice: "Job security and financial stability", correct: false },
                                      { choice: "No desire for personal and professional growth", correct: false },
                                      { choice: "Compatibilty with company culture and values", correct: false },
                                      { choice: "Burnout and exhaustion from current job", correct: true } ])
career.questions.second.choices.create!([ { choice: "Fear of the unknown and uncertainty", correct: false },
                                      { choice: "Resistance from family and friends", correct: false },
                                      { choice: "Financial constraints and budget limitations", correct: false },
                                      { choice: "Lack of relevant skills and experience", correct: true } ])
career.questions.third.choices.create!([ { choice: "Research and explore new career options", correct: true },
                                      { choice: "Apply to as many job openings as possible", correct: false },
                                      { choice: "Network and connect with professionals in new field", correct: false },
                                      { choice: "Seek guidance and support from career counselors", correct: false } ])
career.questions.fourth.choices.create!([ { choice: "Identify personal strengths and weaknesses", correct: true },
                                      { choice: "Set specific and achievable career goals", correct: true },
                                      { choice: "Evaluate current job satisfaction and fulfillment", correct: true },
                                      { choice: "Reflect on past experiences and accomplishments", correct: true } ])
career.questions.fifth.choices.create!([ { choice: "Seek support and encouragement from friends and family", correct: false },
                                      { choice: "Embrace change and adapt to new challenges", correct: false },
                                      { choice: "Stay focused and never accept setbacks", correct: true },
                                      { choice: "Take calculated risks and explore new opportunities", correct: false } ])
career.save!




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
