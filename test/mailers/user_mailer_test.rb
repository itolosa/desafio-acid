require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "login success" do
    # Send the email, then test that it got queued
    email = UserMailer.login_success_email('iverdejo@acid.cl', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/601.5.17 (KHTML, like Gecko) Version/9.1 Safari/601.5.17').deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
 
    # Test the body of the sent email contains what we expect it to
    assert_equal ['no-reply@desafioacid.com'], email.from
    assert_equal ['iverdejo@acid.cl'], email.to
    assert_equal 'Login success!', email.subject
  end
end