interface YIF_UTILS
  public .


  types:
    range TYPE STANDARD TABLE OF rsdsselopt WITH DEFAULT KEY .

  class-methods GET_TVARV_OBJECT
    importing
      !TYPE type TVARVC-TYPE
      !NAME type TVARVC-NAME
    returning
      value(RANGE) type RANGE .
  class-methods GET_REMAIN_CHAR_COUNT
    importing
      !WORD type C
    returning
      value(REMAIN) type I .
endinterface.
