module ApplicationHelper

  def l_if(object, options={})
      I18n.localize(object, options) if object.presence
  end

  def time_data(range = (6..22))
    range.each.inject([]) do |result, num|
      result << ["#{"%02d" % num}:00", "#{"%02d" % num}:00"] << ["#{"%02d" % num}:30", "#{"%02d" % num}:30"]
    end
  end

  def js_modal(render_options={})
    render_options.reverse_merge!(:layout => '/application/modal')
    raw <<-TXT
        $('.modal').modal('hide');
        $('.modal, .modal-backdrop').remove();
        var modal_win = $('#{escape_javascript(render(render_options))}');
        $('form', modal_win).data('remote', true);
        $('body').append(modal_win);
        $('.modal').modal('show');
    TXT

  end


  #def text_field_spam_time_stamp
  #  hidden_field_tag :time_stamp,  Base64.encode64(Time.zone.now.to_s)
  #end
end
