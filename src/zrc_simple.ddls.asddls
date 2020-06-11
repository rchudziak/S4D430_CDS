@AbapCatalog.sqlViewName: 'ZRCSIMPLE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Simple CDS View'
define view ZRC_SIMPLE as select from sbook {
    key carrid,
    key connid,
    key fldate,
    key bookid,
    class,
    forcuram,
    forcurkey,
    luggweight,
    wunit,
    order_date,
    agencynum,
    counter,
    customid    
}
