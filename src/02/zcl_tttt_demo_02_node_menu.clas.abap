class ZCL_TTTT_DEMO_02_NODE_MENU definition
  public
  create public .

public section.

  interfaces ZIF_TTTT_NODE .

  methods CONSTRUCTOR
    importing
      !DESCRIPTION type CLIKE .
  PROTECTED SECTION.
private section.

  types:
    BEGIN OF _hero,
      superhero TYPE string,
      alias     TYPE string,
    END OF _hero .
  types:
    _heroes TYPE STANDARD TABLE OF _hero .

  data HERO_SALV type ref to CL_SALV_TABLE .
  data HEROES type _HEROES .
ENDCLASS.



CLASS ZCL_TTTT_DEMO_02_NODE_MENU IMPLEMENTATION.


  METHOD CONSTRUCTOR.

    zif_tttt_node~description = description.

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


  METHOD ZIF_TTTT_NODE~ACTION_NODE_DOUBLE_CLICK.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~GETZIF_TTTT_NODE_ICON.

    icon = icon_dummy.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~GET_CONTROL.


  ENDMETHOD.


  METHOD zif_tttt_node~get_items.


    items = VALUE #(

     ( item_name  = zif_tttt_node=>item_name-description
       class      = cl_item_tree_model=>item_class_text
       style      = cl_item_tree_model=>style_default
       font       = cl_item_tree_model=>item_font_prop
       text       = zif_tttt_node~description
       length     = 80 )
     ).

  ENDMETHOD.


  METHOD zif_tttt_node~get_node_icon.
    icon = icon_space.
  ENDMETHOD.


  METHOD zif_tttt_node~is_disabled.
    disabled = abap_true.
  ENDMETHOD.


  METHOD zif_tttt_node~is_folder.
    folder = abap_true.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~SET_CONTAINER.

    zif_tttt_node~container = cont.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~SET_MARK.

    zif_tttt_node~chosen = chosen.

  ENDMETHOD.
ENDCLASS.
