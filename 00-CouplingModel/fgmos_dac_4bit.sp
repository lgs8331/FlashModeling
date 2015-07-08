** ---------------------------------------
** Author:	Lennard Streat
** Module:	Coupling Model FGMOS
** ---------------------------------------
.INCLUDE "45nm_MGK.pm"

.GLOBAL VDD GND VSS
.CONNECT GND 0


.OPTION post
+	ingold=2

** ---------------------------------------
** Parameters:
** ---------------------------------------
.PARAM K1 = '9/16'

* Source Reference Parameters
.PARAM VDD_VAL = 5
.PARAM VSS_VAL = -5
.PARAM VREF = VDD_VAL
.PARAM VSTEP_INCR = ((VDD_VAL-VSS_VAL)/10)
.PARAM VSET = 5
.PARAM IREF_VAL = 50u

* Transistor Sising Parameters:
.PARAM MLENGTH = 4u
.PARAM MWIDTH = 20u
.PARAM FGWIDTH = 40u

* Capacitor Values:
.PARAM CAP3_VAL = 8p
.PARAM CAP2_VAL = 4p
.PARAM CAP1_VAL = 2p
.PARAM CAP0_VAL = 1p
.PARAM CBCAP_VAL = 9.5p

.PARAM R3_VAL = (1/(K1*CAP3_VAL))
.PARAM R2_VAL = (1/(K1*CAP2_VAL))
.PARAM R1_VAL = (1/(K1*CAP1_VAL))
.PARAM R0_VAL = (1/(K1*CAP0_VAL))
** ---------------------------------------
** DC Sources:
** ---------------------------------------
Vrail_p VDD GND DC VDD_VAL
Vrail_n VSS GND DC VSS_VAL

Ib NTEST GND DC IREF_VAL
Rtst NTEST NIREF 1
*Vb NVBREF GND DC VB_VAL

** Input Signal:
Vd3 NFM1_D3 GND DC VDD_VAL
Cd3 NFM1_D3 NFGM1 CAP3_VAL
Rd3 NFM1_D3 NFGM1 R3_VAL

Vd2 NFM1_D2 GND DC VDD_VAL
Cd2 NFM1_D2 NFGM1 CAP2_VAL
Rd2 NFM1_D2 NFGM1 R2_VAL

Vd1 NFM1_D1 GND DC VDD_VAL
Cd1 NFM1_D1 NFGM1 CAP2_VAL
Rd1 NFM1_D1 NFGM1 R2_VAL

Vd0 NFM1_D0 GND DC VDD_VAL
Cd0 NFM1_D0 NFGM1 CAP0_VAL
Rd0 NFM1_D0 NFGM1 R0_VAL

* Offset Correction:
Vset NFM1_SET GND DC VSET
Cset NFM1_SET NFMG1 CBCAP_VAL


** ---------------------------------------
** FGMOS 4-bit DAC:
** ---------------------------------------
* Current Mirror:
M4 NIREF NIREF NM4M5 NM4M5 nmos L=MLENGTH W=MWIDTH
M5 NM4M5 NIREF VSS VSS nmos L=MLENGTH W=MWIDTH
M6 NS2 NIREF NM6M7 VSS nmos L=MLENGTH W=MWIDTH
M7 NM6M7 NIREF VSS VSS nmos L=MLENGTH W=MWIDTH
Rtst2 NS2 NS2tmp 1
* Floating Gate:
M1 VDD NFGM1 NS2tmp VDD nmos L=MLENGTH W=FGWIDTH

** ---------------------------------------
** Simulation Settings:
** ---------------------------------------
.DC Vd3 VSS_VAL VDD_VAL VSTEP_INCR
*.DC Vd2 VSS_VAL VDD_VAL VSTEP_INCR
*.DC Vd1 VSS_VAL VDD_VAL VSTEP_INCR
*.DC Vd0 VSS_VAL VDD_VAL VSTEP_INCR

.PRINT DC V(NS2,GND) 
.PLOT DC V(NS2,GND)
.PLOT DC I(Rtst) I(Rtst)  I(Rtst2)
.END
