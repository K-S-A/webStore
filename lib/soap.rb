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
      init_date: res[:СвНаимЮЛ][:@ДатаНачДейств],
      region: address_base(res)[:СубъектРФ],
      city: address_base(res)[:Город],
      address: parse_address(res),
      zipcode: parse_zipcode(res),
      phone: res[:СвУправлДеят][:СведДолжнФЛ][:ФИО][:@НомТел]
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

  private

  def address_base(res)
    res[:СвАдрес][:Адрес][:Состав]
  end

  def parse_address_street(res)
    address_base(res)[:Улица]
  end

  def address_base_additional(res)
    address_base(res)[:ДопАдрЭл]
  end

  def parse_address(res)
    "#{parse_address_street(res)}, #{parse_address_building(res)}"
  end

  def parse_zipcode(res)
    address_base_additional(res).find { |el| el[:@ТипАдрЭл] == '10100000' }.try(:[], :@Значение)
  end


  def parse_address_building(res)
    address_base_additional(res).map do |el|
      next unless el[:Номер]
      key = case el[:Номер][:@Тип]
            when '1010' then 'д.'
            when '1050' then 'к.'
            when '1060' then 'с.'
            when '2010' then 'кв.'
            when '2030' then 'оф.'
            when '2050' then 'комн.'
            else ''
            end
      "#{key}#{el[:Номер][:@Значение]}"
    end.compact.join(', ')
  end
end
