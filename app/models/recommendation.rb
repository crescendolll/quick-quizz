require 'uri'

class Recommendation < ApplicationRecord
  belongs_to :quiz

  validates :answers, presence: true

  def test
    test = "test"
  end

  def generate_ai_recommendation
    response = get_ai_answer
    response.each do |answer|
      new_recommendation = Recommendation.new(answer: answer["answer"], quiz: self)
      new_recommendation.save!
      # new_question.generate_choices(response[index])
    end

    # TODO: add recs?
    # recommendations.create!(content: "recs")
  end

  def get_ai_answer
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-3.5-turbo-0125",
      messages: [{
        role: "system",
        content: "You are a helpful assistant that generates answers to provided questions. Respond with answers no longer than 300 characters for each question. Provide your answer in a  JSON structure similar to this.
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
          Under no circumstances use double quotes in your JSON response. Use single quotes instead. If you use double quotes, the JSON will be invalid and an error will occur. If you are unsure about the JSON structure, please refer to the example above."
      },
      {
        role: "user",
        content: "Generate an answer for each of these questions: #{questions}. Give me only the text of the answers, without any of your own text like 'Here are the answers I made'. Make sure each answer is no longer than 300 characters."
      },
      {
        role: "assistant",
        content: "[
          {
            'topic': 'History of the Roman Empire',
            'question': 'Who was the first emperor of the Roman Empire?',
            'answer': 'The first emperor of the Roman Empire was Augustus Caesar, also known as Octavian. He rose to power after defeating Mark Antony and Cleopatra at the Battle of Actium in 31 BCE. His reign marked the beginning of the Pax Romana, a period of relative peace and stability in the Roman world.'},
          {
            'topic': 'History of the Roman Empire',
            'question': 'Which event is traditionally considered the fall of the Western Roman Empire?',
            'answer': 'The traditional event marking the fall of the Western Roman Empire is the sack of Rome by the Visigoths in 410 CE. Led by Alaric I, this event symbolized the collapse of central authority and the vulnerability of Rome's defenses. This contributed to the empire's eventual fragmentation and decline.'
          }
          ]"
      }]
    })

    raw_content = chatgpt_response["choices"][0]["message"]["content"].gsub("\\'", "AAA").gsub('"', '\\"').gsub("'", '"').gsub("AAA", "'")
    response = JSON.parse(raw_content)

    raise
    # self.update_columns(title: response[0]["topic"])

    return response
  end
end
