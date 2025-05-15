class Applicant < ApplicationRecord
  has_one_attached :cv
  has_one_attached :other_documents

  validate :cv_format
  validate :other_documents_format, if: -> { other_documents.attached? }

  private

  def cv_format
    if cv.attached? && !cv.content_type.in?(%w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document))
      errors.add(:cv, "must be a PDF or Word document")
    end
  end

  def other_documents_format
    if other_documents.attached? && !other_documents.content_type.in?(%w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document))
      errors.add(:other_documents, "must be a PDF or Word document")
    end
  end
end
