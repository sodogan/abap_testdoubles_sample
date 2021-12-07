*"* use this source file for your ABAP unit test classes
*Steps: GIVEN; WHEN ;THEN
*1- Create the Stub providing an interface
*2-Configure the call
*3-Call the real call
*4- Assert
class lcl_answer definition for testing.
  public section.
    interfaces if_abap_testdouble_answer.
endclass.
class lcl_answer implementation.
  method if_abap_testdouble_answer~answer.
  endmethod.

endclass.

class ltcl_test definition inheriting from cl_aunit_assert
for testing duration short
risk level harmless.
  public section.
    methods convert_usd_to_trl for testing.
    methods convert_trl_to_usd for testing
      raising
        cx_invalid_format.
  private section.
    class-methods: class_setup,class_teardown.
    methods: setup,teardown.

    data: mo_cut type ref to zcl_sodogan_currency_converter.
endclass.

class ltcl_test implementation.

  method class_setup.

  endmethod.

  method class_teardown.

  endmethod.

  method setup.
  endmethod.

  method teardown.
  endmethod.

  method convert_usd_to_trl.

* GIVEN
    data(lo_stub) = cast zif_sodogan_currency_provider( cl_abap_testdouble=>create( 'ZIF_SODOGAN_CURRENCY_PROVIDER' ) ).

** Configure the CALL
    data(lo_configuration) = cl_abap_testdouble=>configure_call( lo_stub ).
**What should it return-set that it does not which value is called with!
    lo_configuration->ignore_parameter( name = 'value' )->returning( '56.56' ).
**Which method to be stubbed!
    lo_stub->convert_currency( from = 'USD' to ='TRY'  value = '0.00' ).
**WHEN
* The real call
**Inject the stub to the real call
    data(lo_cut) = new zcl_sodogan_currency_converter( io_currency_provider = lo_stub ).
    data(actual) =  lo_cut->convert_currency( from = 'USD' to ='TRY'  value = '99.56' ).

**THEN
    assert_equals( msg = 'msg' exp = '56.56' act = actual ).
  endmethod.

  method convert_trl_to_usd.
* GIVEN
    data(lo_stub) = cast zif_sodogan_currency_provider( cl_abap_testdouble=>create( 'ZIF_SODOGAN_CURRENCY_PROVIDER' ) ).

** Configure the CALL
    data(lo_configuration) = cl_abap_testdouble=>configure_call( lo_stub ).
**What should it return-set that it does not which value is called with!
    lo_configuration->ignore_all_parameters( )->raise_exception( new cx_invalid_format(  ) ).
**Which method to be stubbed!
    lo_stub->convert_currency( from = 'USD' to ='TRY'  value = '0.00' ).
**WHEN
* The real call
**Inject the stub to the real call
    try.
        data(lo_cut) = new zcl_sodogan_currency_converter( io_currency_provider = lo_stub ).
        data(actual) =  lo_cut->convert_currency( from = 'TRY' to ='USD'  value = '99.56' ).
        fail( 'Should not come here no exception caught' ).

      catch cx_root into data(lo_exception).
**THEN

    endtry.
  endmethod.

endclass.