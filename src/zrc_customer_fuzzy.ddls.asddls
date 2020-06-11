@EndUserText.label: 'Table Functions'
define table function ZRC_CUSTOMER_FUZZY
with parameters name_in: s_custname
returns {
  mandt : mandt;
  id : s_customer;
  name: s_custname;
  city: s_city;
  country: country;
}
implemented by method zcl_table_func=>customer_fuzzy;