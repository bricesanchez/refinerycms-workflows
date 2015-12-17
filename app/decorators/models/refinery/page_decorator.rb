require 'workflow'
require 'paper_trail'

begin
  module Refinery
    Page.class_eval do
      has_paper_trail class_name: 'Refinery::PageVersion'

      translates :title, :menu_title, :custom_slug, :slug, include: :seo_meta, versioning: :paper_trail

      include Workflow

      workflow do
        state :new do
          event :submit, :transitions_to => :awaiting_review
        end

        state :awaiting_review do
          event :review, :transitions_to => :being_reviewed
        end

        state :being_reviewed do
          event :accept, :transitions_to => :accepted
          event :reject, :transitions_to => :rejected
        end

        state :accepted
        state :rejected
      end

      def submit
        begin
          Refinery::PageMailer.notification(@page, request).deliver
        rescue
          logger.warn "There was an error delivering a submit notification:\n#{$!}\n"
        end
      end

      def accept
        puts "Send confirmation to client"
        puts "Publish page current version"
      end

      def reject
        puts "Sending email to the author explaining the reason..."
      end

      def review(reviewer = '')
        puts "[#{reviewer}] is now reviewing the article"
      end
    end
  end
rescue NameError
end