# encoding: utf-8
module Bootstrap::LabelsHelper

  def label_state(state, &block)
    block = capture(&block) if block_given?
    Erector.inline do
      span :class => ['label', "state-#{state}"].join(' ') do
        unless block
          @t = t((state || :nil), :scope => [:contract, :states])
          text! @t.center(10, ' ').to_s
        else
          text! block
        end
      end
    end.to_html
  end

end