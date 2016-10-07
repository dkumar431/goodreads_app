class CronJob
    include Sidekiq::Worker
    def perform
        UserMailer.sample_email('dkumar431@gmail.com').deliver_now        
    end
end