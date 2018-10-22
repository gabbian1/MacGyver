*"* use this source file for your ABAP unit test classes
CLASS ycl_macgyver_test DEFINITION FINAL FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PRIVATE SECTION.
    METHODS:
      test_email_validation      FOR TESTING,
      test_cpf_validation        FOR TESTING,
      test_cnpj_validation       FOR TESTING,
      test_swift_code_validation FOR TESTING,
      test_remain_char_code      FOR TESTING.
ENDCLASS.

CLASS ycl_macgyver_test IMPLEMENTATION.
  METHOD test_email_validation.
    cl_abap_unit_assert=>assert_true( act = NEW ycl_macgyver( )->validate_email( 'thisisavalid@email.com' )
                                      msg = TEXT-001 ).
  ENDMETHOD.

  METHOD test_cpf_validation.
    cl_abap_unit_assert=>assert_true( act = NEW ycl_macgyver( )->validate_brazil_cpf( '40052762459' )
                                      msg = TEXT-002 ).
  ENDMETHOD.

  METHOD test_cnpj_validation.
    cl_abap_unit_assert=>assert_true( act = NEW ycl_macgyver( )->validate_brazil_cnpj( '28.554.220/0001-86' )
                                      msg = TEXT-003 ).
  ENDMETHOD.

  METHOD test_swift_code_validation.
    cl_abap_unit_assert=>assert_true( act = NEW ycl_macgyver( )->validate_swift_code( bank_country = 'BR' swift_code = 'ITAUBRSP' )
                                      msg = TEXT-004 ).
  ENDMETHOD.

  METHOD test_remain_char_code.
    DATA: word TYPE char40 VALUE 'Word'.

    cl_abap_unit_assert=>assert_equals( act = NEW ycl_macgyver( )->get_remain_char_count( word )
                                        exp = 36
                                        msg = TEXT-005 ).
  ENDMETHOD.
ENDCLASS.
