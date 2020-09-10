class ZCL_TTTT_DEMO_APPLICATION_01 definition
  public
  create public .

public section.

  methods BUILD_NODES .
  methods START
    importing
      !CONTAINER type ref to CL_GUI_CONTAINER .
protected section.
private section.

  data TREE type ref to ZCL_TTTT_MAIN .
ENDCLASS.



CLASS ZCL_TTTT_DEMO_APPLICATION_01 IMPLEMENTATION.


  METHOD build_nodes.


    DATA(a1) = tree->add_node(
      parent = VALUE #( )
      object = NEW zcl_tttt_node_base( 'top A' ) ).

    DATA(a2) = tree->add_node(
      parent = a1
      object = NEW zcl_tttt_node_base( '2nd A level' ) ).

    DATA(a3) = tree->add_node(
      parent = a2
      object = NEW zcl_tttt_node_base( '3rd A level' ) ).

    DATA(b1) = tree->add_node(
      parent = VALUE #( )
      object = NEW zcl_tttt_node_base( 'top B' ) ).

    DATA(b2) = tree->add_node(
      parent = b1
      object = NEW zcl_tttt_node_base( '2nd B level (1)' ) ).

    DATA(b3) = tree->add_node(
      parent = b1
      object = NEW zcl_tttt_node_base( '2nd B level (2)' ) ).

  ENDMETHOD.


  METHOD start.

    tree = NEW zcl_tttt_main( ).
    tree->set_tree( container ).

    build_nodes( ).

  ENDMETHOD.
ENDCLASS.
