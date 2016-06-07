# force presence of env vars
case Rails.env
when 'production'
  Figaro.require_keys("secret_key_base", "pass_mailer", "user_mailer")
when 'development'
  Figaro.require_keys("pass_mailer", "user_mailer")
when 'test'
  Figaro.require_keys("pass_mailer", "user_mailer")
end