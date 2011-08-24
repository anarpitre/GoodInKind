class ModifyBookings < ActiveRecord::Migration
  def self.up
    remove_column :bookings, :cardonfile_id
    add_column :bookings, :mref, :string

    # Fields for first-giving (used for auditing too)
    add_column :bookings, :accountName, :string, :length => 60
    add_column :bookings, :billToFirstName, :string, :length => 60
    add_column :bookings, :billToMiddleName, :string, :length => 60
    add_column :bookings, :billToLastName, :string, :length => 60
    add_column :bookings, :billToAddressLine1, :string, :length => 60
    add_column :bookings, :billToAddressLine2, :string, :length => 60
    add_column :bookings, :billToAddressLine3, :string, :length => 60
    add_column :bookings, :billToCity, :string, :length => 60
    add_column :bookings, :billToState, :string, :length => 60
    add_column :bookings, :billToZip, :string, :length => 30
    add_column :bookings, :billToCountry, :string
    add_column :bookings, :billToEmail, :string, :length => 50
    add_column :bookings, :billToPhone, :string, :length => 30
    add_column :bookings, :billToAddr, :string, :length => 15
  end

  def self.down
    add_column :bookings, :cardonfile_id, :string
    remove_column :bookings, :mref

    remove_column :bookings, :accountName
    remove_column :bookings, :billToFirstName
    remove_column :bookings, :billToMiddleName
    remove_column :bookings, :billToLastName
    remove_column :bookings, :billToAddressLine1
    remove_column :bookings, :billToAddressLine2
    remove_column :bookings, :billToAddressLine3
    remove_column :bookings, :billToCity
    remove_column :bookings, :billToState
    remove_column :bookings, :billToZip
    remove_column :bookings, :billToCountry
    remove_column :bookings, :billToEmail
    remove_column :bookings, :billToPhone
    remove_column :bookings, :billToAddr
  end

end
