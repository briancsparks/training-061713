require 'spec_helper'

describe 'the person view' do

  let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

  before(:each) do
    person.phone_numbers.create(number: "1235551234")
    person.phone_numbers.create(number: "1235555678")
    visit person_path(person)
  end

  it 'shows the phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end

  it "has a link to add a new phone number" do
    expect(page).to have_link("Add phone number",
      href: new_phone_number_path(person_id: person.id))
  end

  it "adds a new phone number" do
    page.click_link('Add phone number')
    page.fill_in('Number', with: '9999991111')
    page.click_button('Create Phone number')
    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('9999991111')
  end

end