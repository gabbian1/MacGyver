class YCL_MACGYVER definition
  public
  final
  create public .

public section.

  interfaces YIF_VALIDATORS .

  aliases VALIDATE_BRAZIL_CNPJ
    for YIF_VALIDATORS~VALIDATE_BRAZIL_CNPJ .
  aliases VALIDATE_BRAZIL_CPF
    for YIF_VALIDATORS~VALIDATE_BRAZIL_CPF .
  aliases VALIDATE_CHILE_RUT
    for YIF_VALIDATORS~VALIDATE_CHILE_RUT .
  aliases VALIDATE_EMAIL
    for YIF_VALIDATORS~VALIDATE_EMAIL .
  aliases VALIDATE_SWIFT_CODE
    for YIF_VALIDATORS~VALIDATE_SWIFT_CODE .
protected section.
private section.
ENDCLASS.



CLASS YCL_MACGYVER IMPLEMENTATION.


  METHOD yif_validators~validate_brazil_cnpj.
    CALL FUNCTION 'CONVERSION_EXIT_CGCBR_INPUT' EXPORTING input = cnpj.

    valid = SWITCH #( sy-subrc WHEN 0 THEN abap_true ELSE abap_false ).
  ENDMETHOD.


  METHOD yif_validators~validate_brazil_cpf.
    CALL FUNCTION 'CONVERSION_EXIT_CPFBR_INPUT' EXPORTING input = cpf.

    valid = SWITCH #( sy-subrc WHEN 0 THEN abap_true ELSE abap_false ).
  ENDMETHOD.


  METHOD yif_validators~validate_chile_rut.

  ENDMETHOD.


  METHOD yif_validators~validate_email.
    DATA(pattern) = NEW cl_abap_regex( pattern = '\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b' ignore_case = abap_true ).
    DATA(matcher) = pattern->create_matcher( text = email ).

    valid = COND #( WHEN matcher->match( ) = abap_true THEN abap_true ELSE abap_false ).
  ENDMETHOD.


  METHOD yif_validators~validate_swift_code.
    CALL FUNCTION 'SWIFT_CODE_CHECK'
      EXPORTING
        bank_country = bank_country
        swift_code   = swift_code.

    valid = COND #( WHEN sy-subrc IS INITIAL THEN abap_true ELSE abap_false ).
  ENDMETHOD.
ENDCLASS.
