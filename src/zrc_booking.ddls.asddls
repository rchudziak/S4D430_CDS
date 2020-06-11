@AbapCatalog.sqlViewName: 'ZRCBOOK'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Booking w Calculations'
define view ZRC_BOOKING
  as select from sbook   as Booking
{
  key Booking.carrid,
  key Booking.connid,
  key Booking.fldate,
  key Booking.bookid,
      case Booking.class
         when 'Y' then 'Economy'
         when 'C' then 'Business'
         when 'F' then 'First'
         else '???'
       end                                                   as Class,
      currency_conversion(
        amount => Booking.forcuram,
        source_currency => Booking.forcurkey,
        round           => 'X',
        target_currency => cast( 'USD' as abap.cuky ),
        exchange_rate_type => 'M',
        exchange_rate_date => Booking.order_date,
        error_handling      => 'SET_TO_NULL' )               as Amount @<Semantics.amount.currencyCode: 'Currency',
      cast('USD' as abap.cuky)                               as Currency @<Semantics.currencyCode: true,
      Booking.luggweight @<Semantics.quantity.unitOfMeasure: 'WUNIT',
      Booking.wunit @<Semantics.unitOfMeasure: true,
      Booking.order_date,
      dats_days_between(Booking.order_date, Booking.fldate) as DaysAhead,
      Booking.agencynum,
      Booking.counter,
      Booking.customid
}
where
  Booking.cancelled <> 'X'
