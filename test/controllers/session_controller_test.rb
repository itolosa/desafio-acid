require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should post login" do
    User.all.each do |user|
      imageb64 = 'TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlzIHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2YgdGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGludWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRoZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4='
      stub_request(:post, "http://serene-shore-63130.herokuapp.com/rest/verifyUser/#{user.email}").with(body: hash_including(:image)).to_return(status: user.status, body: "{ message: \"#{user.status == 200 ? "OK" : "No Autorizado"}\" }")
      post :login, {email: user.email, image: imageb64}
      assert_response user.status
    end
  end

  test "should enqueue mail on login" do
    User.all.each do |user|
      user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/601.5.17 (KHTML, like Gecko) Version/9.1 Safari/601.5.17'
      imageb64 = 'TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlzIHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2YgdGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGludWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRoZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4='
      stub_request(:post, "http://serene-shore-63130.herokuapp.com/rest/verifyUser/#{user.email}").with(body: hash_including(:image)).to_return(status: user.status, body: "{ message: \"#{user.status == 200 ? "OK" : "No Autorizado"}\" }")
      @request.user_agent = user_agent
      post :login, {email: user.email, image: imageb64}
      assert_response user.status
      if user.status == 200
        action_mailer_job_must_be_enqueued UserMailer, 'login_success_email', user.email, user_agent
      else
        action_mailer_job_must_be_enqueued UserMailer, 'login_failed_email', user.email, user_agent
      end
    end
  end
end