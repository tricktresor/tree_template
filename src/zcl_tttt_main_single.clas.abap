class ZCL_TTTT_MAIN_SINGLE definition
  public
  create public .

public section.

  data TREE type ref to CL_LIST_TREE_MODEL .
  data SCREEN_NUMBER type DYNNR value '0101' ##NO_TEXT.

  methods SET_TREE
    importing
      !TREE_CONTAINER type ref to CL_GUI_CONTAINER .
  methods ADD_NODE
    importing
      !PARENT type TM_NODEKEY
      !OBJECT type ref to ZIF_TTTT_NODE_SINGLE
    returning
      value(NEW_NODE_KEY) type TM_NODEKEY .
  methods NODE_GET_USR_OBJ
    importing
      !NODE_KEY type TM_NODEKEY
    returning
      value(OBJ) type ref to ZIF_TTTT_NODE_SINGLE .
  methods GET_SCREEN
    returning
      value(SCREEN_NR) type DYNNR .
protected section.

  types:
    BEGIN OF ty_node,
      key TYPE tm_nodekey,
      pnt TYPE tm_nodekey,
      obj TYPE REF TO zif_tttt_node_single,
      sel TYPE boolean_flg,
    END OF ty_node .
  types:
    ty_nodes TYPE SORTED TABLE OF ty_node WITH UNIQUE KEY key .

  data CTRL type ref to CL_GUI_CONTROL .
  data ALL_NODES type TY_NODES .
  data ROOT_NODE type TM_NODEKEY .
  data TREE_CONTAINER type ref to CL_GUI_CONTAINER .

  methods ON_EXPAND_NODE
    for event EXPAND_NO_CHILDREN of CL_LIST_TREE_MODEL
    importing
      !NODE_KEY .
  methods ON_EXPAND_NO_CHILDREN
    for event EXPAND_NO_CHILDREN of CL_LIST_TREE_MODEL
    importing
      !NODE_KEY
      !SENDER .
  methods ON_SELECTION_CHANGED
    for event SELECTION_CHANGED of CL_LIST_TREE_MODEL
    importing
      !NODE_KEY .
private section.
ENDCLASS.



CLASS ZCL_TTTT_MAIN_SINGLE IMPLEMENTATION.


  METHOD ADD_NODE.

    DATA guid TYPE guid_32.

    CALL FUNCTION 'GUID_CREATE'
      IMPORTING
        ev_guid_32 = guid.
    new_node_key = guid.

    tree->add_node(
      EXPORTING
        node_key                = new_node_key
        relative_node_key       = parent
        relationship            = cl_tree_model=>relat_last_child
        isfolder                = object->is_folder( )
        hidden                  = space
        disabled                = object->is_disabled( )
        style                   = cl_column_tree_model=>style_default
        no_branch               = space
        expander                = abap_true
        image                   = CONV #( object->get_node_icon( ) )
        expanded_image          = CONV #( object->get_node_icon( ) )
        user_object             = object
        item_table              = object->get_items( )
      EXCEPTIONS
        node_key_exists         = 1
        node_key_empty          = 2
        illegal_relationship    = 3
        relative_node_not_found = 4
        error_in_item_table     = 5
        OTHERS                  = 6 ).
    IF sy-subrc > 0.
      MESSAGE a000(oo) WITH 'Error ADD_NODE'.
    ENDIF.

    INSERT VALUE #(
      key = new_node_key
      pnt = parent
      obj = object ) INTO TABLE all_nodes.


  ENDMETHOD.


  METHOD get_screen.
    screen_nr = screen_number.
  ENDMETHOD.


  METHOD node_get_usr_obj.


    tree->node_get_user_object(
      EXPORTING
        node_key       = node_key
      IMPORTING
        user_object    = DATA(user_object)
      EXCEPTIONS
        node_not_found = 1
        OTHERS         = 2  ).
    IF sy-subrc <> 0.
      RETURN.
    ELSE.

      TRY.
          obj ?= user_object.
        CATCH cx_sy_move_cast_error.
          RETURN.
      ENDTRY.
    ENDIF.


  ENDMETHOD.


  METHOD ON_EXPAND_NODE.




  ENDMETHOD.


  METHOD ON_EXPAND_NO_CHILDREN.



  ENDMETHOD.


  METHOD on_selection_changed.

    DATA(node_object) = node_get_usr_obj( node_key ).

    CHECK node_object IS BOUND.

    node_object->action_selection_changed( ).
    screen_number = node_object->get_screen( ).

    cl_gui_cfw=>set_new_ok_code( 'selection changed' ).

  ENDMETHOD.


  METHOD set_tree.


    me->tree_container = tree_container.

    CREATE OBJECT tree
      EXPORTING
*       node_selection_mode         = cl_list_tree_model=>node_sel_mode_multiple
        node_selection_mode         = cl_list_tree_model=>node_sel_mode_single
        item_selection              = abap_false
        with_headers                = abap_false
      EXCEPTIONS
        illegal_node_selection_mode = 1
        OTHERS                      = 2.
    IF sy-subrc > 0.
      MESSAGE |create tree rc: { sy-subrc }| TYPE 'I'.
    ENDIF.


    tree->create_tree_control(
      EXPORTING
        parent  = me->tree_container
      IMPORTING
        control = ctrl
      EXCEPTIONS
        OTHERS  = 6   ).


* register item_cxt_menu_request.
    tree->set_registered_events( VALUE #(
         ( eventid = cl_list_tree_model=>eventid_selection_changed  )
         ) ).

    SET HANDLER on_expand_no_children     FOR tree.
    SET HANDLER on_expand_node            FOR tree.
    SET HANDLER on_selection_changed      FOR tree.

  ENDMETHOD.
ENDCLASS.
