require 'test_helper'
require 'fixtures/sample_mail'

class MailFormTest < ActiveSupport::TestCase
  
  test "sample mail has name and email attributes" do
    sample = SampleMail.new
    sample.name = "User"
    assert_equal "User", sample.name
    sample.email = "user@ex.com"
    assert_equal "user@ex.com", sample.email
  end

  test "sample mail can clear attributes using clear_prefix" do
  	sample = SampleMail.new

  	sample.name = "User"
  	sample.email = "sasha@bla.com"
  	assert_equal "User", sample.name
  	assert_equal "sasha@bla.com", sample.email

  	sample.clear_name
  	sample.clear_email

  	assert_nil sample.name
  	assert_nil sample.email
  end

  test "sample mail can ask if attribute is present or not" do 
  	sample = SampleMail.new
  	assert !sample.name?

  	sample.name = "Sasha"
  	assert sample.name?

  	sample.email = ""
  	assert !sample.email?
  end

  setup do
  	ActionMailer::Base.deliveries.clear
  end

  test "delivers email with attributes" do 
  	sample = SampleMail.new
  	sample.email = "sasha@bla.com"
  	sample.deliver

  	assert_equal 1, ActionMailer::Base.deliveries.size
  	mail = ActionMailer::Base.deliver.last

  	assert_equal ["sasha@bla.com"], mail.form 
  	assert_match "Email: sasha@bla.com", mail.body.encoded
  end
end
