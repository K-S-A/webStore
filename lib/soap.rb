# require 'savon'

module Soap
  private

  def get_corporation_requisites_by_inn(number)
    res = soap_client
      .call(__method__, message: {INN: number.to_s})
      .body["#{__method__}_response".to_sym]
      .try(:[], :РеквизитыЮрЛица)
    
    return unless res
    
    {
      inn: res[:@ИНН],
      kpp: res[:@КПП],
      ogrn: res[:@ОГРН],
      company_name: res[:СвНаимЮЛ][:@НаимЮЛСокр],
      head: res[:СвУправлДеят][:СведДолжнФЛ][:ФИО].values.join(' '),
      init_date: res[:СвНаимЮЛ][:@ДатаНачДейств]
    }
  end

  def operations
    soap_client.operations
  end

  def soap_client
    Savon.client(wsdl: ENV['API_URL_1C'], 
                 headers: { 'SOAPAction' => ''},
                 basic_auth: [ENV['LOGIN_1C'], ENV['PASS_1C']],
                 convert_request_keys_to: :camelcase)
  end
end
