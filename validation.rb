require 'dry-validation'

EMAIL_REGEX = /.*@.*/

schema = Dry::Validation.Schema do
  required(:name).filled
  required(:email).filled(format?: EMAIL_REGEX)
  #required(:age).maybe(:int?)
  #required(:age) { int? & gt?(18) }
  #required(:age) { none? | int? }
  required(:age) { filled? > int? }
  required(:address).schema do
    required(:street).filled
    required(:city).filled
    required(:zipcode).filled.int?
  end
end

puts schema.call(
  name: 'Jane',
  email: 'jane@doe.org',
  age: 1,
  address: { street: 'Street 1', city: 'NYC', zipcode: '1234' }
).inspect

