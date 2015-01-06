class AdminMailer < ActionMailer::Base
  def test_group_mail(options)
    headers['X-SMTPAPI'] = {
      to: [options[:to]]
    }.to_json

    mail(
      to: 'noreply@openhatch.org',
      from: "noreply@openhatch.org",
      subject: '[OpenHatch Events] Group Email Test'
    ) do |format|
      format.html { render html: mail_content('group') }
    end
  end

  def test_individual_mail(options)
    mail(
      to: options[:to],
      from: "noreply@openhatch.org",
      subject: '[OpenHatch Eventsl] Individual Email Test'
    ) do |format|
      format.html { render html: mail_content('individual') }
    end
  end

  private

  def mail_content(type)
    <<-EOT.strip_heredoc
      Hey there!

      This is a test message from OpenHatch Events!

      If you received it, it means that #{type} emails can probably be sent successfully from #{Rails.configuration.action_mailer.default_url_options[:host]}
    EOT
  end
end
