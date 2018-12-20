INTERFACE yif_utils
  PUBLIC .

  TYPES:
    range TYPE STANDARD TABLE OF rsdsselopt WITH DEFAULT KEY .

  CLASS-METHODS get_tvarv_object
    IMPORTING
      !type        TYPE tvarvc-type
      !name        TYPE tvarvc-name
    RETURNING
      VALUE(range) TYPE range .

  CLASS-METHODS get_remain_char_count
    IMPORTING
      !word         TYPE c
    RETURNING
      VALUE(remain) TYPE i .

  CLASS-METHODS get_eom
    IMPORTING !date      TYPE syst_datum
    RETURNING VALUE(eom) TYPE syst_datum.

  CLASS-METHODS get_xml_from_grc
    IMPORTING xml_key    TYPE zxmlst
              rfc        TYPE rfcdest
    RETURNING VALUE(xml) TYPE j_1b_nfe_xml_content.

ENDINTERFACE.
