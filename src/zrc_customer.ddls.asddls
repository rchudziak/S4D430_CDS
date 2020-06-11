@AbapCatalog.sqlViewName: 'ZRCCUST'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Customer w Calculations'

define view ZRC_CUSTOMER
  as select from scustom as Customer
{
      key Customer.id,
      concat_with_space(Customer.form, Customer.name, 1)     as Name,
      Customer.street,
      Customer.postcode,
      Customer.city,
      Customer.country,
      @EndUserText.label: 'Discount Factor'
      @EndUserText.quickInfo: 'Customer Specific'
      division(cast(Customer.discount as abap.int4), 100, 2) as Discount   
}

