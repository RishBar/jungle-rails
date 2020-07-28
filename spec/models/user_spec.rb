require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "valid if name, email, pass, and pass_conf are set" do
      @user = User.create(name: "Barz", email: "Barz12@gmail.com", password: "123456", password_confirmation: "123456")
      expect(@user).to be_valid
    end
    it "not valid if name not set" do
      @user = User.create(name: "", email: "Barz12@gmail.com", password: "123456", password_confirmation: "123456")
      expect(@user).to_not be_valid
    end
    describe "Email" do
      it "not valid if email not set" do
        @user = User.create(name: "Barz", email: "", password: "123456", password_confirmation: "123456")
        expect(@user).to_not be_valid
      end
      it "not valid if email already exist" do
        @first_user = User.create(name: "Barz", email: "BARZ12@GMAIL.COM", password: "123456", password_confirmation: "123456")
        @user = User.create(name: "Barz", email: "Barz12@gmail.com", password: "123456", password_confirmation: "123456")
        expect(@user).to_not be_valid
      end
    end
    describe "Password and Password_confirmation" do
      it "not valid if pass not set" do
        @user = User.create(name: "Barz", email: "Barz12@gmail.com", password: "", password_confirmation: "123456")
        expect(@user).to_not be_valid
      end
      it "not valid if pass_conf not set" do
        @user = User.create(name: "Barz", email: "Barz12@gmail.com", password: "123456", password_confirmation: "")
        expect(@user).to_not be_valid
      end
      it "not valid if pass_conf and pass not same" do
        @user = User.create(name: "Barz", email: "Barz12@gmail.com", password: "123456", password_confirmation: "1234567")
        expect(@user).to_not be_valid
      end
      it "not valid if pass not minimum length" do
        @user = User.create(name: "Barz", email: "Barz12@gmail.com", password: "12345", password_confirmation: "12345")
        expect(@user).to_not be_valid
      end
    end
  end

  describe '.authenticate_with_credentials' do
    it "authenticates if password and email match" do
      @user = User.create(name: "Barz", email: "Barz12@gmail.com", password: "123456", password_confirmation: "123456")
      expect(User.authenticate_with_credentials("Barz12@gmail.com", "123456")).to be_a User
    end
    it "does not authenticates if password does not match" do
      @user = User.create(name: "Barz", email: "Barz12@gmail.com", password: "123456", password_confirmation: "123456")
      expect(User.authenticate_with_credentials("Barz12@gmail.com", "1234567")).to_not be_a User
    end
    it "does not authenticates if email does not match" do
      @user = User.create(name: "Barz", email: "Barz12@gmail.com", password: "123456", password_confirmation: "123456")
      expect(User.authenticate_with_credentials("Barz@gmail.com", "123456")).to_not be_a User
    end
    it "authenticates if email is not written in correct case" do
      @user = User.create(name: "Barz", email: "Barz12@gmail.com", password: "123456", password_confirmation: "123456")
      expect(User.authenticate_with_credentials("BARZ12@GMAIL.COM", "123456")).to be_a User
    end
    it "authenticates if email has whitespace trailing or beginning" do
      @user = User.create(name: "Barz", email: "Barz12@gmail.com", password: "123456", password_confirmation: "123456")
      expect(User.authenticate_with_credentials("   BARZ12@GMAIL.COM   ", "123456")).to be_a User
    end
  end
end