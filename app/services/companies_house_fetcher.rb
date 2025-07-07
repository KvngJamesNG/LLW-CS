class CompaniesHouseFetcher
  BASE_URL = "https://api.company-information.service.gov.uk"

  def self.fetch_recent_companies(keyword = "consulting")
    url = "#{BASE_URL}/search/companies?q=#{keyword}&items_per_page=200&order_by=created_on&order_direction=desc"
    api_key = ENV['COMPANIES_HOUSE_API_KEY']
    auth_token = Base64.strict_encode64("#{api_key}:")

    response = HTTParty.get(url, headers: {
      "Authorization" => "Basic #{auth_token}",
      "Content-Type" => "application/json"
    })

    if response.success?
      parsed = JSON.parse(response.body)
      # 🔥 Ensure this is the last line returned!
      return parsed["items"].map do |item|
        {
          name: item["title"],
          number: item["company_number"],
          address: item["address_snippet"],
          type: item["company_type"],
          status: item["company_status"]
        }
      end
    else
      puts "Error fetching data: #{response.code} - #{response.body}"
      return []
    end
  end


  def self.fetch_and_store(keyword = "status")
    companies = fetch_recent_companies(keyword)
    companies.each do |company_data|
      Company.find_or_create_by(company_number: company_data[:number]) do |company|
        company.name = company_data[:name]
        company.incorporated_on = Date.parse(company_data[:incorporated_on]) rescue nil
        company.status = company_data[:status]
        company.address = company_data[:address].to_s
      end
    end
  end
end
