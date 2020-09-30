interface ZIF_TTTT_NODE
  public .


  data NODE_KEY type TM_NODEKEY .
  data CHOSEN type ABAP_BOOL .
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
  methods ACTION_LINK_CLICK
    importing
      !NODE_KEY type TM_NODEKEY
      !ITEM_NAME type TV_ITMNAME .
  methods ACTION_NODE_DOUBLE_CLICK
    importing
      !NODE_KEY type TM_NODEKEY .
  methods ACTION_ITEM_DOUBLE_CLICK
    importing
      !NODE_KEY type TM_NODEKEY
      !ITEM_NAME type TV_ITMNAME .
  methods ACTION_ITEM_CXT_MENU_REQUEST
    importing
      !MENU type ref to CL_CTMENU
      !NODE_KEY type TM_NODEKEY
      !ITEM_NAME type TV_ITMNAME .
  methods ACTION_ITEM_CXT_MENU_SELECTED
    importing
      !FCODE type FCODE
      !NODE_KEY type TM_NODEKEY
      !ITEM_NAME type TV_ITMNAME .
  methods ACTION_SELECTION_CHANGED
    importing
      !NODE_KEY type TM_NODEKEY .
  methods SET_MARK
    importing
      !CHOSEN type ABAP_BOOL .
  methods GET_CONTROL
    returning
      value(CONTROL) type ref to CL_GUI_CONTROL .
  methods SET_CONTAINER
    importing
      !CONT type ref to CL_GUI_CONTAINER .
  methods IS_FOLDER
    returning
      value(FOLDER) type ABAP_BOOL .
  methods IS_DISABLED
    returning
      value(DISABLED) type ABAP_BOOL .
endinterface.
