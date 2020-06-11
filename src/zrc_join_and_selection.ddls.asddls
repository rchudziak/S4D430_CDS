@AbapCatalog.sqlViewName: 'ZRCJOIN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Booking and Customer Join'
define view ZRC_JOIN_AND_SELECTION
  as select from sbook   as Booking
    inner join   scustom as Customer on Booking.customid = Customer.id
{
  key Booking.carrid,
  key Booking.connid,
  key Booking.fldate,
  key Booking.bookid,
      Booking.class,
      Booking.forcuram as Amount,
      Booking.forcurkey as Currency,
      Booking.luggweight,
      Booking.wunit,
      Booking.order_date,
      Booking.agencynum,
      Booking.counter,
      Booking.customid,
      Customer.name,
      Customer.street,
      Customer.postcode,
      Customer.city,
      Customer.country
}
where Booking.cancelled <> 'X'
