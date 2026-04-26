class Applicant < ApplicationRecord
  ALLOWED_DOCUMENT_TYPES = %w[
    application/pdf
    application/msword
    application/vnd.openxmlformats-officedocument.wordprocessingml.document
  ].freeze

  has_one_attached :cv
  has_one_attached :other_documents

  validate :cv_format
  validate :other_documents_format, if: -> { other_documents.attached? }

  private

  def cv_format
    return unless cv.attached? && !cv.content_type.in?(ALLOWED_DOCUMENT_TYPES)

    errors.add(:cv, "must be a PDF or Word document")
  end

  def other_documents_format
    return unless other_documents.attached? && !other_documents.content_type.in?(ALLOWED_DOCUMENT_TYPES)

    errors.add(:other_documents, "must be a PDF or Word document")
  end
end
