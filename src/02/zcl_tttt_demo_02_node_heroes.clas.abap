class ZCL_TTTT_DEMO_02_NODE_HEROES definition
  public
  create public .

public section.

  interfaces ZIF_TTTT_NODE .

  methods CONSTRUCTOR
    importing
      !DESCRIPTION type STRING .
  PROTECTED SECTION.
private section.

  types:
    BEGIN OF _hero,
      name  TYPE string,
      alias TYPE string,
    END OF _hero .
  types:
    _heroes TYPE STANDARD TABLE OF _hero .

  data HERO_GRID type ref to CL_GUI_ALV_GRID .
  data HEROES type _HEROES .

  methods GET_FCAT
    returning
      value(FIELDCATALOG) type LVC_T_FCAT .
  methods CREATE_GRID .
  methods READ_HEROES .
ENDCLASS.



CLASS ZCL_TTTT_DEMO_02_NODE_HEROES IMPLEMENTATION.


  METHOD constructor.

    zif_tttt_node~description = description.

    read_heroes( ).

  ENDMETHOD.


  METHOD create_grid.

    CHECK hero_grid IS INITIAL.

    hero_grid = NEW #(
      i_parent         = zif_tttt_node~container  ).

    DATA(fcat) = get_fcat( ).

    hero_grid->set_table_for_first_display(
      CHANGING
        it_outtab                     = heroes
        it_fieldcatalog               = fcat
      EXCEPTIONS
        invalid_parameter_combination = 1                    " Wrong Parameter
        program_error                 = 2                    " Program Errors
        too_many_lines                = 3                    " Too many Rows in Ready for Input Grid
        OTHERS                        = 4 ).
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

  ENDMETHOD.


  METHOD get_fcat.

    fieldcatalog = VALUE #(
      ( fieldname = 'NAME'
        reptext   = 'Hero name'
        outputlen = 40
        datatype  = 'C' )
      ( fieldname = 'ALIAS'
        reptext   = 'Hero Alias'
        outputlen = 40
        datatype  = 'C' ) ).

  ENDMETHOD.


  METHOD read_heroes.

    heroes = VALUE #(
      ( name = 'Captain Marvel' alias = 'Carol Danvers' )
      ( name = 'Thanos' )
      ( name = 'Black Panther' alias = 'T''Challa' )
      ( name = 'Spider-Man' alias = 'Peter Parker' )
      ( name = 'Iron Man' alias = 'Tony Stark' ) ).

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~ACTIONZIF_TTTT_NODE_DOUBLE_CLICK.


  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~ACTION_ITEM_CXT_MENU_REQUEST.

    menu->add_function(
      EXPORTING
        fcode             = 'Demo'
        text              = 'Demo function'  ).

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~ACTION_ITEM_CXT_MENU_SELECTED.

    CASE fcode.
      WHEN 'Demo'.
        MESSAGE |demo function| TYPE 'I'.
    ENDCASE.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~ACTION_ITEM_DOUBLE_CLICK.

    CASE item_name.
      WHEN 'xxx'.
      WHEN OTHERS.
        MESSAGE |item { item_name }| TYPE 'S'.
    ENDCASE.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~ACTION_LINK_CLICK.

    MESSAGE |Link click on node { node_key } item { item_name }| TYPE 'S'.

  ENDMETHOD.


  METHOD zif_tttt_node~action_node_double_click.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~GETZIF_TTTT_NODE_ICON.

    icon = icon_dummy.

  ENDMETHOD.


  METHOD zif_tttt_node~get_control.

    create_grid( ).

    control = hero_grid.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~GET_ITEMS.


    items = VALUE #(

     ( item_name  = zif_tttt_node=>item_name-description
       class      = cl_item_tree_model=>item_class_text
       style      = cl_item_tree_model=>style_default
       font       = cl_item_tree_model=>item_font_prop
       text       = zif_tttt_node~description
       length     = 40 )
     ).

  ENDMETHOD.


  METHOD zif_tttt_node~get_node_icon.
    icon = icon_customer.
  ENDMETHOD.


  METHOD zif_tttt_node~is_disabled.
    disabled = abap_false.
  ENDMETHOD.


  METHOD zif_tttt_node~is_folder.
    folder = abap_false.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~SET_CONTAINER.

    zif_tttt_node~container = cont.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~SET_MARK.

    zif_tttt_node~chosen = chosen.

  ENDMETHOD.
ENDCLASS.
