CLASS zcl_table_func DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb.
    CLASS-METHODS customer_fuzzy FOR TABLE FUNCTION ZRC_CUSTOMER_FUZZY.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_table_func IMPLEMENTATION.

  METHOD customer_fuzzy BY DATABASE FUNCTION
                             FOR HDB LANGUAGE SQLSCRIPT
                             OPTIONS READ-ONLY
                             USING scustom.
    RETURN SELECT mandt, id, name, city, country
        FROM scustom
        WHERE contains( name, :name_in, fuzzy )
        ORDER BY score( ) desc;

  ENDMETHOD.
ENDCLASS.
