class User < ActiveRecord::Base
  include Soap
  include InnControlSum

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :recoverable , :validatable
  devise :database_authenticatable, :registerable, :rememberable, :trackable


  def fill_requisites(inn)    
    return unless valid_inn?(inn)
    assign_attributes(get_corporation_requisites_by_inn(inn))

  rescue Savon::SOAPFault, Savon::HTTPError
  end
end
