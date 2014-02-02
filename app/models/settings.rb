class Settings < Settingslogic
  source "#{Rails.root}/config/payments.yml"
  namespace Rails.env
end
