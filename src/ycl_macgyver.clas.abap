CLASS ycl_macgyver DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES yif_validators .
    INTERFACES yif_converters .
    INTERFACES yif_utils .
    INTERFACES yif_simplebapi .

    ALIASES convert_otf_to_pdf
      FOR yif_converters~convert_otf_to_pdf .
    ALIASES convert_xml_to_abap
      FOR yif_converters~convert_xml_to_abap .
    ALIASES get_tvarv_object
      FOR yif_utils~get_tvarv_object .
    ALIASES validate_authorization
      FOR yif_validators~validate_authorization .
    ALIASES validate_brazil_cnpj
      FOR yif_validators~validate_brazil_cnpj .
    ALIASES validate_brazil_cpf
      FOR yif_validators~validate_brazil_cpf .
    ALIASES validate_chile_rut
      FOR yif_validators~validate_chile_rut .
    ALIASES validate_email
      FOR yif_validators~validate_email .
    ALIASES validate_swift_code
      FOR yif_validators~validate_swift_code .
    ALIASES get_remain_char_count
    FOR yif_utils~get_remain_char_count.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YCL_MACGYVER IMPLEMENTATION.


  METHOD convert_otf_to_pdf.

  ENDMETHOD.


  METHOD convert_xml_to_abap.

  ENDMETHOD.


  METHOD yif_utils~get_remain_char_count.
    DESCRIBE FIELD word OUTPUT-LENGTH DATA(described_field).

    DATA(filled_quantity) = strlen( word ).

    remain = described_field - filled_quantity.
  ENDMETHOD.


  METHOD yif_utils~get_tvarv_object.
    SELECT sign, opti as option, low, high FROM tvarvc INTO TABLE @range WHERE type = @type AND name = @name.
  ENDMETHOD.


  METHOD yif_validators~validate_authorization.
    AUTHORITY-CHECK OBJECT object FOR USER user ID id FIELD field.

    valid = SWITCH #( sy-subrc WHEN 0 THEN abap_true ELSE abap_false ).
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
