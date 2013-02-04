#encoding: utf-8
class Views::Application::Tables::Filters::ButtonReset < Erector::Widget
  needs :filter_name

  def content
    div :class => 'btn-group filters-remove', style: 'visibility:hidden;' do
      a :href => collection_path(session_filter(@filter_name, nil)),
        'data-remote' => false, :class => 'btn btn-mini btn-success' do
        i(:class => 'icon-remove icon-white') {}
        text nbsp;
        text t('filters.disable')
      end
    end
  end
end