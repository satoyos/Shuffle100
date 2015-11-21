module AppDelegateAccessor
  module_function

  def app_delegate
    UIApplication.sharedApplication.delegate
  end
end