module SessionFilter
  extend ActiveSupport::Concern

  def self.included(base)
    base.send :helper_method, :filters_for, :session_filter, :current_filter?, :get_filter
    base.send :before_filter, :set_search_filter
  end

  # FILTERS (keeps ActiveRecord model filter setting in session)
  module InstanceMethods

    protected

    # get one filter
    def get_filter(model, filter)
      session['search'][model.to_s][filter.to_s] if session['search'] && session['search'][model.to_s].presence
    end

    # get all filters for model
    def filters_for(model)
      filters = session['search'][model.to_s] if session['search'] && session['search'][model.to_s].presence
      filters.delete_if { |k, v| v.nil? } if filters
    end

    # build link params
    def session_filter(model, value={})
      {:n => '', :search => {model => value}}
    end

    def current_filter?(model, filter, link)
      link_params = Rack::Utils.parse_nested_query(link)
      if link_params['search'] && link_params['search'][model.to_s].presence
        return true if link_params['search'][model.to_s][filter.to_s] == get_filter(model, filter)
      else
        return false
      end
    end

    def set_search_filter()
      if params[:search].presence
        session[:search] ||= {}
        params[:search].each do |model, fields|
          session[:search][model] ||= {}
          if fields.respond_to?(:each)
            fields.each do |field, value|
              session[:search][model][field] = value.presence || nil
            end
          else
            session[:search][model] = {}
          end
        end
      end
    end

  end

end

class ActionController::Base
  include SessionFilter
end