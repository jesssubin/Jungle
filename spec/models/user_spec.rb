require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do 
    it "validates password when password and password confrimation matches" do 
      @user = User.new(email: 'test@test.com', name: 'user first',  password: '12345', password_confirmation: '12345')
      @user.save!
      expect(@user.password).to eq(@user.password_confirmation)
    end

    it "should require name" do
      @user = User.new(email: 'test@test.com', name: nil,  password: '12345', password_confirmation: '12345')
      expect(@user).to_not be_valid
    end

    it "should require email" do
      @user = User.new(email: nil, name: 'user first',  password: '12345', password_confirmation: '12345')
      expect(@user).to_not be_valid
    end   

    it "should require password" do
      @user = User.new(email: 'test@test.com', name: 'user first',  password: nil, password_confirmation: '12345')
      expect(@user).to_not be_valid
    end

    it "should require password_confirmation" do
      @user = User.new(email: 'test@test.com', name: 'user first',  password: '12345', password_confirmation: nil)
      expect(@user).to_not be_valid
    end

    it "should require password length of minimum 5 characters" do 
      @user = User.new(email: 'test@test.com', name: 'user first',  password: "1234", password_confirmation: "1234")
      @user.valid? 
      expect(@user).to_not be_valid 
    end  
  end

  describe '.authenticate_with_credentials' do 
    it 'should pass with valid credentials' do
      user = User.new( name: 'name', email: 'test@test.com', password: 'password', password_confirmation: 'password')
      user.save
      expect(User.authenticate_with_credentials('test@test.com', 'password')).not_to be(nil)
    end
  end
end   

