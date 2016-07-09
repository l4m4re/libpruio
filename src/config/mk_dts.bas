/'* \file dts_universal.bas
\brief Tool to create, compile and install an universal device tree overlay for libpruio for run-time pinmuxing.

This is a helper tool for an universal device tree overlay. Adapt this
FB source code, compile it and run the executable. This will create a
device tree overlay source file in the current directory. 

The universal overlay provides pinmuxing capability at run-time. Root
privileges are required to achieve this. It claims all header pins and
prepares configurations for all modes. By default the free header pins
on a Beaglebone Green are declared. Customizing can be done to include
more pins (ie. the HDMI pins when not used) or to reduce the number of
pins (ie. when they interfere with other capes).

- To include a pins group uncomment the matching `PIN_DEL(...)` line, or

- to drop a pin add a code line like `M(P8_08) = ""` right below the
  `PIN_DEL(...)` lines.

Licence: GPLv3

Copyrighe 2014 by Thomas{ dOt ]Freiherr[ At ]gmx[ DoT }net
          2016 by lamare[ At ]gmail[ DoT }com

Adapted from dts_universal.bas by lamare:

- Removed the -00A0 version from the output filename.

- Removed the call to the dts compiler, since that is handled by LaMake.

- Removed the pins for BB-UART2, which is the Grove UART on the
  BeagleBone Green. So, enabling these gives a conflict on the Green, as
  stated by Thomas:

https://groups.google.com/forum/#!msg/beagleboard/CN5qKSmPIbc/2UdstwjNhHMJ 

    You need not disable UART2 for BBG. Instead you can disable libpruio
    control for pin P9_22 in file dts_universal.bas by adding a line

    M(P9_22) = "" '' right below the PIN_DEL(...) lines.

    in order to release this pin from the libpruio overlay. Also, you can
    free the HDMI pins by removing the line

    PIN_DEL(HDMI_Pins)

    Adapt before running the command fbc -w all dts_universal.bas.


\since 0.2
'/

#INCLUDE ONCE "pruiotools.bas"

'''''''''''''''''''''''''''''''''''''''''''''''''''''''' adapt this code

'* The file name.
#DEFINE FILE_NAME "libpruio"
'* The version.
#DEFINE VERS_NAME "00A0"

' quick & dirty: first create settings for all pins ...
#INCLUDE ONCE "P8.bi"
#INCLUDE ONCE "P9.bi"
' ... then delete unwanted
PIN_DEL(HDMI_Pins)
PIN_DEL(EMMC2_Pins)
PIN_DEL(I2C1_Pins)
PIN_DEL(I2C2_Pins)
PIN_DEL(MCASP0_Pins)

' BBG Grove UART:
M(P9_22) = ""

''''''''''''''''''''''''''''''''''''''''''''''''''''''' end of adaptions


VAR fnam = FILE_NAME, _    '*< The file name (without path / suffix)
     fnr = FREEFILE        '*< The file number.
IF OPEN(fnam & ".dts" FOR OUTPUT AS fnr) THEN
'IF OPEN CONS(FOR OUTPUT AS #fnr) THEN
  '?"failed openig console"
  ?"failed writing file: " & fnam & ".dts"
ELSE
  PRINT #fnr, ALL_START;

  FOR i AS LONG = 0 TO UBOUND(M)
    VAR x = IIF(LEN(M(i)), nameBall(i), 0) '*< The header pin name.
    IF x THEN PRINT #fnr, ENTRY_EXCL(*x);
  NEXT

  PRINT #fnr, FRAG0_START;

  FOR i AS LONG = 0 TO UBOUND(M)
    IF LEN(M(i)) THEN PRINT #fnr, f0entry(i);
  NEXT

  PRINT #fnr, FRAG0_END;
  PRINT #fnr, FRAG1_START;

  FOR i AS LONG = 0 TO UBOUND(M)
    IF LEN(M(i)) THEN PRINT #fnr, f1entry(i);
  NEXT

  PRINT #fnr, FRAG1_END;
  PRINT #fnr, ALL_END;
  CLOSE #fnr

END IF
