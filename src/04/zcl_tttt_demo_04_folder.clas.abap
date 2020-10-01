CLASS zcl_tttt_demo_04_folder DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_tttt_node_single .

    METHODS constructor
      IMPORTING
        !description TYPE clike .
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



CLASS ZCL_TTTT_DEMO_04_FOLDER IMPLEMENTATION.


  METHOD constructor.

    zif_tttt_node_single~description = description.

  ENDMETHOD.


  METHOD zif_tttt_node_single~action_selection_changed.
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


  METHOD zif_tttt_node_single~get_node_icon.

    icon = icon_dummy.

  ENDMETHOD.


  METHOD zif_tttt_node_single~get_screen.
    screen_nr = '0000'.
  ENDMETHOD.


  METHOD zif_tttt_node_single~is_disabled.
    disabled = abap_true.
  ENDMETHOD.


  METHOD zif_tttt_node_single~is_folder.
    folder = abap_true.
  ENDMETHOD.
ENDCLASS.
