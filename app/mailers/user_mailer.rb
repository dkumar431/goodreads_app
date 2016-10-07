class UserMailer < ApplicationMailer
    
    default from: "dkumar431@gmail.com"

    def sample_email(email)
        mail(to: email, subject: "Sample Email.")
    end    
end
