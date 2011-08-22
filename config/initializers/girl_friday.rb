EMAIL_QUEUE = GirlFriday::WorkQueue.new(:user_email, :size => 3) do |msg|
  UserMailer.registration_email(msg).deliver
end
