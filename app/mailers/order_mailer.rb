class OrderMailer < ApplicationMailer

  def pdf_email(order, target, pdf)
    pdf_decoded = Base64.decode64(pdf).force_encoding('utf-8')
    subject = "Счет_№#{order.stock_number}"

    attachments["#{subject}_Промтехресурс.pdf"] = {
      mime_type: 'application/pdf',
      content: pdf_decoded
    }

    mail(to: target, subject: subject)
  end

end
