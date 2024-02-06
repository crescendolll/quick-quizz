class QuestionsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-3.5-turbo-0125",
      messages: [{
        role: "system",
        content: "You are a helpful assistant that generate quiz questions based on the provided content. Respond with five short questions and four plausible options/ answers for each question, of which only one is correct. Provide your answer in a  JSON structure similar to this, do not use single or double quotes inside questions and answers
          [
            {
              'topic: '<The topic of the quiz>',
              'question': '<The quiz question you generate>',
              'options': {
                'option1': {'body': 'Plausible option 1>', 'isItCorrect': ‹true or false>},
                'option2': {'body': '<Plausible option 2>', 'isItCorrect': ‹true or false>},
                'option3': {'body': '«Plausible option 3>', 'isItCorrect': ‹true or false>},
                'option4': {'body': '«Plausible option 4>', 'isItCorrect': ‹true or false>}
              }
            },
            {
              'topic: '<The topic of the quiz>',
              'question': '<The quiz question you generate>',
              'options': {
                'option1': {'body': 'Plausible option 1>', 'isItCorrect': ‹true or false>},
                'option2': {'body': '<Plausible option 2>', 'isItCorrect': ‹true or false>},
                'option3': {'body': '«Plausible option 3>', 'isItCorrect': ‹true or false>},
                'option4': {'body': '«Plausible option 4>', 'isItCorrect': ‹true or false>}
              }
            }
          ]"
      },
      {
        role: "user",
        content: "Generate a multiple choice quiz about the solar system. Give me only the text of the quiz, without any of your own answer like 'Here is a quiz I made'."
      },
      {
        role: "assistant",
        content: "{'topic': 'Premier League location', 'question': 'Where is the Premier League played?',
        'options': {'option1': {'body': 'France', 'isItCorrect': false}, 'option2': {'body': 'England', 'isItCorrect': true}, 'option3': {'body': 'Sweden', 'isItCorrect': false}}}"
      }]
    })
    # parsed_response = JSON.parse(chatgpt_response["choices"][0]["message"]["content"])
    # @content = parsed_response['question']
    raw_content = chatgpt_response["choices"][0]["message"]["content"].gsub("'", '"')
    @content = JSON.parse(raw_content)
    # @question = @content["question"]
  end
end

      # console test

# client = OpenAI::Client.new
# client.chat(parameters: {
#   model: "gpt-3.5-turbo-0125",
#   messages: [{
#     role: "system",
#     content: "You are a helpful assistant that generate quiz questions based on the provided content. Respond with five short questions and four plausible options/ answers for each question, of which only one is correct. Provide your answer in JSON structure like this {'topic: '<The topic of the quiz>', 'question': '<The quiz question you generate>', 'options': { 'option1': {'body': 'Plausible option 1>', 'isItCorrect': ‹true or false>}, 'option2': {'body': '<Plausible option 2>', 'isItCorrect': ‹true or false>}, 'option3': {'body': '«Plausible option 3>', 'isItCorrect': ‹true or false>}}}"
#   },
#   {
#     role: "user",
#     content: "Generate a multiple choice quiz about the solar system. Give me only the text of the quiz, without any of your own answer like 'Here is a quiz I made'."
#   },
#   {
#     role: "assistant",
#     content: "{'topic': 'Premier League location', 'question': 'Where is the Premier League played?',
#     'options': {'option1': {'body': 'France', 'isItCorrect': false}, 'option2': {'body': 'England', 'isItCorrect': true}, 'option3': {'body': 'Sweden', 'isItCorrect': false}}}"
#   }]
# })





# "You are a helpful assistant that generate quiz questions based on the provided content. Respond with five short questions and four plausible options/ answers for each question, of which only one is correct. Provide your answer in a  JSON structure similar to this {'topic: '<The topic of the quiz>', 'question': '<The quiz question you generate>', 'options': { 'option1': {'body': 'Plausible option 1>', 'isItCorrect': ‹true or false>}, 'option2': {'body': '<Plausible option 2>', 'isItCorrect': ‹true or false>}, 'option3': {'body': '«Plausible option 3>', 'isItCorrect': ‹true or false>}}}"
