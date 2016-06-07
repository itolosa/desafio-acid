class User < ActiveRecord::Base
  def authorized_with_image?(imageb64 = "")
    # do something with imageb64 here
    self.status == 200
  end
end
