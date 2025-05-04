class ContactMailer < ApplicationMailer
  default to: "adewale@llw-cs.com"
  def contact_email(name, email, phone, message)
    @name = name
    @phone = phone
    @message = message

    mail(
      from: "info@llw-cs.com",     # ✅ This is your authorized sender
      reply_to: email,                 # ✅ The user's real email for replying
      subject: "Message from #{name} via llw-cs.com"
    )
  end
end
