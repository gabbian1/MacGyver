interface YIF_UTILS
  public .


  class-methods GET_TVARV_OBJECT
    importing
      !TYPE type TVARVC-TYPE
      !NAME type TVARVC-NAME
    returning
      value(RANGE) type OIJ_EL_RANGE_T .
endinterface.
