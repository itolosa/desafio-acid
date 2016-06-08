module ActionMailerHelpers
  include ActiveJob::TestHelper

  def must_enqueue_action_mailer_job(mailer_class, mailer_method, *args)
    assert_enqueued_job(1) { yield }
    action_mailer_job_must_be_enqueued(mailer_class, mailer_method, *args)
  end

  # Define `action_mailer_job_must_be_enqueued`
  #    and `action_mailer_job_wont_be_enqueued`
  def action_mailer_job_must_be_enqueued(mailer_class, mailer_method, *args)
    assert_includes enqueued_jobs, action_mailer_job(mailer_class, mailer_method, *args)
  end

  private

  def action_mailer_job(mailer_class, mailer_method, *args)
    {
      job: ActionMailer::DeliveryJob,
      args: [
        mailer_class.to_s,
        mailer_method,
        'deliver_now',
        *ActiveJob::Arguments.serialize(args)
      ],
      queue: 'mailers'
    }
  end
end