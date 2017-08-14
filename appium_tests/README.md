# How to run Appium tests

It takes long (about 30 - 40 minutes) to run all Appium tests, so Slack notification has been introduced.

When RSpec tests to run Appium tests finish, the test result gets posted to Slack.

To designate the Slack Webhook URL, use environment variable `SLACK_DEV_WEBHOOK_URL` 

for example, 

```bash
$ export SLACK_DEV_WEBHOOK_URL=https://hooks.slack.com/servicesXXX_some_given_url_XXX
```

And, change dir to THIS directory, and run the command below.

```bash
$ bundle exec rspec *_spec.rb -r ./lib/slack_formatter.rb
```

