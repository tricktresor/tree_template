class ZCL_TTTT_DEMO_APPLICATION_03 definition
  public
  create public .

public section.

  methods BUILD_NODES .
  methods START
    importing
      !TREE_CONTAINER type ref to CL_GUI_CONTAINER
      !DATA_CONTAINER type ref to CL_GUI_CONTAINER optional .
protected section.
private section.

  data TREE type ref to ZCL_TTTT_MAIN .
ENDCLASS.



CLASS ZCL_TTTT_DEMO_APPLICATION_03 IMPLEMENTATION.


  METHOD build_nodes.

    "Next step: read from customizing table...

    DATA(menu_system) = tree->add_node(
      parent = VALUE #( )
      object = NEW zcl_tttt_demo_02_node_menu( TEXT-sys ) ).

    DATA(tran_sm04) = tree->add_node(
      parent = menu_system
      object = NEW zcl_tttt_demo_03_node_tran(  tcode = 'SM04' ) ).

    DATA(rep_showicon) = tree->add_node(
      parent = menu_system
      object = NEW zcl_tttt_demo_03_node_prog(  repid = 'SHOWICON' ) ).

    DATA(rep_help) = tree->add_node(
      parent = menu_system
      object = NEW zcl_tttt_demo_03_node_prog(  repid = 'DEMO_GUI_ALV_GRID_EXT' description = TEXT-001 ) ).

    tree->tree->expand_root_nodes( ).

  ENDMETHOD.


  METHOD START.

    tree = NEW zcl_tttt_main( ).
    tree->set_tree(
      tree_container = tree_container
      data_container = data_container ).

    build_nodes( ).

  ENDMETHOD.
ENDCLASS.
