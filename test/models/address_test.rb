require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  def test_validate_presence_city
    assert Address.create(street: 'Poznanska', zip_code: '12-123').invalid?, "can't be blank"
    assert Address.create(city: 'Poznan', street: 'Poznanska', zip_code: '12-123').valid?
  end

  def test_validate_presence_street
    assert Address.create(city: 'Poznan', zip_code: '12-123').invalid?, "can't be blank"
    assert Address.create(city: 'Poznan', street: 'Poznanska', zip_code: '12-123').valid?
  end

  def test_validate_presence_zip_code
    assert Address.create(city: 'Poznan', street: 'Poznanska').invalid?, "can't be blank"
    assert Address.create(city: 'Poznan', street: 'Poznanska', zip_code: '12-123').valid?
  end

  def test_validate_format_zip_code
    assert Address.create(city: 'Poznan', street: 'Poznanska', zip_code: '12123').invalid?, "Zip code format should be XX-XXX"
    assert Address.create(city: 'Poznan', street: 'Poznanska', zip_code: '1-1234').invalid?, "Zip code format should be XX-XXX"
    assert Address.create(city: 'Poznan', street: 'Poznanska', zip_code: '12-123-').invalid?, "Zip code format should be XX-XXX"
    assert Address.create(city: 'Poznan', street: 'Poznanska', zip_code: '12-123').valid?
  end
end
