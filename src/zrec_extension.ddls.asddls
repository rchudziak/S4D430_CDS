@AbapCatalog.sqlViewAppendName: 'ZRCEXTENSION'
@EndUserText.label: 'Extension of CDS View'
extend view ZRC_EXTENDED with ZREC_EXTENSION
  association [1] to spfli as _Connection on  Booking.carrid = _Connection.carrid
                                          and Booking.connid = _Connection.connid
{
  Booking.Class,
  Booking.counter,
  _Connection

}
