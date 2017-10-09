require 'rspec'
require 'slack-notifier'

RSpec::Support.require_rspec_core 'formatters/base_formatter'

class SlackFormatter < RSpec::Core::Formatters::BaseFormatter
  attr_reader :results

  RSpec::Core::Formatters.register self, :example_passed, :example_failed

  def initialize(output)
    super(output)
    @results = Array.new
    @start_time = Time.now
  end

  def example_passed(notification)
    @results << 'OK'
  end

  def example_failed(notification)
    @results << 'NG'
  end

  def  close(notification)
    post_slack
  end

  def post_slack
    notifier = Slack::Notifier.new(ENV['SLACK_DEV_WEBHOOK_URL'])
    # note = {}

    if @results.include? 'NG'
      note = {
          text: ':scream: 百読のAppiumテストで異状あり！',
          color: 'warning'
      }
    else
      note = {
          text: "百読のAppiumテスト、#{@results.size}個のテストが全部成功です！ :thumbsup: \n" +
              spent_time_str,
          color: 'good'
      }
    end

    notifier.post text: '', attachments: [note]
  end

  def spent_time_str
    diff_secs = (Time.now - @start_time).to_i
    " テストの所要時間: #{diff_secs / 60}分 #{diff_secs % 60}秒"
  end
end

# 以下、上記クラスの動作確認用コード！

if $0 == __FILE__
  formatter = SlackFormatter.new(nil)
  formatter.example_passed(nil)
  formatter.example_passed(nil)
  # formatter.example_failed(nil)
  puts "@results => #{formatter.results}"
  formatter.post_slack
end

