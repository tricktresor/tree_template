class ZCL_TTTT_DEMO_APPLICATION_06 definition
  public
  create public .

public section.

  methods BUILD_NODES .
  methods START
    importing
      !TREE_CONTAINER type ref to CL_GUI_CONTAINER .
  methods GET_SCREEN
    returning
      value(SCREEN_NR) type DYNNR .
protected section.
private section.

  data TREE type ref to ZCL_TTTT_MAIN_SINGLE .
ENDCLASS.



CLASS ZCL_TTTT_DEMO_APPLICATION_06 IMPLEMENTATION.


  METHOD BUILD_NODES.

    "Next step: read from customizing table...

    DATA(fol_header) = tree->add_node(
      parent = VALUE #( )
      object = NEW zcl_tttt_demo_06_folder( 'Header'(h00) ) ).

    DATA(header_detail) = tree->add_node(
      parent = fol_header
      object = NEW zcl_tttt_demo_06_screen(
        description = 'Detail'(h01)
        screen_nr   = '0101' ) ).

    DATA(header_address) = tree->add_node(
      parent = fol_header
      object = NEW zcl_tttt_demo_06_screen(
        description = 'Address'(h02)
        screen_nr   = '0102' ) ).

    DATA(fol_items) = tree->add_node(
      parent = VALUE #( )
      object = NEW zcl_tttt_demo_06_folder( 'Item data'(i01) ) ).

    DATA(item_overview) = tree->add_node(
      parent = fol_items
      object = NEW zcl_tttt_demo_06_screen(
        description = 'Item overview'(i02)
        screen_nr   = '0201' ) ).

    tree->tree->expand_root_nodes( ).

  ENDMETHOD.


  METHOD GET_SCREEN.
    screen_nr = tree->get_screen( ).
  ENDMETHOD.


  METHOD START.

    tree = NEW zcl_tttt_main_single( ).
    tree->set_tree(
      tree_container = tree_container ).

    build_nodes( ).

  ENDMETHOD.
ENDCLASS.
