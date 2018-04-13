class YCL_MACGYVER definition
  public
  final
  create public .

public section.

  class-methods VALIDATE_EMAIL
    importing
      !EMAIL type STRING
    returning
      value(VALID) type ABAP_BOOL .
  class-methods VALIDATE_BRAZIL_CPF
    importing
      !CPF type CHAR14
    returning
      value(VALID) type ABAP_BOOL .
  class-methods VALIDATE_BRAZIL_CNPJ
    importing
      !CNPJ type CHAR19
    returning
      value(VALID) type ABAP_BOOL .
protected section.
private section.
ENDCLASS.



CLASS YCL_MACGYVER IMPLEMENTATION.


  METHOD VALIDATE_BRAZIL_CNPJ.
    CALL FUNCTION 'CONVERSION_EXIT_CGCBR_INPUT' EXPORTING input = cnpj.

    valid = SWITCH #( sy-subrc WHEN 0 THEN abap_true ELSE abap_false ).
  ENDMETHOD.


  METHOD validate_brazil_cpf.
    CALL FUNCTION 'CONVERSION_EXIT_CPFBR_INPUT' EXPORTING input = cpf.

    valid = SWITCH #( sy-subrc WHEN 0 THEN abap_true ELSE abap_false ).
  ENDMETHOD.


  METHOD validate_email.
    DATA(pattern) = NEW cl_abap_regex( pattern = '\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b' ignore_case = abap_true ).
    DATA(matcher) = pattern->create_matcher( text = email ).

    valid = COND #( WHEN matcher->match( ) = abap_true THEN abap_true ELSE abap_false ).
  ENDMETHOD.
ENDCLASS.
