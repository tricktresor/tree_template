CLASS zcl_tttt_node_base DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_tttt_node .

    METHODS constructor
      IMPORTING
        !description TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TTTT_NODE_BASE IMPLEMENTATION.


  METHOD constructor.

    zif_tttt_node~description = description.

  ENDMETHOD.


  METHOD zif_tttt_node~actionzif_tttt_node_double_click.


  ENDMETHOD.


  METHOD zif_tttt_node~action_item_cxt_menu_request.

    menu->add_function(
      EXPORTING
        fcode             = 'Demo'
        text              = 'Demo function'  ).

  ENDMETHOD.


  METHOD zif_tttt_node~action_item_cxt_menu_selected.

    CASE fcode.
      WHEN 'Demo'.
        MESSAGE |demo function| TYPE 'I'.
    ENDCASE.

  ENDMETHOD.


  METHOD zif_tttt_node~action_item_double_click.

    CASE item_name.
      WHEN 'xxx'.
      WHEN OTHERS.
        MESSAGE |item { item_name }| TYPE 'S'.
    ENDCASE.

  ENDMETHOD.


  METHOD zif_tttt_node~action_link_click.

    MESSAGE |Link click on node { node_key } item { item_name }| TYPE 'S'.

  ENDMETHOD.


  METHOD zif_tttt_node~action_node_double_click.
  ENDMETHOD.


  METHOD zif_tttt_node~getzif_tttt_node_icon.

    icon = icon_dummy.

  ENDMETHOD.


  METHOD zif_tttt_node~get_items.


    items = VALUE #(
     ( item_name  = zif_tttt_node=>item_name-checkbox
       class      = cl_item_tree_model=>item_class_checkbox
       style      = cl_item_tree_model=>style_default
       font       = cl_item_tree_model=>item_font_prop
       editable   = abap_true
       text       = 'check me!'
       txtisqinfo = abap_true
       length     = 2 )

     ( item_name  = zif_tttt_node=>item_name-description
       class      = cl_item_tree_model=>item_class_text
       style      = cl_item_tree_model=>style_default
       font       = cl_item_tree_model=>item_font_prop
       text       = zif_tttt_node~description
       length     = 40 )
     ).

  ENDMETHOD.


  METHOD zif_tttt_node~get_node_icon.
    icon = icon_dummy.
  ENDMETHOD.


  METHOD zif_tttt_node~set_mark.

    zif_tttt_node~chosen = chosen.

  ENDMETHOD.
ENDCLASS.
