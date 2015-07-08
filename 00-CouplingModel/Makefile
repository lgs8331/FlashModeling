
MODULE_NAME = fgmos_dac_4bit
SPICE_SIM = hspice
DISPLAY_PRGM = ezwave

all: $(MODULE_NAME).lis

$(MODULE_NAME).lis: $(MODULE_NAME).sp
	$(SPICE_SIM) $(MODULE_NAME).sp > $(MODULE_NAME).lis

trans: $(MODULE_NAME).lis
	$(DISPLAY_PRGM) $(MODULE_NAME).tr0 &
dc: $(MODULE_NAME).lis
	$(DISPLAY_PRGM) $(MODULE_NAME).sw0 &

clean:
	if [ -f $(MODULE_NAME).lis ]; then rm $(MODULE_NAME).lis; fi;
	if [ -f $(MODULE_NAME).ic0 ]; then rm $(MODULE_NAME).ic0; fi;
	if [ -f $(MODULE_NAME).st0 ]; then rm $(MODULE_NAME).st0; fi;
	if [ -f $(MODULE_NAME).tr0 ]; then rm $(MODULE_NAME).tr0; fi;
	if [ -f $(MODULE_NAME).sw* ]; then rm $(MODULE_NAME).sw*; fi;
	if [ -f *.log ]; then rm *.log; fi;
