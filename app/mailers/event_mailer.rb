class EventMailer < ActionMailer::Base
  add_template_helper(EventsHelper)
  add_template_helper(LocationsHelper)

  def from_organizer(options)
    # Sendgrid API allows a single SMTP request to send multiple
    # email messages. Change this to something else if we move
    # away from Sendgrid.
    # http://sendgrid.com/docs/API_Reference/SMTP_API/
    headers['X-SMTPAPI'] = {
      to: options[:recipients]
    }.to_json

    @event = options[:event]
    @sender = options[:sender]
    @body = options[:body]

    mail(
      to: 'noreply@openhatch.org', # supposedly required even with X-SMTPAPI
      from: "#{@sender.full_name} <#{@sender.email}>",
      subject: options[:subject]
    )
  end

  def unpublished_event(event)
    @event = event

    headers['X-SMTPAPI'] = {
      to: User.where('admin = ? OR publisher = ?', true, true).map(&:email)
    }.to_json

    mail(
      to: 'noreply@openhatch.org',
      subject: "OpenHatch event #{@event.published? ? 'created' : 'awaits approval'}: '#{@event.title}' by #{@event.organizers.first.full_name}"
    )
  end

  def new_event(event)
    @event = event
    return unless @event.location
    @chapter = @event.chapter

    headers['X-SMTPAPI'] = {
      to: User.joins(:chapters).where('users.allow_event_email = ?', true).where('chapters.id' => [@chapter.id]).map(&:email)
    }.to_json

    mail(
      to: 'noreply@openhatch.org',
      subject: "[#{@chapter.name}] New event posted: '#{@event.title}'"
    )
  end
end
