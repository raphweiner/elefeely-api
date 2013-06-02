require "spec_helper"

describe UserMailer do
  let(:user) { User.create!(email: 'test@email.com', password: 'password') }

  describe "welcome_email" do
    let(:mail) { UserMailer.welcome_email(user) }

    it "renders the headers" do
      mail.subject.should eq("Welcome to Elefeely")
      mail.to.should eq([user.email])
      mail.from.should eq(["elefeely@gmail.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end
end
