require 'faker'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
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
    password: '123456'
  )
end

puts "Creating 3 quizzes (with questions, choices and recommendations) for the second User..."

panopt = Quiz.create!(user: User.second, title: "Panopticon")
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
panopt.recommendations.create!([{ link: "https://plato.stanford.edu/entries/foucault/" },
                                { link: "https://www.amazon.com/Discipline-Punish-Birth-Michel-Foucault/dp/0679752552" },
                                { link: "https://www.amazon.com/Surveillance-Studies-Reader-David-Lyon/dp/0745644954" }])
panopt.save!

techno = Quiz.create!(user: User.second, title: "Roots of Techno")
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
techno.recommendations.create!([{link: "https://ra.co/features/1151"},
                                {link: "https://daily.redbullmusicacademy.com/2015/08/origins-of-techno-feature"},
                                {link: "https://mixmag.net/feature/the-story-of-detroit-techno"}])
techno.save!

philips = Quiz.create!(user: User.second, title: "Philips curve")
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
philips.recommendations.create!([{link: "https://www.investopedia.com/terms/p/phillipscurve.asp"},
                                {link: "https://www.stlouisfed.org/publications/regional-economist/january-2018/phillips-curve"},
                                {link: "https://www.economist.com/finance-and-economics/2017/06/08/the-return-of-the-phillips-curve"}])
philips.save!

puts "Creating 2 quizzes (with questions, choices and recommendations) owned by other users..."
logic = Quiz.create!(user: User.where.not(id: 2).sample, title: "Formal Logic")
logic.questions.create!([{question: "Which branch of logic deals with formal systems of reasoning, such as propositional and predicate logic?"},
                        {question: "What is the primary focus of formal logic?"},
                        {question: "In propositional logic, what are the basic components used to represent logical statements?"},
                        {question: "Which logical connective represents the logical 'and' operation in propositional logic?"},
                        {question: "What does the symbol '¬' represent in formal logic?"}])
logic.questions.first.choices.create!([{choice: "Informal logic", correct: false},
                                      {choice: "Mathematical logic", correct: false},
                                      {choice: "Symbolic logic", correct: true},
                                      {choice: "Analytic logic", correct: false}])
logic.questions.second.choices.create!([{choice: "Informal reasoning and everyday arguments", correct: false},
                                      {choice: "Logical fallacies and cognitive biases", correct: false},
                                      {choice: "Formalizing arguments using symbols and rules", correct: true},
                                      {choice: "Philosophical analysis of language and meaning", correct: false}])
logic.questions.third.choices.create!([{choice: "Variables and constants", correct: true},
                                      {choice: "Connectives and quantifiers", correct: false},
                                      {choice: "Terms and predicates", correct: false},
                                      {choice: "Operators and operands", correct: false}])
logic.questions.fourth.choices.create!([{choice: "∧ (conjunction)", correct: true},
                                      {choice: "∨ (disjunction)", correct: false},
                                      {choice: "¬ (negation)", correct: false},
                                      {choice: "→ (implication)", correct: false}])
logic.questions.fifth.choices.create!([{choice: "Logical 'or'", correct: false},
                                      {choice: "Logical 'not'", correct: true},
                                      {choice: "Logical 'if-then'", correct: false},
                                      {choice: "Logical 'if and only if'", correct: false}])
logic.recommendations.create!([{link: "https://plato.stanford.edu/entries/logic-classical/"},
                              {link: "https://iep.utm.edu/symbolic/"},
                              {link: "https://ocw.mit.edu/courses/linguistics-and-philosophy/24-241-logic-i-fall-2005/index.htm"}])
logic.save!

osint = Quiz.create!(user: User.where.not(id: 2).sample, title: "OSINT")
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
osint.recommendations.create!([{ link: "https://osintframework.com/" },
                              { link: "https://www.goodreads.com/book/show/23405917-open-source-intelligence-techniques" },
                              { link: "https://www.europol.europa.eu/sites/default/files/documents/osint_handbook_guidelines_2020.pdf" }])
osint.save!

puts "Making second User take the panopt quiz..."
qr1 = QuizResult.create!(quiz: panopt, user: User.second, result: 0)

puts "Creating answers for the panopt quiz..."
a1 = Answer.create!( choice: panopt.questions.first.choices.sample, quiz_result: qr1 )
a2 = Answer.create!( choice: panopt.questions.second.choices.sample, quiz_result: qr1 )
a3 = Answer.create!( choice: panopt.questions.third.choices.sample, quiz_result: qr1 )
a4 = Answer.create!( choice: panopt.questions.fourth.choices.sample, quiz_result: qr1 )
a5 = Answer.create!( choice: panopt.questions.fifth.choices.sample, quiz_result: qr1 )



# uncomment if you want to see that result calc works correctly
# aasdf = [a1, a2, a3, a4, a5]
# aasdf.each do |answer|
#   puts "choice was:"
#   puts answer.choice.choice
#   puts "and that choice was:"
#   puts answer.choice.correct
# end

puts "Calculating the result based on the answers..."
qr1.result = qr1.answers.map(&:choice).select(&:correct).count / qr1.answers.count.to_f
qr1.save!

# puts "result was:"
# puts qr1.result
