CLASS zcl_tttt_demo_05_nob_type DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_tttt_node .

    METHODS constructor
      IMPORTING
        !obj_type TYPE trobjtype .
  PROTECTED SECTION.

    DATA objtype TYPE trobjtype .

    METHODS get_objects_for_obj_type
      RETURNING
        VALUE(children) TYPE zif_tttt_node=>_node_objects .
  PRIVATE SECTION.

    METHODS get_instance_for
      IMPORTING
        !type              TYPE trobjtype
        !name              TYPE clike
      RETURNING
        VALUE(node_object) TYPE REF TO zif_tttt_node .
ENDCLASS.



CLASS ZCL_TTTT_DEMO_05_NOB_TYPE IMPLEMENTATION.


  METHOD constructor.

    me->objtype = obj_type.
    zif_tttt_node~description = SWITCH #( obj_type
      WHEN 'CLAS' THEN 'Classes'
      WHEN 'INTF' THEN 'Interfaces'
      WHEN 'PROG' THEN 'Reports'
      WHEN 'DTEL' THEN 'Data elements'
      WHEN 'STRU' THEN 'Structures'
      WHEN 'TABL' THEN 'Tables'
      WHEN 'TTYP' THEN 'Table types'
      WHEN 'DOMA' THEN 'Domains'
      ELSE 'not yet implemented' ) .

  ENDMETHOD.


  METHOD get_instance_for.

    DATA(classname) = |ZCL_TTTT_DEMO_05_NOB_{ type }|.

    TRY.
        CREATE OBJECT node_object
          TYPE (classname)
          EXPORTING
            name = name.
      CATCH cx_sy_create_object_error  ##no_handler.
        node_object = NEW zcl_tttt_demo_05_nob_base( type = type name = name ).
    ENDTRY.

  ENDMETHOD.


  METHOD get_objects_for_obj_type.

    SELECT
      object   AS type,
      obj_name AS name
      FROM tadir
      INTO TABLE @DATA(objects)
     WHERE devclass = 'SLIS'
       AND object   = @me->objtype
       ORDER BY obj_name.

    LOOP AT objects INTO DATA(obj).
      APPEND get_instance_for( type = obj-type name = obj-name ) TO children.
    ENDLOOP.

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


  METHOD zif_tttt_node~action_selection_changed.

  ENDMETHOD.


  METHOD zif_tttt_node~get_children.

    children = get_objects_for_obj_type( ).

  ENDMETHOD.


  METHOD zif_tttt_node~get_control.


  ENDMETHOD.


  METHOD zif_tttt_node~get_items.


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
    icon = icon_folder.
  ENDMETHOD.


  METHOD zif_tttt_node~is_disabled.
    disabled = abap_false.
  ENDMETHOD.


  METHOD zif_tttt_node~is_folder.
    folder = abap_true.
  ENDMETHOD.


  METHOD zif_tttt_node~set_container.

    zif_tttt_node~container = cont.

  ENDMETHOD.


  METHOD zif_tttt_node~set_mark.

    zif_tttt_node~chosen = chosen.

  ENDMETHOD.
ENDCLASS.
