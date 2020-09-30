class ZCL_TTTT_DEMO_02_NODE_FILMS definition
  public
  create public .

public section.

  interfaces ZIF_TTTT_NODE .

  methods CONSTRUCTOR
    importing
      !DESCRIPTION type STRING .
  PROTECTED SECTION.
PRIVATE SECTION.

  TYPES:
    BEGIN OF _film,
      title    TYPE string,
      year     TYPE n LENGTH 4,
      director TYPE string,
    END OF _film.
  TYPES:
    _films TYPE STANDARD TABLE OF _film.

  DATA film_grid TYPE REF TO cl_gui_alv_grid .
  DATA films TYPE _films .

  METHODS get_fcat
    RETURNING
      VALUE(fieldcatalog) TYPE lvc_t_fcat .
  METHODS create_grid .
  METHODS read_films .
ENDCLASS.



CLASS ZCL_TTTT_DEMO_02_NODE_FILMS IMPLEMENTATION.


  METHOD CONSTRUCTOR.

    zif_tttt_node~description = description.

    read_films( ).

  ENDMETHOD.


  METHOD CREATE_GRID.

    CHECK film_grid IS INITIAL.

    film_grid = NEW #(
      i_parent         = zif_tttt_node~container  ).

    DATA(fcat) = get_fcat( ).

    film_grid->set_table_for_first_display(
      CHANGING
        it_outtab                     = films
        it_fieldcatalog               = fcat
      EXCEPTIONS
        invalid_parameter_combination = 1                    " Wrong Parameter
        program_error                 = 2                    " Program Errors
        too_many_lines                = 3                    " Too many Rows in Ready for Input Grid
        OTHERS                        = 4 ).
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

  ENDMETHOD.


  METHOD GET_FCAT.

    fieldcatalog = VALUE #(
      ( fieldname = 'TITLE'
        reptext   = 'Film title'
        outputlen = 40
        datatype  = 'C' )
      ( fieldname = 'YEAR'
        reptext   = 'Year'
        outputlen = 4
        datatype  = 'N' )
      ( fieldname = 'DIRECTOR'
        reptext   = 'Director'
        outputlen = 40
        datatype  = 'C' )

         ).

  ENDMETHOD.


  METHOD read_films.

    films = VALUE #(
      ( title = `Black Widow` year = '2020' director = `Cate Shortland` )
      ( title = `Spider-Man - Far From Home` year = '2019' director = `Jon Watts` )

    ).

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

    CASE item_name.
      WHEN 'xxx'.
      WHEN OTHERS.
        MESSAGE |item { item_name }| TYPE 'S'.
    ENDCASE.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~ACTION_LINK_CLICK.

    MESSAGE |Link click on node { node_key } item { item_name }| TYPE 'S'.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~ACTION_NODE_DOUBLE_CLICK.
  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~GETZIF_TTTT_NODE_ICON.

    icon = icon_dummy.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~GET_CONTROL.

    create_grid( ).

    control = film_grid.

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~GET_ITEMS.


    items = VALUE #(

     ( item_name  = zif_tttt_node=>item_name-description
       class      = cl_item_tree_model=>item_class_text
       style      = cl_item_tree_model=>style_default
       font       = cl_item_tree_model=>item_font_prop
       text       = zif_tttt_node~description
       length     = 40 )
     ).

  ENDMETHOD.


  METHOD ZIF_TTTT_NODE~GET_NODE_ICON.
    icon = icon_model.
  ENDMETHOD.


  METHOD zif_tttt_node~is_disabled.
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
