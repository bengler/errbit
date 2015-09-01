class NotificationServices::SlackService < NotificationService
  Label = "slack"
  Fields += [
    [:service_url, {
      :placeholder => 'Slack Hook URL (https://hooks.slack.com/services/XXXXXXXXX/XXXXXXXXX/XXXXXXXXX)',
      :label => 'Hook URL'
    }]
  ]

  def check_params
    if Fields.detect {|f| self[f[0]].blank? }
      errors.add :base, "You must specify your Slack Hook url."
    end
  end

  def message_for_slack(problem)
    "*#{problem.app.name}:* #{problem.message.to_s.lines.first} #{problem_url(problem)}"
  end

  def post_payload(problem)
    payload = {
      :attachments => [
        {
           :fallback => message_for_slack(problem),
           :title => problem.message.to_s.lines.first.truncate(100),
           :title_link => problem_url(problem),
           :text => "*#{problem.app.name}* (#{problem.notices_count} times)",
           :mrkdwn_in => ["text"],
           :color => "#D00000"
        }
      ]
    }
    payload[:channel] = '#staging' if problem.environment == 'staging'
    payload.to_json
  end

  def create_notification(problem)
    HTTParty.post(service_url, :body => post_payload(problem), :headers => { 'Content-Type' => 'application/json' })
  end

  def configured?
    service_url.present?
  end
end
