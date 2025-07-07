class CompaniesController < ApplicationController
  def index
    @companies = Company.order(incorporated_on: :desc)
  end

  def fetch
    CompaniesHouseFetcher.fetch_and_store
    redirect_to companies_path, notice: "Companies fetched successfully."
  end
end
