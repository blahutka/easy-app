class Views::Admin::ServiceProviders::Index < Views::Application::Index



    def header_links
      super(remote: true)
    end
end