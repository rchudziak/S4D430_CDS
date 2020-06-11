@AbapCatalog.sqlViewName: 'ZRCBOOKCUST'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Join of Booking and Customer'

define view ZRC_BOOKING_AND_CUSTOMER
  as select from ZRC_BOOKING   as Booking
    inner join   ZRC_CUSTOMER as Customer on Booking.customid = Customer.id
{
  key Booking.carrid,
  key Booking.connid,
  key Booking.fldate,
  key Booking.bookid,
      Booking.customid,
      Booking.Amount,
      Booking.Currency,
      Booking.DaysAhead, 
      Customer.Name,
      Customer.street,
      Customer.postcode,
      Customer.city,
      Customer.country
}

