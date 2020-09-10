CLASS zcl_tttt_main DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS set_tree
      IMPORTING
        !container TYPE REF TO cl_gui_container .
    METHODS add_node
      IMPORTING
        !parent             TYPE tm_nodekey
        !object             TYPE REF TO zif_tttt_node
      RETURNING
        VALUE(new_node_key) TYPE tm_nodekey .
    METHODS node_get_usr_obj
      IMPORTING
        !node_key  TYPE tm_nodekey
      RETURNING
        VALUE(obj) TYPE REF TO zif_tttt_node .
  PROTECTED SECTION.

    TYPES:
      BEGIN OF ty_node,
        key TYPE tm_nodekey,
        pnt TYPE tm_nodekey,
        obj TYPE REF TO zif_tttt_node,
        sel TYPE boolean_flg,
      END OF ty_node .
    TYPES:
      ty_nodes TYPE SORTED TABLE OF ty_node WITH UNIQUE KEY key .

    DATA tree TYPE REF TO cl_list_tree_model .
    DATA ctrl TYPE REF TO cl_gui_control .
    DATA all_nodes TYPE ty_nodes .
    DATA root_node TYPE tm_nodekey .

    METHODS on_checkbox_change
        FOR EVENT checkbox_change OF cl_list_tree_model
      IMPORTING
        !checked
        !item_name
        !node_key .
    METHODS on_expand_node
        FOR EVENT expand_no_children OF cl_list_tree_model
      IMPORTING
        !node_key .
    METHODS on_expand_no_children
        FOR EVENT expand_no_children OF cl_list_tree_model
      IMPORTING
        !node_key
        !sender .
    METHODS on_item_cxt_menu_request
        FOR EVENT item_context_menu_request OF cl_list_tree_model
      IMPORTING
        !item_name
        !menu
        !node_key .
    METHODS on_item_cxt_menu_selected
        FOR EVENT item_context_menu_select OF cl_list_tree_model
      IMPORTING
        !fcode
        !item_name
        !node_key .
    METHODS on_item_double_click
        FOR EVENT item_double_click OF cl_list_tree_model
      IMPORTING
        !item_name
        !node_key .
    METHODS on_link_click
        FOR EVENT link_click OF cl_list_tree_model
      IMPORTING
        !item_name
        !node_key .
    METHODS on_node_cxt_menu_request
        FOR EVENT node_context_menu_request OF cl_list_tree_model
      IMPORTING
        !menu
        !node_key .
    METHODS on_node_cxt_menu_selected
        FOR EVENT node_context_menu_select OF cl_list_tree_model
      IMPORTING
        !fcode
        !node_key .
    METHODS on_node_double_click
        FOR EVENT node_double_click OF cl_list_tree_model
      IMPORTING
        !node_key .
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TTTT_MAIN IMPLEMENTATION.


  METHOD add_node.


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
        isfolder                = abap_true
        hidden                  = space
        disabled                = space
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


    node_get_usr_obj( node_key )->action_item_double_click(
      node_key  = node_key
      item_name = item_name ).


  ENDMETHOD.


  METHOD on_link_click.


    node_get_usr_obj( node_key )->action_link_click(
      node_key  = node_key
      item_name = item_name ).


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


    node_get_usr_obj( node_key )->action_node_double_click(
      node_key = node_key ).


  ENDMETHOD.


  METHOD set_tree.


    CREATE OBJECT tree
      EXPORTING
        node_selection_mode         = cl_list_tree_model=>node_sel_mode_multiple
*       node_selection_mode         = cl_list_tree_model=>node_sel_mode_single
        item_selection              = abap_true    " Can Individual Items be Selected?
        with_headers                = abap_false   " 'X': With Headers
      EXCEPTIONS
        illegal_node_selection_mode = 1
        OTHERS                      = 2.
    IF sy-subrc > 0.
      MESSAGE |create tree rc: { sy-subrc }| TYPE 'I'.
    ENDIF.


    tree->create_tree_control(
      EXPORTING
        parent  = container
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
         ( eventid = cl_list_tree_model=>eventid_checkbox_change  ) ) ).

    SET HANDLER on_expand_no_children     FOR tree.
    SET HANDLER on_checkbox_change        FOR tree.
    SET HANDLER on_link_click             FOR tree.
    SET HANDLER on_item_cxt_menu_request  FOR tree.
    SET HANDLER on_item_cxt_menu_selected FOR tree.
    SET HANDLER on_node_double_click      FOR tree.
    SET HANDLER on_item_double_click      FOR tree.
    SET HANDLER on_expand_node            FOR tree.


  ENDMETHOD.
ENDCLASS.
