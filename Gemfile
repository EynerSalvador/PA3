source "https://rubygems.org"

# Jekyll Core
gem "jekyll", "~> 4.4"  # Versión actualizada para mayor compatibilidad
gem "jekyll-feed", "~> 0.17"
gem "jekyll-seo-tag", "~> 2.8"
gem "minima", "~> 2.5"

# Autenticación y Servidor
gem "sinatra", "~> 2.2", require: false
gem "rack", "~> 2.2"
gem "rack-rewrite", "~> 1.5"
gem "puma", "~> 6.0"      # Servidor web para desarrollo

# Seguridad y Autenticación
gem "bcrypt", "~> 3.1"   # Para hashing de contraseñas (mejor que JWT para auth)
gem "jwt", "~> 2.7", require: false # Opcional para APIs

# Desarrollo y Testing
gem "rake", "~> 13.0"
gem "rspec", "~> 3.12", group: :test
gem "rack-test", "~> 2.0", group: :test

group :jekyll_plugins do
  gem "jekyll-sass-converter", "~> 3.0"
  gem "kramdown", "~> 2.4"
end
