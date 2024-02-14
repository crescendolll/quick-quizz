class QuizResult < ApplicationRecord
  belongs_to :quiz
  belongs_to :user
  has_many :answers, dependent: :destroy

  validates :result, presence: true, numericality: true
  accepts_nested_attributes_for :answers

  attr_accessor :seed
  after_create :generate_ai_recommendations, unless: :seed

  def result_percentage
    result*100
  end

  private

  def generate_ai_recommendations
    answers_for_prompt = []
    answers.select { |answer| !answer.choice.correct }.each do |answer|
      answers_for_prompt << answer.choice.question.question
    end

    response = get_ai_answer(answers_for_prompt)

    response.each do |recommendation|
      found_answer = answers.find { |a| a.choice.question.question == recommendation["question"] }
      @new_recommendation = Recommendation.new(recommendation: recommendation["answer"], answer: found_answer)
      @new_recommendation.save!
      # new_question.generate_choices(response[index])
    end
  end

  def get_ai_answer(prompt)
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-3.5-turbo-0125",
      messages: [{
        role: "system",
        content: "You are a helpful assistant that generates answers to provided questions. Respond with answers that are at least three sentences long, but no longer than five sentences. Provide your answer in a  JSON structure similar to this.
          [
            {
              'topic: '<The provided topic of the quiz>',
              'question': '<The provided question>',
              'answer': '<Your answer>'
            },
            {
              'topic: '<The provided topic of the quiz>',
              'question': '<The provided question>',
              'answer': '<Your answer>'
            }
          ]
          Under no circumstances use double quotes in your JSON response. Use single quotes instead.
          Do not put any words or phrases in quotes in your response.
          Under no circumstances use apostrophes in your response.
          Make sure you do not use the come after the last answer.
          If you use double quotes, the JSON will be invalid and an error will occur. If you are unsure about the JSON structure, please refer to the example above."
      },
      {
        role: "user",
        content: "Generate an answer for each of these questions: #{prompt.join(', ')} on the topic of #{quiz.title}. Give me only the text of the answers, without any of your own text like 'Here are the answers I made'. Make sure each answer is no longer than 300 characters."
      },
      {
        role: "assistant",
        content: "[
          {
            'topic': 'History of the Roman Empire',
            'question': 'Who was the first emperor of the Roman Empire?',
            'answer': 'The first emperor of the Roman Empire was Augustus Caesar, also known as Octavian. He rose to power after defeating Mark Antony and Cleopatra at the Battle of Actium in 31 BCE. His reign marked the beginning of the Pax Romana, a period of relative peace and stability in the Roman world.'
          },
          {
            'topic': 'History of the Roman Empire',
            'question': 'Which event is traditionally considered the fall of the Western Roman Empire?',
            'answer': 'The traditional event marking the fall of the Western Roman Empire is the sack of Rome by the Visigoths in 410 CE. Led by Alaric I, this event symbolized the collapse of central authority and the vulnerability of the defences of Rome. This contributed to eventual fragmentation and decline of the empire.'
          }
          ]"
      }]
    })

    # raw_content = chatgpt_response["choices"][0]["message"]["content"].gsub("'s", "AAA").gsub('"', '\\"').gsub("'", '"').gsub("AAA", "'s")
    raw_content = chatgpt_response["choices"][0]["message"]["content"].gsub("\\'", "AAA").gsub('"', '\\"').gsub("'", '"').gsub("AAA", "'")
    response = JSON.parse(raw_content)

    # self.update_columns(title: response[0]["topic"])

    return response
  end
end
