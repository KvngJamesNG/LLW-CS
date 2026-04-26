class CompaniesHouseFetcher
  BASE_URL = "https://api.company-information.service.gov.uk"

  def self.fetch_recent_companies(keyword = "consulting")
    api_key = ENV["COMPANIES_HOUSE_API_KEY"]
    auth_token = Base64.strict_encode64("#{api_key}:")
    url = "#{BASE_URL}/search/companies?q=#{keyword}&items_per_page=200&order_by=created_on&order_direction=desc"

    response = HTTParty.get(url, headers: {
      "Authorization" => "Basic #{auth_token}",
      "Content-Type" => "application/json"
    })

    unless response.success?
      Rails.logger.error("Companies House API error: #{response.code} - #{response.body}")
      return []
    end

    JSON.parse(response.body)["items"].map do |item|
      {
        name:            item["title"],
        number:          item["company_number"],
        address:         item["address_snippet"],
        type:            item["company_type"],
        status:          item["company_status"],
        incorporated_on: item["date_of_creation"]
      }
    end
  end

  def self.fetch_and_store(keyword = "consulting")
    fetch_recent_companies(keyword).each do |data|
      Company.find_or_create_by(company_number: data[:number]) do |company|
        company.name            = data[:name]
        company.incorporated_on = Date.parse(data[:incorporated_on]) rescue nil
        company.status          = data[:status]
        company.address         = data[:address].to_s
      end
    end
  end
end
