interface ZIF_TTTT_NODE_SINGLE
  public .


  data NODE_KEY type TM_NODEKEY .
  data DESCRIPTION type STRING .
  constants:
    BEGIN OF item_name,
      checkbox    TYPE tv_itmname VALUE '10',
      description TYPE tv_itmname VALUE '20',
    END OF item_name .
  constants:
    BEGIN OF function,
      collapse TYPE fcode VALUE 'Collapse',
      expand   TYPE fcode VALUE 'Expand',
    END OF function .
  data CONTAINER type ref to CL_GUI_CONTAINER .

  methods GET_ITEMS
    returning
      value(ITEMS) type TREEMLITAB .
  methods GET_NODE_ICON
    returning
      value(ICON) type STRING .
  methods ACTION_SELECTION_CHANGED .
  methods GET_SCREEN
    returning
      value(SCREEN_NR) type DYNNR .
  methods IS_FOLDER
    returning
      value(FOLDER) type ABAP_BOOL .
  methods IS_DISABLED
    returning
      value(DISABLED) type ABAP_BOOL .
endinterface.
