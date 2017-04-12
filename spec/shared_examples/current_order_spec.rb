require 'rails_helper'

shared_examples_for 'current order' do
  let(:model) { described_class }
  
  it "has a full name" do
    person = create(model.to_s.underscore.to_sym, first_name: "Stewart", last_name: "Home")
    expect(person.full_name).to eq("Stewart Home")
  end
end