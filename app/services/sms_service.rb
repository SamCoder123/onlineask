class SmsService
  def initialize(options)
    @to_phone_number = options[:phone_number] unless options[:phone_number].nil?
  end

  def send_sms
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: ENV["TWILIO_PHONE_NUMBER"],
      to: "+86" + @to_phone_number,
      body: "学霸说：你已经充值成功了"
    )
  end
end
