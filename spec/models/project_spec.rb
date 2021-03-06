require 'rails_helper'

RSpec.describe Project, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should belong_to(:user) } 
 
  it { should have_many(:comments) }
  it { should have_many(:suggestions) } 
  it { should have_many(:tools) } 
  it { should have_many(:project_photos) } 
end
