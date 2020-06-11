@AbapCatalog.sqlViewName: 'ZRCCUSTREV'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Customer with Revenue Aggregations'
define view ZRC_CUSTOMER_WITH_REVENUE
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
group by
  Customer.customid,
  Customer.Name,
  Customer.street,
  Customer.postcode,
  Customer.city,
  Customer.country,
  Customer.Currency
