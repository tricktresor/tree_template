REPORT ztttt_demo_04.

DATA application TYPE REF TO zcl_tttt_demo_application_04.
DATA screen_number TYPE dynnr.

TABLES addr1_val.

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

  screen_number = application->get_screen( ).

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

  application = NEW #( ).
  application->start(
    tree_container = main_container ).


ENDFORM.
