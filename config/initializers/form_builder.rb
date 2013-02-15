class ActionView::Helpers::FormBuilder
  alias :original_label :label

  # Add a '*' after the field label if the field is required
  def label(method, content_or_options = nil, options = nil, &block)
    if content_or_options && content_or_options.class == Hash
      options = content_or_options
    else
      content = content_or_options
    end

    # `object` can be a simple model or a decorated model
    obj = object # object.kind_of?(Draper::Decorator) ? object.model : object

    required_mark = ''
    required_mark = ' *'.html_safe if obj.class.validators_on(method).map(&:class).include? ActiveModel::Validations::PresenceValidator

    content ||= I18n.t("activerecord.attributes.#{obj.class.name.underscore}.#{method}", default: method.to_s.humanize)
    content = content + required_mark

    self.original_label(method, content, options || {}, &block)
  end
end
