REPORT ztttt_demo_06.

DATA application TYPE REF TO zcl_tttt_demo_application_06.
DATA screen_number TYPE dynnr.

TABLES addr1_val.

SELECTION-SCREEN BEGIN OF SCREEN 101 AS SUBSCREEN.
PARAMETERS p01 AS CHECKBOX.
PARAMETERS p02 AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN END OF SCREEN 101.

SELECTION-SCREEN BEGIN OF SCREEN 102 AS SUBSCREEN.
PARAMETERS p11 TYPE char10.
PARAMETERS p12 TYPE char03.
PARAMETERS p13 AS CHECKBOX DEFAULT 'X'.
SELECTION-SCREEN END OF SCREEN 102.

SELECTION-SCREEN BEGIN OF SCREEN 201 AS SUBSCREEN.
PARAMETERS p22 AS CHECKBOX DEFAULT 'X'.
PARAMETERS p21 TYPE char05.
SELECTION-SCREEN END OF SCREEN 201.

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
