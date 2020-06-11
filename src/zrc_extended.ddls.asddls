@AbapCatalog.sqlViewName: 'ZRCEXTENDED'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Association example'

define view ZRC_EXTENDED
  as select from ZRC_BOOKING as Booking
  association [1..1] to ZRC_CUSTOMER as _Customer on Booking.customid = _Customer.id
{
  key Booking.carrid,
  key Booking.connid,
  key Booking.fldate,
  key Booking.bookid,
      Booking.customid,
      Booking.Amount,
      Booking.Currency,
      Booking.DaysAhead,
      _Customer
      //      Customer.Name,
      //      Customer.street,
      //      Customer.postcode,
      //      Customer.city,
      //      Customer.country      
}
