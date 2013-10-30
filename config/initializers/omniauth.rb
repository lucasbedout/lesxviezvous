OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '490620914369032', 'e37824282407bcf8911605893867df6a'
  provider :twitter, 'JBFwbA8tarcyhfzYKqdaw', 'JCtoUfYJlYb0IxUSgEtijufEinhrVftHZcYFlG1Sw'
  provider :identity
end