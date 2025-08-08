resource "aws_cognito_user_pool" "main" {
  name = var.cognito_user_pool_name

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  user_pool_add_ons {
    advanced_security_mode = "ENFORCED"
  }

  tags = var.project_tags
}

resource "aws_cognito_user_pool_client" "main" {
  name         = var.cognito_user_pool_client_name
  user_pool_id = aws_cognito_user_pool.main.id

  # Public browser client (Hosted UI) – do NOT generate a secret
  generate_secret = false

  # Prefer Authorization Code flow (more secure than implicit)
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows  = ["code"]  # or ["implicit"] if you must
  allowed_oauth_scopes = ["openid", "email", "profile", "aws.cognito.signin.user.admin"]

  # IMPORTANT: use a real frontend callback (NOT your API URL)
  callback_urls = [
    "https://oauth.pstmn.io/v1/callback",          # temporary for testing
    # "http://localhost:3000/callback",            # your app callback
    # "https://your-frontend-app.com/callback"
  ]

  logout_urls = [
    "https://oauth.pstmn.io/v1/callback",
    # "http://localhost:3000/logout",
    # "https://your-frontend-app.com/logout"
  ]

  # Keep only what you actually use
  explicit_auth_flows = [
    "ALLOW_USER_SRP_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
    # Add the below only if you truly do server-side password logins:
    # "ALLOW_USER_PASSWORD_AUTH",
    # "ALLOW_ADMIN_USER_PASSWORD_AUTH",
    # "ALLOW_CUSTOM_AUTH"
  ]

  access_token_validity  = 60
  id_token_validity      = 60
  refresh_token_validity = 30
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }

  supported_identity_providers = ["COGNITO"]
}

resource "aws_cognito_user_pool_domain" "default_domain" {
  domain       = "hello-user-pool"  # ensure unique globally
  user_pool_id = aws_cognito_user_pool.main.id
}

resource "aws_cognito_user" "test_user" {
  user_pool_id = aws_cognito_user_pool.main.id
  username     = "admin"
  attributes = {
    email          = "soundaryacshcl@gmail.com"
    email_verified = "true"
  }
  temporary_password = "Admin1234!"
  message_action     = "SUPPRESS"

  lifecycle { ignore_changes = [password] }
}
