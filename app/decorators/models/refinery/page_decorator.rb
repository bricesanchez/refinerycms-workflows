require 'workflow'

begin
  Refinery::Page.class_eval do
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
      puts 'sending email to the moderator with the diff'
    end

    def reject
      puts 'sending email to the author explaining the reason...'
    end

    def review(reviewer = '')
      puts "[#{reviewer}] is now reviewing the article"
    end
  end
rescue NameError
end