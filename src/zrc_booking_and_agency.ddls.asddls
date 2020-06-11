@AbapCatalog.sqlViewName: 'ZRCBOOKAGEN'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Join of Booking and Agency'

define view ZRC_BOOKING_AND_AGENCY
  as select from ZRC_BOOKING   as Booking
    inner join   ZRC_AGENCY as Agency on Booking.agencynum = Agency.ID
{
  key Booking.carrid,
  key Booking.connid,
  key Booking.fldate,
  key Booking.bookid,
      Booking.agencynum,
      Booking.Amount,
      Booking.Currency,
      Booking.DaysAhead, 
      Agency.name,
      Agency.street,
      Agency.postcode,
      Agency.city,
      Agency.country
}

