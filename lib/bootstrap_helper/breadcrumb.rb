module BootstrapHelper
  module Breadcrumb
    def self.included(receiver)
      receiver.extend         ClassMethods
      receiver.send :include, InstanceMethods
      receiver.send :helper, Helpers
      receiver.send :before_filter, :set_breadcrumbs
    end

    module ClassMethods
    end

    module InstanceMethods
      protected

      def set_breadcrumbs
        @breadcrumbs = []
      end

      def drop_breadcrumb(title = nil, url = nil)
        title ||= @page_title

        if title && url
          @breadcrumbs.push(view_context.link_to(title, url))
        elsif title
          @breadcrumbs.push(title)
        end
      end

      def drop_page_title(title)
        @page_title = title
        @page_title
      end

      def no_breadcrumbs
        @breadcrumbs = []
      end
    end

    module Helpers
      def render_breadcrumb
        return "" if @breadcrumbs.size <= 0
        content_tag(:ul, class: "breadcrumb menu clearfix") do
          @breadcrumbs.each_with_index do |c, i|
            breadcrumb_class = []
            breadcrumb_class << "first" if i.zero?
            breadcrumb_class << "last active" if i == (@breadcrumbs.length - 1)

            breadcrumb_content = c

            concat content_tag(:li, breadcrumb_content, class: breadcrumb_class)
          end
        end
      end
    end
  end
end
