@AbapCatalog.sqlViewName: 'ZRCAGENREV'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Customer with Revenue'
define view ZRC_AGENCY_WITH_REVENUE
  as select from ZRC_BOOKING_AND_AGENCY as Agency
{
  key Agency.agencynum as ID,
      Agency.name,
      Agency.street,
      Agency.postcode,
      Agency.city,
      Agency.country,
      @Semantics.amount.currencyCode: 'Currency'
      sum( Agency.Amount )    as Amount,
      Agency.Currency,
      avg( Agency.DaysAhead ) as DaysAhead
}
group by
    Agency.agencynum,
    Agency.name,
    Agency.street,
    Agency.postcode,
    Agency.city,
    Agency.country,
    Agency.Currency


  
