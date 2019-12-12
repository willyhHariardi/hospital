module ApplicationHelper
  def flash_error?(form, key)
    form.present? && form.errors&.include?(key) && form.errors[key].join('\n')
  end

  def active_for(path)
    current_path = path.remove '?locale=id'
    'active' if request.path.eql?(current_path.remove '?locale=id')
  end

  def body_for
    return '' if request.path.eql?(admin_session_path)
    'ks-navbar-fixed ks-sidebar-empty ks-sidebar-position-fixed ks-page-header-fixed ks-theme-primary'
  end

  
end
  