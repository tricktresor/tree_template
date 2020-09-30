REPORT ztttt_demo_03.

DATA application TYPE REF TO zcl_tttt_demo_application_03.

START-OF-SELECTION.
  CALL SCREEN 100.

*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.

  SET PF-STATUS '100'.
  SET TITLEBAR '100'.
  CLEAR sy-ucomm.

  PERFORM init.

ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'BACK'
      OR 'HOME'
      OR 'CANCEL'.
      SET SCREEN 0.
      LEAVE SCREEN.
  ENDCASE.

ENDMODULE.

FORM init.

  CHECK application IS INITIAL.

  DATA(main_container) = NEW cl_gui_custom_container( container_name = 'CC' dynnr = '0100' repid = sy-repid ).
  DATA(main_splitter)  = NEW cl_gui_splitter_container(
    parent  = main_container
    rows    = 1
    columns = 2 ).

  main_splitter->set_column_width(
      id    = 1
      width = 30 ).

  application = NEW #( ).
  application->start(
    tree_container = main_splitter->get_container( row = 1 column = 1 )
    data_container = main_splitter->get_container( row = 1 column = 2 ) ).


ENDFORM.
