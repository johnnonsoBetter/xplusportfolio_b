require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
 it { should have_many(:projects) } 
 it { should have_many(:anticipations) } 
 it { should have_many(:notifications) } 
 it {should have_many(:suggestions)}
 it { should have_many(:webpush_subscriptions) } 
end