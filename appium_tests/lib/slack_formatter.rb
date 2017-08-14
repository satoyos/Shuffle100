require 'rspec'
require 'slack-notifier'

RSpec::Support.require_rspec_core 'formatters/base_formatter'

class SlackFormatter < RSpec::Core::Formatters::BaseFormatter
  RSpec::Core::Formatters.register self, :example_passed, :example_failed

  def initialize(output)
    super(output)
    @results = Array.new
  end

  def example_passed(notification)
    @results << 'OK'
  end

  def example_failed(notification)
    @results << 'NG'
  end

  def  close(notification)
    post_alack
  end

  def post_slack
    notifier = Slack::Notifier.new(ENV['SLACK_DEV_WEBHOOK_URL'])

    if @results.include? 'NG'
      note = {
          text: 'ダメー',
          color: 'warning'
      }
    else
      note = {
          text: 'おっけー',
          color: 'good'
      }
    end

    notifier.post text: '', attachments: [note]
  end
end
