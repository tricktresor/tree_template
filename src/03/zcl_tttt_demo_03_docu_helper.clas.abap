class ZCL_TTTT_DEMO_03_DOCU_HELPER definition
  public
  final
  create public .

public section.

  class-methods SHOW_DOCU
    importing
      !HTML_CONTROL type ref to CL_GUI_HTML_VIEWER
      !HTML_LINES type W3HTMLTAB .
  class-methods READ_DOCU
    importing
      !ID type DOKHL-ID
      !OBJECT type DOKHL-OBJECT
    returning
      value(DOCU_HTML) type W3HTMLTAB .
protected section.
private section.
ENDCLASS.



CLASS ZCL_TTTT_DEMO_03_DOCU_HELPER IMPLEMENTATION.


  METHOD read_docu.


    DATA header     TYPE thead.
    DATA docu_lines TYPE tline_tab.


    CALL FUNCTION 'DOCU_GET'
      EXPORTING
        id                = id
        langu             = sy-langu
        object            = object
      IMPORTING
        head              = header
      TABLES
        line              = docu_lines
      EXCEPTIONS
        no_docu_on_screen = 1
        no_docu_self_def  = 2
        no_docu_temp      = 3
        ret_code          = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      header = VALUE #(
        tdobject   = 'DOKU'
        tdname     = 'DUMMY'
        tdid       = 'RE'
        tdspras	   = sy-langu
        tdtitle	   = 'Dummy'
        tdform     = 'S_DOCU_SHOW'
        tdstyle	   = 'S_DOCUS1'
        tdversion  = '00001'
        tdfuser	   = 'TRCKTRSR'
        tdluser	   = 'TRCKTRSR'
        tdlinesize = '072' ).

      docu_lines = VALUE #( ( tdformat = 'AS' tdline = TEXT-nex ) ).
    ENDIF.


    DATA(conv_parformats) = VALUE tline_t(
                   ( tdformat = 'U1' tdline = '<h1>' )
                   ( tdformat = 'U2' tdline = '<h2>' )
                   ( tdformat = 'AS' tdline = '<p>'  ) ).

    CALL FUNCTION 'CONVERT_ITF_TO_HTML'
      EXPORTING
        i_header          = header
        i_html_header     = abap_false
      TABLES
        t_itf_text        = docu_lines
        t_html_text       = docu_html
        t_conv_parformats = conv_parformats
      EXCEPTIONS
        OTHERS            = 4.

    IF sy-subrc = 0.
      INSERT '<body>' INTO docu_html INDEX 1.
      APPEND '</body>' TO docu_html.
    ENDIF.

  ENDMETHOD.


  METHOD show_docu.

    DATA assigned_url TYPE c LENGTH 1000.
    DATA html TYPE w3htmltab.

    html = html_lines.

    html_control->load_data(
      EXPORTING
        encoding               = 'utf-8'
      IMPORTING
        assigned_url           = assigned_url
      CHANGING
        data_table             = html
      EXCEPTIONS
        OTHERS                 = 5   ).
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
    html_control->show_data(
      EXPORTING
        url                    = assigned_url
      EXCEPTIONS
        OTHERS                 = 5 ).
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    html_control->do_refresh( ).

  ENDMETHOD.
ENDCLASS.
