CLASS zcl_tttt_node_single_base DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_tttt_node_single .

    METHODS constructor
      IMPORTING
        !description TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TTTT_NODE_SINGLE_BASE IMPLEMENTATION.


  METHOD constructor.

    zif_tttt_node_single~description = description.

  ENDMETHOD.


  METHOD zif_tttt_node_single~get_items.

    items = VALUE #(

     ( item_name  = zif_tttt_node=>item_name-description
       class      = cl_item_tree_model=>item_class_text
       style      = cl_item_tree_model=>style_default
       font       = cl_item_tree_model=>item_font_prop
       text       = zif_tttt_node_single~description
       length     = 40 )
     ).

  ENDMETHOD.


  METHOD zif_tttt_node_single~get_node_icon.

    icon = icon_led_inactive.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE_SINGLE~GET_SCREEN.

  ENDMETHOD.


  METHOD zif_tttt_node_single~is_disabled.
    disabled = abap_false.
  ENDMETHOD.


  METHOD zif_tttt_node_single~is_folder.
    folder = abap_true.
  ENDMETHOD.
ENDCLASS.
