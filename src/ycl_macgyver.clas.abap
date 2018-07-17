class YCL_MACGYVER definition
  public
  final
  create public .

public section.

  interfaces YIF_VALIDATORS .
  interfaces YIF_CONVERTERS .
  interfaces YIF_UTILS .
  interfaces YIF_SIMPLEBAPI .

  aliases CONVERT_OTF_TO_PDF
    for YIF_CONVERTERS~CONVERT_OTF_TO_PDF .
  aliases CONVERT_XML_TO_ABAP
    for YIF_CONVERTERS~CONVERT_XML_TO_ABAP .
  aliases GET_TVARV_OBJECT
    for YIF_UTILS~GET_TVARV_OBJECT .
  aliases VALIDATE_AUTHORIZATION
    for YIF_VALIDATORS~VALIDATE_AUTHORIZATION .
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
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_MACGYVER IMPLEMENTATION.


  METHOD convert_otf_to_pdf.

  ENDMETHOD.


  METHOD convert_xml_to_abap.

  ENDMETHOD.


  METHOD yif_utils~get_tvarv_object.
    SELECT * FROM tvarvc INTO TABLE @DATA(tvarvc) WHERE type = @type AND name = @name.

    IF sy-subrc IS INITIAL.

    ENDIF.
  ENDMETHOD.


  METHOD yif_validators~validate_authorization.
    AUTHORITY-CHECK OBJECT object FOR USER user ID id FIELD field.

    IF sy-subrc IS INITIAL.
      valid = abap_true.
    ELSE.
      valid = abap_false.
    ENDIF.
  ENDMETHOD.


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
