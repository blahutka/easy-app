# encoding: utf-8
class Views::Application::Address < Erector::Widget
  needs :object

  def content
    address do
      full_name
      br
      full_address
      br
      country
    end
    hr
    full_contact

  end

  def full_contact
    div class: 'account-contacts' do
      dl class: 'dl-horizontal' do
        dt raw "#{@object.class.human_attribute_name(:name)}:&nbsp;"
        dd do
          handle_none(:first_name) do |obj|
            text obj.first_name
          end
          text nbsp
          handle_none(:last_name) do |obj|
            text obj.last_name
          end
        end
        contact_row(:phone)
        contact_row(:email)
      end
    end
  end

  def contact_row(attribute)
    dt do
      text @object.class.human_attribute_name(attribute)
      text ':'
      text nbsp
    end
    dd do
      handle_none(attribute) do |obj|
        text @object.send(attribute)
      end
    end
  end

  def full_address
    handle_none(:street) do |obj|
      text obj.street
    end
    text ', '
    handle_none(:zip) do |obj|
      text obj.zip
    end
    text! nbsp
    handle_none(:city) do |obj|
      text obj.city
    end
  end

  def full_name
    strong do
      handle_none(:company_name) do |obj|
        text obj.company_name
      end
    end
  end

  def country
    text 'Česká republika'
  end

  private

  def handle_none(attribute)
    if @object.send(attribute).present?
      yield(@object)
    else
      title = @object.class.human_attribute_name(attribute).presence || attribute.to_s
      abbr :title => "#{title} hodnota není uložena", class: 'unknown' do
        text 'n/a'
      end
    end
  end

end