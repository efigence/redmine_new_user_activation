class ActivationDateHookListener < Redmine::Hook::ViewListener
  render_on :view_users_form, :partial => "users/activation_date"
end
