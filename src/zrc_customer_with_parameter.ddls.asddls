@AbapCatalog.sqlViewName: 'ZRCCUSTREV2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Customer with parameter'
define view ZRC_CUSTOMER_WITH_PARAMETER
  with parameters
    @EndUserText.label: 'Consider flights up to this date'
    @Environment.systemField: #SYSTEM_DATE
    p_flightsbefore : abap.dats

  as select from ZRC_BOOKING_AND_CUSTOMER as Customer
{
  key Customer.customid         as ID,
      Customer.Name,
      Customer.street,
      Customer.postcode,
      Customer.city,
      Customer.country,
      @Semantics.amount.currencyCode: 'Currency'
      sum( Customer.Amount )    as Amount,
      Customer.Currency,
      avg( Customer.DaysAhead ) as DaysAhead
}
where
  fldate < $parameters.p_flightsbefore
group by
  Customer.customid,
  Customer.Name,
  Customer.street,
  Customer.postcode,
  Customer.city,
  Customer.country,
  Customer.Currency
