/* TRV settings, TODO: clean up and move generic ones to common settings. */

/*
Valve attachment measurements

All measurements below are used by the test valve connector.
*/

// Screw attributes. At the moment, the only supported combination is:
// diameter: 30, pitch:1.5
screw_diameter=30;
screw_pitch=1.5;
// The screw tolerance allows the screw connector to be scale slightly in order
// to give a bit of tolerance to how snuggly the screw fits the valve
screw_tolerance=0.01;
screw_height=10;
screw_thickness=2;
screw_protusion_number=12;

// Connector attributes
connector_height=15;
connector_slit_number=8; // this has to be an even number (for the moment)
connector_slit_thickness=2;
connector_slit_offset=3;
connector_plate_thickness=1;

