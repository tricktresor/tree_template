class ZCL_TTTT_DEMO_04_SCREEN definition
  public
  create public .

public section.

  interfaces ZIF_TTTT_NODE_SINGLE .

  methods CONSTRUCTOR
    importing
      !DESCRIPTION type CLIKE
      !SCREEN_NR type DYNNR .
  PROTECTED SECTION.
private section.

  types:
    BEGIN OF _hero,
        superhero TYPE string,
        alias     TYPE string,
      END OF _hero .
  types:
    _heroes TYPE STANDARD TABLE OF _hero .

  data SCREEN_NUMBER type DYNNR .
ENDCLASS.



CLASS ZCL_TTTT_DEMO_04_SCREEN IMPLEMENTATION.


  METHOD CONSTRUCTOR.

    zif_tttt_node_single~description = description.
    screen_number = screen_nr.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE_SINGLE~ACTION_SELECTION_CHANGED.
  ENDMETHOD.


  METHOD zif_tttt_node_single~get_items.

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

    icon = icon_led_green.

  ENDMETHOD.


  METHOD zif_tttt_node_single~get_screen.
    screen_nr = screen_number.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE_SINGLE~IS_DISABLED.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE_SINGLE~IS_FOLDER.
    folder = abap_true.
  ENDMETHOD.
ENDCLASS.
