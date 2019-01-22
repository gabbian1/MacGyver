CLASS ycl_macgyver DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES yif_validators .
    INTERFACES yif_converters .
    INTERFACES yif_utils .
    INTERFACES yif_simplebapi .

    ALIASES convert_amount_to_spell_amount
      FOR yif_converters~convert_amount_to_spell_amount .
    ALIASES convert_otf_to_pdf
      FOR yif_converters~convert_otf_to_pdf .
    ALIASES convert_xml_to_abap
      FOR yif_converters~convert_xml_to_abap .
    ALIASES get_eom
      FOR yif_utils~get_eom .
    ALIASES get_explained_exception
      FOR yif_utils~get_explained_exception .
    ALIASES get_remain_char_count
      FOR yif_utils~get_remain_char_count .
    ALIASES get_tvarv_object
      FOR yif_utils~get_tvarv_object .
    ALIASES get_xml_from_grc
      FOR yif_utils~get_xml_from_grc .
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
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ycl_macgyver IMPLEMENTATION.


  METHOD convert_amount_to_spell_amount.
    DATA in_words TYPE spell.

    CALL FUNCTION 'SPELL_AMOUNT'
      EXPORTING
        amount    = amount
        currency  = currency
        filler    = space
        language  = language
      IMPORTING
        in_words  = in_words
      EXCEPTIONS
        not_found = 1
        too_large = 2
        OTHERS    = 3.

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ELSE.
      spelled_amount = COND #( LET spelled_value   = SWITCH string( currency
                                                                    WHEN 'BRL' THEN COND #( WHEN in_words-number = 1 THEN |REAL| ELSE |REAIS| )
                                                                    WHEN 'USD' THEN SWITCH #( language
                                                                                              WHEN 'E' THEN COND #( WHEN in_words-number = 1 THEN |DOLLAR| ELSE |DOLLARS| )
                                                                                              WHEN 'P' THEN COND #( WHEN in_words-number = 1 THEN |DÓLAR|  ELSE |DÓLARES| ) ) )
                                   spelled_decimal =  SWITCH string( currency
                                                                     WHEN 'BRL' THEN COND #( WHEN in_words-decimal(2) = 01 THEN |CENTAVO| ELSE |CENTAVOS| )
                                                                     WHEN 'USD' THEN |CENTS| ) IN
                               WHEN in_words-decimal IS INITIAL THEN |{ in_words-word } { spelled_value }|
                               ELSE SWITCH #( currency
                                              WHEN 'BRL' THEN |{ in_words-word } { spelled_value } E { in_words-decword } { spelled_decimal }|
                                              WHEN 'USD' THEN |{ in_words-word } { SWITCH #( language
                                                                                             WHEN 'E' THEN |DOLLARS AND { in_words-decword } { spelled_decimal }|
                                                                                             WHEN 'P' THEN |DÓLARES E { in_words-decword } { spelled_decimal }| ) }| ) ).

    ENDIF.

    CLEAR: in_words.
  ENDMETHOD.


  METHOD convert_otf_to_pdf.

  ENDMETHOD.


  METHOD convert_xml_to_abap.

  ENDMETHOD.


  METHOD get_eom.
    CALL FUNCTION 'SLS_MISC_GET_LAST_DAY_OF_MONTH'
      EXPORTING
        day_in            = date
      IMPORTING
        last_day_of_month = eom
      EXCEPTIONS
        day_in_not_valid  = 1
        OTHERS            = 2.

    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER
      sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.


  METHOD get_explained_exception.
    obj->get_source_position( IMPORTING program_name = DATA(program_name)
                                        include_name = DATA(include_name)
                                        source_line  = DATA(source_line) ).

    errmsg = |Err: { obj->get_text( ) } in program: { program_name }{ COND #( WHEN include_name <> program_name THEN |, include: { include_name }| ) }, line: { source_line }|.
  ENDMETHOD.


  METHOD get_remain_char_count.
    DESCRIBE FIELD word OUTPUT-LENGTH DATA(described_field).

    remain = described_field - strlen( word ).
  ENDMETHOD.


  METHOD get_tvarv_object.
    SELECT sign, opti AS option, low, high FROM tvarvc INTO TABLE @range WHERE type = @type AND name = @name.
  ENDMETHOD.


  METHOD get_xml_from_grc.
    DATA(xml_download) = NEW cl_j_1bnfe_xml_download( iv_xml_key = CONV #( CORRESPONDING j_1b_nfe_access_key( xml_key ) )
                                                      iv_rfc     = rfc ).

    xml_download->load_xml_content( iv_direction = CONV #( SWITCH #( xml_key-direct
                                                                     WHEN '1' THEN COND #( WHEN xml_key-entrad = abap_true THEN 'OUTB'
                                                                                           ELSE 'INBD' )
                                                                     WHEN '2' THEN 'OUTB' ) )
                                    iv_doctype   = CONV #( SWITCH #( xml_key-model
                                                                     WHEN '55' THEN 'NFE'
                                                                     WHEN '57' THEN 'CTE' ) ) ).

    xml = xml_download->get_xml_content( ).
  ENDMETHOD.


  METHOD validate_authorization.
    AUTHORITY-CHECK OBJECT object FOR USER user ID id FIELD field.

    valid = SWITCH #( sy-subrc WHEN 0 THEN abap_true ELSE abap_false ).
  ENDMETHOD.


  METHOD validate_brazil_cnpj.
    CALL FUNCTION 'CONVERSION_EXIT_CGCBR_INPUT' EXPORTING input = cnpj.

    valid = SWITCH #( sy-subrc WHEN 0 THEN abap_true ELSE abap_false ).
  ENDMETHOD.


  METHOD validate_brazil_cpf.
    CALL FUNCTION 'CONVERSION_EXIT_CPFBR_INPUT' EXPORTING input = cpf.

    valid = SWITCH #( sy-subrc WHEN 0 THEN abap_true ELSE abap_false ).
  ENDMETHOD.


  METHOD validate_chile_rut.

  ENDMETHOD.


  METHOD validate_email.
    valid = COND #( WHEN NEW cl_abap_regex( pattern = '\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b' ignore_case = abap_true
                             )->create_matcher( text = email
                             )->match( ) THEN abap_true ELSE abap_false ).
  ENDMETHOD.


  METHOD validate_swift_code.
    CALL FUNCTION 'SWIFT_CODE_CHECK'
      EXPORTING
        bank_country = bank_country
        swift_code   = swift_code.

    valid = COND #( WHEN sy-subrc IS INITIAL THEN abap_true ELSE abap_false ).
  ENDMETHOD.
ENDCLASS.
