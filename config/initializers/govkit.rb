if defined? GovKit
  GovKit.configure do |config|
    # Get an API key for Sunlight's Open States project here:
    # http://services.sunlightlabs.com/accounts/register/
    config.sunlight_apikey = 'fa7231797f00422ca5f74f3d9bbe74dd'

    ##API key for Votesmart
    # http://votesmart.org/services_api.php
    config.votesmart_apikey = '1955cd6bdeb12521f0f62d86c5c236db'

    # API key for NIMSP. Request one here:
    # http://www.followthemoney.org/membership/settings.phtml
    config.ftm_apikey = 'e8e96e97dbca58cbe698bf18cf3f53d2'

    # Api key for OpenCongress
    # http://www.opencongress.org/api
    config.opencongress_apikey = 'ad2c56a25a5fe3e5b05c0684e7da92265f255793'
    
    # Technorati API key
    # config.technorati_apikey = 'YOUR_TECHNORATI_APIKEY'
    
    # Other things you could set here include alternate URLs for
    # the APIs. See GovKit::Configuration for available attributes.
  end
end
