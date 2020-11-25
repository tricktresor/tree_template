class ZCL_TTTT_DEMO_APPLICATION_05 definition
  public
  create public .

public section.

  methods BUILD_NODES .
  methods START
    importing
      !TREE_CONTAINER type ref to CL_GUI_CONTAINER
      !DATA_CONTAINER type ref to CL_GUI_CONTAINER optional .
protected section.

  types:
    BEGIN OF _object,
      typ TYPE trobjtype,
      nam TYPE trobj_name,
      txt TYPE c LENGTH 80,
    END OF _object .
  types:
    _objects TYPE STANDARD TABLE OF _object WITH DEFAULT KEY .
private section.

  data TREE type ref to ZCL_TTTT_MAIN .
ENDCLASS.



CLASS ZCL_TTTT_DEMO_APPLICATION_05 IMPLEMENTATION.


  METHOD build_nodes.

    TYPES  _obj_types TYPE STANDARD TABLE OF trobjtype WITH DEFAULT KEY.
    DATA(obj_types) = VALUE _obj_types(
      ( 'CLAS' )
      ( 'INTF' )
      ( 'PROG' )
      ( 'STRU' )
      ( 'TABL' )
      ( 'TTYP' )
      ( 'DTEL' )
      ( 'DOMA' )
      ).

    LOOP AT obj_types INTO DATA(obj_type).
      DATA(o_objtyp) = tree->add_node(
        parent = VALUE #( )
        object = NEW zcl_tttt_demo_05_nob_type( obj_type ) ).
    ENDLOOP.
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
