interface ZIF_TTTT_NODE
  public .


  data NODE_KEY type TM_NODEKEY .
  data CHOSEN type ABAP_BOOL .
  data DESCRIPTION type STRING .
  constants:
    BEGIN OF item_name,
      checkbox    TYPE tv_itmname VALUE '1',
      description TYPE tv_itmname VALUE '2',
    END OF item_name .
  constants:
    BEGIN OF function,
      collapse TYPE fcode VALUE 'Collapse',
      expand   TYPE fcode VALUE 'Expand',
    END OF function .

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
  methods SET_MARK
    importing
      !CHOSEN type ABAP_BOOL .
endinterface.
