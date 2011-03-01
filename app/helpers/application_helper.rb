module ApplicationHelper
  
  def current_class?(test_path)
    return 'current' if request.request_uri == test_path
    ''
  end
  
  def current1_class?(test_path)
    return 'current1' if request.request_uri == test_path
    ''
  end
  
  
end
