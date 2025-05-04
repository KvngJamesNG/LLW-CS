class ContactsController < ApplicationController
  protect_from_forgery with: :null_session  # Allows API-style JSON POST

  def create
    @contact = Contact.new(contact_params)

    Rails.logger.info("Saved contact: #{@contact.inspect}")

    if @contact.save
      # Remove or comment out the following line to prevent email sending
      # ContactMailer.contact_email(
      #   @contact.name,
      #   @contact.email,
      #   @contact.phone,
      #   @contact.message
      # ).deliver_later

      render json: { success: true, message: "Your message has been successfully saved. You will receive a follow-up email shortly." }, status: :created
    else
      render json: { success: false, errors: @contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # ✅ Strong parameter protection
  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :message)
  end
end
