class Bot < WitBot::Bot::Base
  intents :Test, :login, :missing_pin

  protected

  def on_output(message)
    puts "Output: #{message.text}"
  end

  def on_missing_pin(message)
    puts 'Pin used to be missing.'
    login message.outcome
  end

  def on_login(message)
    login message.outcome
  end

  def login(outcome)
    if (pin_code = outcome.entities[:pin_code])
      output "Logged you in with the pin code: #{pin_code}"
    else
      conversation.thread.context.state << :missing_pin
      output 'Please include a pin code.'
    end
  end

  def on_Test(message)
    outcome = message.outcome

    thing = outcome.entities["thing"]
    adjective = outcome.entities["adjective"]

    msg = "Yup, that #{thing || 'thing'} is #{adjective || 'a word'}."

    output msg
  end
end