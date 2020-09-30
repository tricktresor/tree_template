class ZCL_TTTT_MAIN definition
  public
  create public .

public section.

  data TREE type ref to CL_LIST_TREE_MODEL .

  methods SET_TREE
    importing
      !TREE_CONTAINER type ref to CL_GUI_CONTAINER
      !DATA_CONTAINER type ref to CL_GUI_CONTAINER optional .
  methods ADD_NODE
    importing
      !PARENT type TM_NODEKEY
      !OBJECT type ref to ZIF_TTTT_NODE
    returning
      value(NEW_NODE_KEY) type TM_NODEKEY .
  methods NODE_GET_USR_OBJ
    importing
      !NODE_KEY type TM_NODEKEY
    returning
      value(OBJ) type ref to ZIF_TTTT_NODE .
protected section.

  types:
    BEGIN OF ty_node,
        key TYPE tm_nodekey,
        pnt TYPE tm_nodekey,
        obj TYPE REF TO zif_tttt_node,
        sel TYPE boolean_flg,
      END OF ty_node .
  types:
    ty_nodes TYPE SORTED TABLE OF ty_node WITH UNIQUE KEY key .

  data CTRL type ref to CL_GUI_CONTROL .
  data ALL_NODES type TY_NODES .
  data ROOT_NODE type TM_NODEKEY .
  data TREE_CONTAINER type ref to CL_GUI_CONTAINER .
  data DATA_CONTAINER type ref to CL_GUI_CONTAINER .

  methods ON_CHECKBOX_CHANGE
    for event CHECKBOX_CHANGE of CL_LIST_TREE_MODEL
    importing
      !CHECKED
      !ITEM_NAME
      !NODE_KEY .
  methods ON_EXPAND_NODE
    for event EXPAND_NO_CHILDREN of CL_LIST_TREE_MODEL
    importing
      !NODE_KEY .
  methods ON_EXPAND_NO_CHILDREN
    for event EXPAND_NO_CHILDREN of CL_LIST_TREE_MODEL
    importing
      !NODE_KEY
      !SENDER .
  methods ON_ITEM_CXT_MENU_REQUEST
    for event ITEM_CONTEXT_MENU_REQUEST of CL_LIST_TREE_MODEL
    importing
      !ITEM_NAME
      !MENU
      !NODE_KEY .
  methods ON_ITEM_CXT_MENU_SELECTED
    for event ITEM_CONTEXT_MENU_SELECT of CL_LIST_TREE_MODEL
    importing
      !FCODE
      !ITEM_NAME
      !NODE_KEY .
  methods ON_ITEM_DOUBLE_CLICK
    for event ITEM_DOUBLE_CLICK of CL_LIST_TREE_MODEL
    importing
      !ITEM_NAME
      !NODE_KEY .
  methods ON_LINK_CLICK
    for event LINK_CLICK of CL_LIST_TREE_MODEL
    importing
      !ITEM_NAME
      !NODE_KEY .
  methods ON_NODE_CXT_MENU_REQUEST
    for event NODE_CONTEXT_MENU_REQUEST of CL_LIST_TREE_MODEL
    importing
      !MENU
      !NODE_KEY .
  methods ON_NODE_CXT_MENU_SELECTED
    for event NODE_CONTEXT_MENU_SELECT of CL_LIST_TREE_MODEL
    importing
      !FCODE
      !NODE_KEY .
  methods ON_NODE_DOUBLE_CLICK
    for event NODE_DOUBLE_CLICK of CL_LIST_TREE_MODEL
    importing
      !NODE_KEY .
  methods ON_SELECTION_CHANGED
    for event SELECTION_CHANGED of CL_LIST_TREE_MODEL
    importing
      !NODE_KEY .
private section.

  methods DISPLAY
    importing
      !OBJ type ref to ZIF_TTTT_NODE .
ENDCLASS.



