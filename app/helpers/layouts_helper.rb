# frozen_string_literal: true
module LayoutsHelper
  # Used to achieve nested layouts without content_for. This helper relies on
  # Rails internals, so beware that it make break with future major versions
  # of Rails. Taken from https://gist.github.com/mattbrictson/9240548
  #
  # Usage: For example, suppose "child" layout extends "parent" layout.
  # Use <%= yield %> as you would with non-nested layouts, as usual. Then on
  # the very last line of layouts/child.html.erb, include this:
  #
  #     <% parent_layout "parent" %>
  #
  def parent_layout(layout)
    @view_flow.set(:layout, output_buffer)
    output = render(file: "layouts/#{layout}")
    self.output_buffer = ActionView::OutputBuffer.new(output)
  end
end