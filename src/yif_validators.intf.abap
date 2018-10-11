interface YIF_VALIDATORS
  public .


  class-methods VALIDATE_BRAZIL_CNPJ
    importing
      !CNPJ type CHAR19
    returning
      value(VALID) type ABAP_BOOL .
  class-methods VALIDATE_BRAZIL_CPF
    importing
      !CPF type CHAR14
    returning
      value(VALID) type ABAP_BOOL .
  class-methods VALIDATE_EMAIL
    importing
      !EMAIL type STRING
    returning
      value(VALID) type ABAP_BOOL .
  class-methods VALIDATE_SWIFT_CODE
    importing
      !BANK_COUNTRY type BNKA-BANKS
      !SWIFT_CODE type BNKA-SWIFT
    returning
      value(VALID) type ABAP_BOOL .
  class-methods VALIDATE_CHILE_RUT
    importing
      !RUT type C
    returning
      value(VALID) type ABAP_BOOL .
  class-methods VALIDATE_AUTHORIZATION
    importing
      !OBJECT type XUOBJECT
      !USER type SY-UNAME
      !ID type XUFIELD
      !FIELD type CHAR40
    returning
      value(VALID) type ABAP_BOOL .
endinterface.