CLASS ZCL_TTTT_MAIN IMPLEMENTATION.


  METHOD add_node.

    DATA guid TYPE guid_32.

    CALL FUNCTION 'GUID_CREATE'
      IMPORTING
        ev_guid_32 = guid.
    new_node_key = guid.

    object->set_container( data_container ).

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


  METHOD display.

    DATA(ctrl) = obj->get_control( ).

    IF ctrl IS NOT INITIAL.
      LOOP AT data_container->children INTO DATA(child).
        child->set_visible( space ).
      ENDLOOP.

      ctrl->set_visible( abap_true ).

    ENDIF.

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


  METHOD on_checkbox_change.


    ASSIGN all_nodes[ key = node_key ] TO FIELD-SYMBOL(<node>).
    <node>-sel = checked.
    <node>-obj->set_mark( checked ).


  ENDMETHOD.


  METHOD on_expand_node.




  ENDMETHOD.


  METHOD on_expand_no_children.



  ENDMETHOD.


  METHOD on_item_cxt_menu_request.


    DATA(lo_obj) = node_get_usr_obj( node_key ).



    CHECK lo_obj IS BOUND.

    lo_obj->action_item_cxt_menu_request(
        menu      = menu
        node_key  = node_key
        item_name = item_name  ).

    menu->get_functions(
      IMPORTING
        fcodes = DATA(lt_object_functions)  ).

    IF lt_object_functions IS NOT INITIAL.
      menu->add_separator( ).
    ENDIF.

    tree->get_expanded_nodes(
      IMPORTING
        node_key_table       = DATA(lt_expanded_nodes) ).

    IF line_exists( lt_expanded_nodes[ table_line = node_key ] ).
      menu->add_function(
          fcode  = CONV #( zif_tttt_node=>function-collapse )
          text   = 'Collapse node' ).
    ELSE.
      menu->add_function(
          fcode  = CONV #( zif_tttt_node=>function-expand )
          text   = 'Expand node' ).
    ENDIF.


  ENDMETHOD.


  METHOD on_item_cxt_menu_selected.


    DATA(lo_obj) = node_get_usr_obj( node_key ).

    CASE fcode.
      WHEN 'Demo'.
        MESSAGE 'demo function clicked' TYPE 'I'.


      WHEN zif_tttt_node=>function-collapse.
        "collapse node
        tree->collapse_node( node_key ).

      WHEN zif_tttt_node=>function-expand.
        "expand node
        tree->get_top_node(
          IMPORTING
            node_key = DATA(top_node) ).
        tree->set_top_node( top_node ).
        tree->ensure_visible( top_node ).

      WHEN OTHERS.
        "execute action for specific node
        CHECK lo_obj IS BOUND.
        lo_obj->action_item_cxt_menu_selected(
            fcode     = CONV #( fcode )
            node_key  = node_key
            item_name = item_name ).
    ENDCASE.


  ENDMETHOD.


  METHOD on_item_double_click.

    DATA(obj) = node_get_usr_obj( node_key ).

    obj->action_item_double_click(
      node_key  = node_key
      item_name = item_name ).

    display( obj ).

  ENDMETHOD.


  METHOD on_link_click.

    DATA(obj) = node_get_usr_obj( node_key ).

    obj->action_link_click(
      node_key  = node_key
      item_name = item_name ).

    display( obj ).

  ENDMETHOD.


  METHOD on_node_cxt_menu_request.


    on_item_cxt_menu_request(
        node_key  = node_key
        item_name = space
        menu      = menu ).


  ENDMETHOD.


  METHOD on_node_cxt_menu_selected.


    on_item_cxt_menu_selected(
      EXPORTING
        node_key  = node_key
        item_name = space
        fcode     = fcode ).


  ENDMETHOD.


  METHOD on_node_double_click.

    DATA(obj) = node_get_usr_obj( node_key ).

    obj->action_node_double_click(
      node_key = node_key ).

    display( obj ).

  ENDMETHOD.


  method ON_SELECTION_CHANGED.
  endmethod.


  METHOD set_tree.


    me->tree_container = tree_container.
    me->data_container = data_container.

    CREATE OBJECT tree
      EXPORTING
*        node_selection_mode         = cl_list_tree_model=>node_sel_mode_multiple
        node_selection_mode         = cl_list_tree_model=>node_sel_mode_single
        item_selection              = abap_true
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
         ( eventid = cl_list_tree_model=>eventid_item_context_menu_req )
         ( eventid = cl_list_tree_model=>eventid_node_context_menu_req )
         ( eventid = cl_list_tree_model=>eventid_node_double_click )
         ( eventid = cl_list_tree_model=>eventid_item_double_click )
         ( eventid = cl_list_tree_model=>eventid_link_click  )
*         ( eventid = cl_list_tree_model=>eventid_selection_changed  )
         ( eventid = cl_list_tree_model=>eventid_checkbox_change  )
         ) ).

    SET HANDLER on_expand_no_children     FOR tree.
    SET HANDLER on_checkbox_change        FOR tree.
    SET HANDLER on_link_click             FOR tree.
    SET HANDLER on_item_cxt_menu_request  FOR tree.
    SET HANDLER on_item_cxt_menu_selected FOR tree.
    SET HANDLER on_node_double_click      FOR tree.
    SET HANDLER on_item_double_click      FOR tree.
    SET HANDLER on_expand_node            FOR tree.
    SET HANDLER on_selection_changed      FOR tree.


  ENDMETHOD.
ENDCLASS.
