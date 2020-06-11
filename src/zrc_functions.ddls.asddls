@AbapCatalog.sqlViewName: 'ZRCFUNC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS Views Functions Example'

@AbapCatalog.buffering.type: #GENERIC
@AbapCatalog.buffering.numberOfKeyFields: 4
@AbapCatalog.buffering.status: #ACTIVE
define view ZRC_FUNCTIONS
  as select from sbook   as Booking
    inner join   scustom as Customer on Booking.customid = Customer.id
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
      Booking.customid,
      concat_with_space(Customer.form, Customer.name, 1)     as Name,
      Customer.street,
      Customer.postcode,
      Customer.city,
      Customer.country,
      @EndUserText.label: 'Discount Factor'
      @EndUserText.quickInfo: 'Customer Specific'
      division(cast(Customer.discount as abap.int4), 100, 2) as Discount   
}
where
  Booking.cancelled <> 'X'
