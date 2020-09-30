REPORT ZTTTT_DEMO_01.


PARAMETERS dummy.

INITIALIZATION.
  new zcl_tttt_demo_application_01( )->start( NEW cl_gui_docking_container( ratio = 90 side = cl_gui_docking_container=>dock_at_bottom ) ).
