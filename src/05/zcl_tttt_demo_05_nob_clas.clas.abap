CLASS zcl_tttt_demo_05_nob_clas DEFINITION
  PUBLIC
  INHERITING FROM zcl_tttt_demo_05_nob_base
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !name TYPE clike .

    METHODS zif_tttt_node~get_children
        REDEFINITION .
    METHODS zif_tttt_node~get_node_icon
        REDEFINITION .
    METHODS zif_tttt_node~is_folder
        REDEFINITION .
    METHODS zif_tttt_node~get_items
        REDEFINITION .
  PROTECTED SECTION.

    DATA clsobj TYPE REF TO if_oo_clif_components_flat .
    DATA attributes TYPE seo_attributes_flat .
    DATA methods TYPE seo_methods_flat .
    DATA events TYPE seo_events_flat .
    DATA parameters TYPE seo_parameters_flat .
    DATA exceptions TYPE seo_exceptions_flat .
    DATA types TYPE seoo_types_r .
    DATA seoclassdf TYPE seoclassdf .
    DATA clsname TYPE seoclsname .

    METHODS read_class_components .
  PRIVATE SECTION.

    METHODS get_description .
ENDCLASS.



CLASS zcl_tttt_demo_05_nob_clas IMPLEMENTATION.


  METHOD constructor.

    super->constructor( type = 'CLAS' name = name ).
    clsname = name.
    get_description( ).

  ENDMETHOD.


  METHOD get_description.

    CHECK zif_tttt_node~description IS INITIAL.

    SELECT * FROM seoclasstx INTO TABLE @DATA(descr)
     WHERE clsname = @obj_name.

    SELECT SINGLE * FROM seoclassdf INTO @me->seoclassdf
     WHERE clsname = @obj_name.

    TRY.
        zif_tttt_node~description = descr[ langu = sy-langu ]-descript.
      CATCH cx_sy_itab_line_not_found ##no_handler.
        zif_tttt_node~description = VALUE #( descr[ langu = 'E' ]-descript OPTIONAL ).
    ENDTRY.

  ENDMETHOD.


  METHOD read_class_components.


    DATA clskey TYPE seoclskey.

    clskey-clsname = clsname.
    CREATE OBJECT clsobj
      TYPE cl_oo_class_components_flat
      EXPORTING
        clskey                      = clskey
        with_interface_components   = abap_true
        with_inherited_components   = abap_true
        with_enhancement_components = abap_false
      EXCEPTIONS
        not_existing                = 1
        is_interface                = 2
        deleted                     = 3
        model_only                  = 4
        OTHERS                      = 5.
    IF sy-subrc = 0.
      me->attributes  = clsobj->attributes.
      me->methods     = clsobj->methods.
      me->events      = clsobj->events.
      me->parameters  = clsobj->parameters.
      me->exceptions  = clsobj->exceptions.
      me->types       = clsobj->types.

      SORT me->methods BY exposure.
    ENDIF.

  ENDMETHOD.


  METHOD zif_tttt_node~get_children.

    read_class_components( ).


    LOOP AT methods INTO DATA(method).
      APPEND NEW zcl_tttt_demo_05_nob_clasmeth(
        class_obj = me
        name      = method-cpdname ) TO children.
    ENDLOOP.


  ENDMETHOD.


  METHOD zif_tttt_node~get_items.

    items = VALUE #(

     ( item_name  = '1'
       class      = cl_item_tree_model=>item_class_text
       style      = cl_item_tree_model=>style_default
       font       = cl_item_tree_model=>item_font_prop
       text       = obj_name
       length     = 30 )

     ( item_name  = '2'
       class      = cl_item_tree_model=>item_class_text
       style      = cl_item_tree_model=>style_default
       font       = cl_item_tree_model=>item_font_prop
       text       = zif_tttt_node~description
       length     = 40 )
     ).

  ENDMETHOD.


  METHOD zif_tttt_node~get_node_icon.
    icon = icon_oo_class.
  ENDMETHOD.


  METHOD zif_tttt_node~is_folder.
    folder = abap_true.
  ENDMETHOD.
ENDCLASS.
