module Refinery
  module Workflows
    class Mailer < ::ActionMailer::Base

      def confirmation(workflow, request)
        @workflow = workflow
        mail :subject  => Refinery::Workflows::Setting.confirmation_subject,
             :to       => workflow.email,
             :from     => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>",
             :reply_to => Refinery::Workflows::Setting.notification_recipients.split(',').first
      end

      def notification(workflow, request)
        @workflow = workflow
        mail :subject  => Refinery::Workflows::Setting.notification_subject,
             :to       => Refinery::Workflows::Setting.notification_recipients,
             :from     => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>"
      end

    end
  end
end
