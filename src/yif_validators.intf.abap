INTERFACE yif_validators
  PUBLIC .


  CLASS-METHODS validate_brazil_cnpj
    IMPORTING
      !cnpj        TYPE char19
    RETURNING
      VALUE(valid) TYPE abap_bool .
  CLASS-METHODS validate_brazil_cpf
    IMPORTING
      !cpf         TYPE char14
    RETURNING
      VALUE(valid) TYPE abap_bool .
  CLASS-METHODS validate_email
    IMPORTING
      !email       TYPE string
    RETURNING
      VALUE(valid) TYPE abap_bool .
  CLASS-METHODS validate_swift_code
    IMPORTING
      !bank_country TYPE bnka-banks
      !swift_code   TYPE bnka-swift
    RETURNING
      VALUE(valid)  TYPE abap_bool .
  CLASS-METHODS validate_chile_rut
    IMPORTING
      !rut         TYPE c
    RETURNING
      VALUE(valid) TYPE abap_bool .
  CLASS-METHODS validate_authorization
    IMPORTING
      !object   TYPE xuobject
      !user     TYPE sy-uname
      !id       TYPE xufield
      !field    TYPE char40
    RETURNING
      VALUE(valid) TYPE abap_bool .
ENDINTERFACE.
