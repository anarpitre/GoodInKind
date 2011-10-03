Factory.define :booking do |b|
  b.seats_booked 1
  b.charge_on_date nil
  b.charge_status "success"
  b.donation_amount 55
  b.additional_donation_amount 0.0 
  b.CC_charges nil
  b.GIK_charges nil
  b.total_amount 11.0
  b.mref "20110914--640536638"
  b.accountName "amit kulkarni"
  b.billToFirstName "amit"
  b.billToMiddleName nil
  b.billToLastName "kulkarni"
  b.billToAddressLine1 "asas"
  b.billToAddressLine2 "ssassaasas"
  b.billToAddressLine3 "wqwew"
  b.billToCity "Newyork"
  b.billToState "NY"
  b.billToZip "12345"
  b.billToCountry "US"
  b.billToEmail "amitkkulkarni.84@gmail.com"
  b.billToPhone nil
  b.association :user
  b.association :service
end
