*&---------------------------------------------------------------------*
*& Report zrc_param_s1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrcr_path.

TYPES: BEGIN OF ty_s_customer,
         id         TYPE zrc_customer_with_parameter-id,
         name       TYPE zrc_customer_with_parameter-name,
         street     TYPE zrc_customer_with_parameter-street,
         postcode   TYPE zrc_customer_with_parameter-postcode,
         city       TYPE zrc_customer_with_parameter-city,
         country    TYPE zrc_customer_with_parameter-country,
         amount     TYPE zrc_customer_with_parameter-amount,
         currency   TYPE zrc_customer_with_parameter-currency,
         days_ahead TYPE zrc_customer_with_parameter-daysahead,
       END OF ty_s_customer.

TYPES ty_t_customers TYPE STANDARD TABLE OF ty_s_customer
                        WITH NON-UNIQUE KEY id.

DATA gt_customers TYPE ty_t_customers.

* ALV Processing

DATA go_salv TYPE REF TO cl_salv_table.
DATA gx_excp TYPE REF TO cx_salv_error.

* Selection Screen

PARAMETERS pa_city TYPE s_city DEFAULT 'New York' LOWER CASE.

START-OF-SELECTION.
* Data Retrieval *************************************************************
  SELECT
      FROM zrc_association
      FIELDS customid AS id,
      \_customer-name,
      \_customer-street,
      \_customer-postcode,
      \_customer-city,
      \_customer-country,
      SUM(  amount ) AS amount,
      currency,
      AVG(  daysahead ) AS days_ahead
      WHERE \_customer-city = @pa_city
      AND fldate < @sy-datum
      GROUP BY customid,
      \_customer-name,
      \_customer-street,
      \_customer-postcode,
      \_customer-city,
       \_customer-country,
       currency
       ORDER BY \_customer-city, \_customer-name
      INTO TABLE @gt_customers.

* output *************************************************************
  TRY.
      cl_salv_table=>factory(
      IMPORTING
        r_salv_table   = go_salv
      CHANGING
        t_table        = gt_customers
      ).

      go_salv->display( ).
    CATCH cx_salv_error INTO gx_excp.    "
      MESSAGE gx_excp TYPE 'I'.
  ENDTRY.
