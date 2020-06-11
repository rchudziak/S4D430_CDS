@AbapCatalog.sqlViewName: 'ZRCAGEN'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Solution: Flight Agency'

define view ZRC_AGENCY
  as select from stravelag as Agency
{
      key Agency.agencynum as ID,
      Agency.name,
      Agency.street,
      Agency.postcode,
      Agency.city,
      Agency.country
}

