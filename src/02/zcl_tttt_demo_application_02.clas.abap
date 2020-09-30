class ZCL_TTTT_DEMO_APPLICATION_02 definition
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



CLASS ZCL_TTTT_DEMO_APPLICATION_02 IMPLEMENTATION.


  METHOD build_nodes.


    DATA(menu_marvel) = tree->add_node(
      parent = VALUE #( )
      object = NEW zcl_tttt_demo_02_node_menu( 'MARVEL Universe' ) ).

    DATA(node_heroes)  = tree->add_node(
      parent = menu_marvel
      object = NEW zcl_tttt_demo_02_node_heroes( 'Characters' ) ).

    DATA(node_films)  = tree->add_node(
      parent = menu_marvel
      object = NEW zcl_tttt_demo_02_node_films( 'Films' ) ).

    tree->tree->expand_root_nodes( ).

  ENDMETHOD.


  METHOD start.

    tree = NEW zcl_tttt_main( ).
    tree->set_tree(
      tree_container = tree_container
      data_container = data_container ).

    build_nodes( ).

  ENDMETHOD.
ENDCLASS.
