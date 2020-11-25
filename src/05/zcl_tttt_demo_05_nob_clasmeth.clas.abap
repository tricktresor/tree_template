class ZCL_TTTT_DEMO_05_NOB_CLASMETH definition
  public
  inheriting from zcl_tttt_demo_05_nob_clas
  create public .

public section.

  methods CONSTRUCTOR
    importing
      !NAME type CLIKE
      !CLASS_OBJ type ref to zcl_tttt_demo_05_nob_clas .

  methods ZIF_TTTT_NODE~GET_CHILDREN
    redefinition .
  methods ZIF_TTTT_NODE~GET_NODE_ICON
    redefinition .
protected section.

  data CLASS_NODE_OBJ type ref to zcl_tttt_demo_05_nob_clas .
private section.

  data METHNAME type SEOCPDNAME .
ENDCLASS.



CLASS ZCL_TTTT_DEMO_05_NOB_CLASMETH IMPLEMENTATION.


  METHOD constructor.

    super->constructor( name = name ).
    methname = name.
    class_node_obj = class_obj.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~ACTIONZIF_TTTT_NODE_DOUBLE_CLICK.


  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~GETZIF_TTTT_NODE_ICON.

    icon = icon_dummy.

  ENDMETHOD.


  METHOD zif_tttt_node~get_children.

    LOOP AT parameters INTO DATA(param)
    WHERE clsname = obj_name.
      APPEND NEW zcl_tttt_demo_05_nob_base( type = 'MPAR' name = param-cpdname ) TO children.
    ENDLOOP.

  ENDMETHOD.


  METHOD zif_tttt_node~get_node_icon.

    TRY.
        icon = SWITCH #( class_node_obj->methods[ cpdname = me->obj_name ]-exposure
          WHEN 0 THEN icon_led_red      "Private
          WHEN 1 THEN icon_led_yellow   "Protected
          WHEN 2 THEN icon_led_green ). "Public
      CATCH cx_sy_itab_line_not_found ##no_handler.
        icon = icon_parameter.
    ENDTRY.

  ENDMETHOD.
ENDCLASS.
