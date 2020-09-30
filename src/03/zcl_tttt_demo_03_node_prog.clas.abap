class ZCL_TTTT_DEMO_03_NODE_PROG definition
  public
  create public .

public section.

  interfaces ZIF_TTTT_NODE .

  methods CONSTRUCTOR
    importing
      !DESCRIPTION type CLIKE optional
      !REPID type REPID .
  PROTECTED SECTION.
private section.

  types:
    BEGIN OF _film,
      title    TYPE string,
      year     TYPE n LENGTH 4,
      director TYPE string,
    END OF _film .
  types:
    _films TYPE STANDARD TABLE OF _film .

  data REPORTNAME type REPID .
  data DOCU_LINES type TLINE_TAB .
  data DOCU_CONTROL type ref to CL_GUI_HTML_VIEWER .
  data DOCU_HTML type W3HTMLTAB .

  methods CREATE_CONTROL .
ENDCLASS.



CLASS ZCL_TTTT_DEMO_03_NODE_PROG IMPLEMENTATION.


  METHOD constructor.
    DATA report_texts TYPE STANDARD TABLE OF textpool WITH NON-UNIQUE KEY id key.

    IF description IS INITIAL.
      READ TEXTPOOL repid INTO report_texts.
      TRY.
          zif_tttt_node~description = report_texts[ id = 'P' ]-entry.
        CATCH cx_sy_itab_line_not_found ##no_handler.
          zif_tttt_node~description = TEXT-mis.
      ENDTRY.
    ELSE.
      zif_tttt_node~description = description.
    ENDIF.

    reportname = repid.

  ENDMETHOD.


  METHOD create_control.

    IF docu_control IS INITIAL.
      docu_control = NEW #( parent = zif_tttt_node~container  ).
    ENDIF.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~ACTIONZIF_TTTT_NODE_DOUBLE_CLICK.


  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~ACTION_ITEM_CXT_MENU_REQUEST.

    menu->add_function(
      EXPORTING
        fcode             = 'Demo'
        text              = 'Demo function'  ).

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~ACTION_ITEM_CXT_MENU_SELECTED.

    CASE fcode.
      WHEN 'Demo'.
        MESSAGE |demo function| TYPE 'I'.
    ENDCASE.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~ACTION_ITEM_DOUBLE_CLICK.

    zif_tttt_node~action_node_double_click( node_key ).

  ENDMETHOD.


  METHOD zif_tttt_node~action_link_click.

    create_control( ).

    zcl_tttt_demo_03_docu_helper=>show_docu(
      html_control = docu_control
      html_lines   = zcl_tttt_demo_03_docu_helper=>read_docu(
                       id     = 'RE'
                       object = CONV #( reportname ) ) ).


  ENDMETHOD.


  METHOD zif_tttt_node~action_node_double_click.

    SUBMIT (reportname) VIA SELECTION-SCREEN AND RETURN.

  ENDMETHOD.


  method ZIF_TTTT_NODE~ACTION_SELECTION_CHANGED.
  endmethod.


  METHOD ZIF_TTTT_NODE~GETZIF_TTTT_NODE_ICON.

    icon = icon_dummy.

  ENDMETHOD.


  METHOD zif_tttt_node~get_control.

    create_control( ).
    control = docu_control.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~GET_ITEMS.


    items = VALUE #(
     ( item_name  = '3'
       class      = cl_item_tree_model=>item_class_link
       style      = cl_item_tree_model=>style_default
       font       = cl_item_tree_model=>item_font_prop
       text       = space
       t_image    = icon_information
       length     = 4 )

     ( item_name  = '5'
       class      = cl_item_tree_model=>item_class_text
       style      = cl_item_tree_model=>style_default
       font       = cl_item_tree_model=>item_font_prop
       text       = reportname
       length     = 32 )

     ( item_name  = zif_tttt_node=>item_name-description
       class      = cl_item_tree_model=>item_class_text
       style      = cl_item_tree_model=>style_default
       font       = cl_item_tree_model=>item_font_prop
       text       = zif_tttt_node~description
       length     = 40 )
     ).

  ENDMETHOD.


  METHOD zif_tttt_node~get_node_icon.
    icon = icon_abap.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~IS_DISABLED.
    disabled = abap_false.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~IS_FOLDER.
    folder = abap_false.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~SET_CONTAINER.

    zif_tttt_node~container = cont.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~SET_MARK.

    zif_tttt_node~chosen = chosen.

  ENDMETHOD.
ENDCLASS.
