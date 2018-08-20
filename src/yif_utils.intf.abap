INTERFACE yif_utils
  PUBLIC .

  TYPES: range TYPE STANDARD TABLE OF rsdsselopt WITH DEFAULT KEY.

  CLASS-METHODS get_tvarv_object
    IMPORTING
      !type        TYPE tvarvc-type
      !name        TYPE tvarvc-name
    RETURNING
      VALUE(range) TYPE range .
ENDINTERFACE.
