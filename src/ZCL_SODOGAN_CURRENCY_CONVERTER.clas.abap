*/***
"! How to use the Test Double framework
"! We have an external dependancy to a API and this needs to be stubbed!
"! Currency conversion is done by API zif_sodogan_currency_provider
"! Stubbing means we replace the real call with a Dummy call!
"! We do not test the external API or can be a BAPI etc..
*/
class zcl_sodogan_currency_converter definition
  public
  final
  create public .

  public section.
    methods constructor importing io_currency_provider type ref to zif_sodogan_currency_provider.
    "! Currency conversion is done by API zif_sodogan_currency_provider
    methods convert_currency importing
                                       from          type string
                                       to            type string
                                       value         type numeric
                             returning value(result) type decfloat16
                             .
  protected section.
  private section.
    data: mif_currency_rate_provider type ref to zif_sodogan_currency_provider.
endclass.



class zcl_sodogan_currency_converter implementation.
  method constructor.
    me->mif_currency_rate_provider = io_currency_provider.
  endmethod.
  method convert_currency.
* Convert using the external provider

    try.
        result = me->mif_currency_rate_provider->convert_currency(
            from   = from
            to     = to
            value = value
         ).
      catch cx_invalid_format into data(lo_exception).
        "handle exception
        RAISE exception type cx_invalid_format
          exporting
            previous = lo_exception
        .
    endtry.

  endmethod.

endclass.