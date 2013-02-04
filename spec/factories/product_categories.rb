# encoding: utf-8
help_pc = <<-TXT
<h6>Popis</h6><ul>
<li> Například heslo do BIOSu či operačního systému</li>
<li>neoriginální části je nutno vyjmout (RAM, SD karty, CD atd.)</li>
<li>Adaptér zasílejte jen tehdy, pokud to povaha závady vyžaduje a zaslání rovněž uveďte do popisu závady</li>
</ul>
<span class='help-inline'>Sevis neručí za data, proveďte si prosím zálohu</span>
TXT

help_printer = <<-TXT
<h6>Popis</h6><ul>
<li>neoriginální části je nutno vyjmout (RAM, SD karty, CD atd.)</li>
<li>Adaptér zasílejte jen tehdy, pokud to povaha závady vyžaduje a zaslání rovněž uveďte do popisu závady</li>
</ul>
TXT

template_pc = <<-TXT
Popis závady:

Zasílám příslušenství:
TXT

CATEGORIES = {
    'Tiskárna' => {:brands => ['Samsung', 'HP, Hewlett Packard', 'Dell'],
                   :defect_help => help_printer,
                   :defect_template => template_pc
    },
    'Notebook, Laptop' => {:brands => ['Samsung', 'HP, Hewlett Packard', 'Dell'],
                           :defect_help => help_pc,
                           :defect_template => template_pc
    }
}


FactoryGirl.define do

  factory :product_category do
    name 'Category 1'
  end

end