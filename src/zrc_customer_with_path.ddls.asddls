@AbapCatalog.sqlViewName: 'ZRCCUSTASSO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Path Expressions in CDS DDL'
define view ZRC_CUSTOMER_WITH_PATH
  with parameters
    @EndUserText.label: 'Consider flights up to this date'
    @Environment.systemField: #SYSTEM_DATE
    p_flightsbefore : abap.dats

  as select from ZRC_ASSOCIATION as Customer
{
  key Customer.customid         as ID,
      Customer._Customer.Name,
      Customer._Customer.street,
      Customer._Customer.postcode,
      Customer._Customer.city,
      Customer._Customer.country,
      @Semantics.amount.currencyCode: 'Currency'
      sum( Customer.Amount )    as Amount,
      Customer.Currency,
      avg( Customer.DaysAhead ) as DaysAhead
}
where
  fldate < $parameters.p_flightsbefore
group by
  Customer.customid,
  Customer._Customer.Name,
  Customer._Customer.street,
  Customer._Customer.postcode,
  Customer._Customer.city,
  Customer._Customer.country,
  Customer.Currency
