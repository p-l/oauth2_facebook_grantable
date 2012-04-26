# oauth2_facebook_grantable

Adds a grant_type "facebook" to the existing installation of
[devise_oauth2_providable](https://github.com/socialcast/devise_oauth2_providable)

## Features

* Allows to provide facebook_id and facebook_access_token to authenticate
  against an OAuth2 API made with [devise_oauth2_providable](https://github.com/socialcast/devise_oauth2_providable)


## Requirements

* [Devise](https://github.com/plataformatec/devise) authentication library
* [Rails](http://rubyonrails.org/) 3.1 or higher
* [Devise OAuth2 Providable](https://github.com/socialcast/devise_oauth2_providable)

## Installation

#### Install gem
```ruby
# Gemfile
gem 'oauth2_facebook_grantable'
```

#### Migrate database

It essentially adds a facebook_identifier column to the User model. It's
required so the plugin can find a user based on its facebook_id

```
$ rails g oauth2_facebook_grantable:install
$ rake db:migrate
```


#### Configure User model to support Facebook authentication

Add `:oauth2_facebook_grantable` to your `devise` declaration as seen bellow.

```ruby
class User
  devise :oauth2_providable,
    :oauth2_password_grantable,
    :oauth2_refresh_token_grantable,
    :oauth2_facebook_grantable
end
```


## Using with Facebook grant_type on the client-side

To authentitcate against to the API using Facebook credentials you need to post
the API with the parameter `facebook_identifier` and `facebook_access_token` as
shown bellow:

```ruby
post("/oauth/token",
  :format => :json,
  :facebook_identifier => facebook_id,
  :facebook_access_token => facebook_access_token,
  :grant_type => "facebook",
  :client_secret => client_secret,
  :client_id => client_identifier)
```


## Contributing

* Fork the project
* Fix the issue
* Add unit tests
* Submit pull request on github



## License

Copyright (C) 2012 Pierre-Luc Simard
See LICENSE.txt for further details.

