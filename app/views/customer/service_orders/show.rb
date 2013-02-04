# encoding: utf-8
class Views::Customer::ServiceOrders::Show < Views::Application::Show

 def form_preview
   super :except => [:service_provider_id, :id]
 end

end