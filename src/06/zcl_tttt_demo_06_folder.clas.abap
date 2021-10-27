class ZCL_TTTT_DEMO_06_FOLDER definition
  public
  create public .

public section.

  interfaces ZIF_TTTT_NODE_SINGLE .

  methods CONSTRUCTOR
    importing
      !DESCRIPTION type CLIKE .
  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES:
      BEGIN OF _hero,
        superhero TYPE string,
        alias     TYPE string,
      END OF _hero .
    TYPES:
      _heroes TYPE STANDARD TABLE OF _hero .

    DATA hero_salv TYPE REF TO cl_salv_table .
    DATA heroes TYPE _heroes .
ENDCLASS.



CLASS ZCL_TTTT_DEMO_06_FOLDER IMPLEMENTATION.


  METHOD CONSTRUCTOR.

    zif_tttt_node_single~description = description.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE_SINGLE~ACTION_SELECTION_CHANGED.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE_SINGLE~GET_ITEMS.

    items = VALUE #(

     ( item_name  = zif_tttt_node=>item_name-description
       class      = cl_item_tree_model=>item_class_text
       style      = cl_item_tree_model=>style_default
       font       = cl_item_tree_model=>item_font_prop
       text       = zif_tttt_node_single~description
       length     = 30 )
     ).

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE_SINGLE~GET_NODE_ICON.

    icon = icon_dummy.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE_SINGLE~GET_SCREEN.
    screen_nr = '0000'.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE_SINGLE~IS_DISABLED.
    disabled = abap_true.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE_SINGLE~IS_FOLDER.
    folder = abap_true.
  ENDMETHOD.
ENDCLASS.
