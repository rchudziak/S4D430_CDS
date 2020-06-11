@AbapCatalog.sqlViewName: 'ZRCANNO'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ABAP Annotations'

@AbapCatalog.buffering.type: #GENERIC
@AbapCatalog.buffering.numberOfKeyFields: 4
@AbapCatalog.buffering.status: #ACTIVE
define view ZRC_ANNOTATIONS
  as select from sbook   as Booking
    inner join   scustom as Customer on Booking.customid = Customer.id
{
  key Booking.carrid,
  key Booking.connid,
  key Booking.fldate,
  key Booking.bookid,
      Booking.class,
      Booking.forcuram as Amount @<Semantics.amount.currencyCode: 'Currency',
      Booking.forcurkey as Currency @<Semantics.currencyCode: true, 
      Booking.luggweight @<Semantics.quantity.unitOfMeasure: 'WUNIT', 
      Booking.wunit @<Semantics.unitOfMeasure: true,
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
