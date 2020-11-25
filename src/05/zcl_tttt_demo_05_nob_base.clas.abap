class ZCL_TTTT_DEMO_05_NOB_BASE definition
  public
  create public .

public section.

  interfaces ZIF_TTTT_NODE .

  methods CONSTRUCTOR
    importing
      !TYPE type TROBJTYPE
      !NAME type CLIKE .
protected section.

  data OBJ_TYPE type TROBJTYPE .
  data OBJ_NAME type TROBJ_NAME .
private section.
ENDCLASS.



CLASS ZCL_TTTT_DEMO_05_NOB_BASE IMPLEMENTATION.


  METHOD CONSTRUCTOR.

    zif_tttt_node~description = |{ name }|.
    me->obj_type = type.
    me->obj_name = name.

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


  METHOD zif_tttt_node~get_children.


  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~GET_CONTROL.


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


  METHOD ZIF_TTTT_NODE~GET_NODE_ICON.
    icon = icon_any_document.
  ENDMETHOD.


  METHOD zif_tttt_node~is_disabled.
    disabled = abap_true.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~IS_FOLDER.
    folder = abap_false.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~SET_CONTAINER.

    zif_tttt_node~container = cont.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~SET_MARK.

    zif_tttt_node~chosen = chosen.

  ENDMETHOD.
ENDCLASS.
