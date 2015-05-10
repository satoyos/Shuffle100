module AppDelegateAccessor
  def app_delegate
    UIApplication.sharedApplication.delegate
  end
end