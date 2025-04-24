module Jekyll
  class LoginEndpoint < Generator
    safe true
    priority :high

    def generate(site)
      # Registrar el endpoint solo en entornos de desarrollo
      if Jekyll.env == "development"
        site.pages << LoginApiPage.new(site)
      end
    end
  end

  class LoginApiPage < Page
    def initialize(site)
      @site = site
      @base = site.source
      @dir  = 'api'
      @name = 'login.json'

      self.process(@name)
      self.content = '{}'
      self.data = {
        'layout' => nil,
        'permalink' => '/api/login/',
        'sitemap' => false
      }
    end

    def render_with_payload(payload)
      # Este método se ejecutará cuando se llame al endpoint
      request = payload['request']
      
      # Solo responder a solicitudes POST
      if request&.post?
        auth_service = AuthService.new
        data = JSON.parse(request.body.read) rescue {}
        
        result = auth_service.login(data['username'], data['password'])
        
        if result[:success]
          {
            success: true,
            token: generate_jwt(result[:user]),
            user: result[:user].to_h
          }.to_json
        else
          {
            success: false,
            error: result[:error]
          }.to_json
        end
      else
        { error: "Método no permitido" }.to_json
      end
    end

    private

    def generate_jwt(user)
      payload = {
        user_id: user[:id],
        member_id: user[:member_id],
        exp: Time.now.to_i + 3600 # Expira en 1 hora
      }
      
      JWT.encode(payload, ENV['JWT_SECRET'] || 'secreto_por_defecto', 'HS256')
    end
  end
end
