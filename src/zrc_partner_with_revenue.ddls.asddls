@AbapCatalog.sqlViewName: 'ZRCPARTREV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Partner With Revenue Union'
define view ZRC_PARTNER_WITH_REVENUE
  as select from ZRC_CUSTOMER_WITH_REVENUE as Customer
{
  key Customer.ID,
      'C' as type,
      Customer.Name,
      Customer.street,
      Customer.city,
      Customer.country,
      Customer.Amount,
      Customer.Currency,
      Customer.DaysAhead
}

union

select from ZRC_AGENCY_WITH_REVENUE as Agency
{
  key Agency.ID,
      'A' as type,
      Agency.name,
      Agency.street,
      Agency.city,
      Agency.country,
      Agency.Amount,
      Agency.Currency,
      Agency.DaysAhead
}
