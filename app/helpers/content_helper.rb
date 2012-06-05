module ContentHelper
  def resource_name
    :pessoa
  end

  def resource
    @resource ||= Pessoa.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:pessoa]
  end
end
