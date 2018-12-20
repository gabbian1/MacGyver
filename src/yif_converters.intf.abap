INTERFACE yif_converters
  PUBLIC .

  CLASS-METHODS convert_otf_to_pdf .
  CLASS-METHODS convert_xml_to_abap .
  CLASS-METHODS convert_amount_to_spell_amount
    IMPORTING amount                TYPE any DEFAULT 0
              currency              TYPE sy-waers
              language              TYPE sy-langu DEFAULT sy-langu
    RETURNING VALUE(spelled_amount) TYPE string.
ENDINTERFACE.
