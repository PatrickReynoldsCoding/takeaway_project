require("bundler")
bundler.require()

account_sid = ENV["TWILIO_ACCOUNT_SID"]
auth_token = ENV["TWILIO_AUTH_TOKEN"] 

@client - Twilio::REST::Client.new(account_sid, auth_token)

@client.messages.create(
to: "+4407941613054",
from: "44444444444",
body: "Thanks for ordering"