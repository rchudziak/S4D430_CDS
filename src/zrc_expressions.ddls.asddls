@AbapCatalog.sqlViewName: 'ZRCEXPR'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS Views Expressions'

@AbapCatalog.buffering.type: #GENERIC
@AbapCatalog.buffering.numberOfKeyFields: 4
@AbapCatalog.buffering.status: #ACTIVE
define view ZRC_EXPRESSIONS
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
      end as Class,  
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
      Customer.country,
      @EndUserText.label: 'Discount Factor'
      @EndUserText.quickInfo: 'Customer Specific'
      cast(Customer.discount as abap.fltp) / 100.0 as discount
}
where Booking.cancelled <> 'X'
