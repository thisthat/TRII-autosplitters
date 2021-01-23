// Great Wall Tomb Raider II Autosplitter for Livesplit
// Author: thisthat
// Version 1

state("tomb2") {
	uint title : 0x11BD90;
	uint level : 0xD9EB0;
}

init {
	vars.state = 0;
}

start {
	return (current.title == 0) && (current.level == 1);
}

reset {
	var ret = (current.title == 1);
	if(ret) {
		vars.state = 0;
	}
	return ret;
}

isLoading {
	return true;
}

split {
    var pos_z = memory.ReadValue<float>((IntPtr)(0x520718));
    var pos_x = memory.ReadValue<float>((IntPtr)(0x520710));
    var key = memory.ReadValue<byte>((IntPtr)(0x4D792C));

	if(vars.state == 0) {
		// Check if we are up the wall
		if(pos_x < 7.734466874E-41) {
			vars.state++;
			return true;
		}
	}
	if(vars.state == 1){
		// check if we pull the leaver and pass through the door
		if(pos_x < 6.803724434E-41 && (4.721114656E-41 <= pos_z && pos_z <= 4.897117743E-41)) {
			vars.state++;
			return true;
		}
	}
	if(vars.state == 2){
		// do we have the first key?
		if(key == 1){
			vars.state++;
			return true;
		}
	}
	if(vars.state == 3){
		// pass throught the door
		if(pos_x < 4.266953824E-41 && (4.720974526E-41 <= pos_z && pos_z <= 4.91799709E-41)) {
			vars.state++;
			return true;
		}
	}
	if(vars.state == 4){
		// do we have the second key?
		if(key == 1){
			vars.state++;
			// split when we use it
		}
	}
	if(vars.state == 5){
		// do we use the second key?
		if(key == 0){
			vars.state++;
			return true;
		}
	}
	if(vars.state == 6){
		// up from the water
		if(pos_z > 7.188661122E-41 && (1.58E-41 <= pos_x && pos_x <= 1.71E-41)) {
			vars.state++;
			return true;
		}
	}
	if(vars.state == 7){
		// don't get crushed v1
		if(pos_x > 3.744689886E-41 && (8.336744954E-41 <= pos_z && pos_z <= 8.451931688E-41)) {
			vars.state++;
			return true;
		}
	}
	if(vars.state == 8){
		// don't get crushed v2
		if(pos_z > 8.766102803E-41 && (7.76E-41 <= pos_x && pos_x <= 7.88E-41)) {
			vars.state++;
			return true;
		}
	}
	if(vars.state == 9){
		// pulley FTW
		if(pos_x > 8.40E-41 && (1.05E-40 <= pos_z && pos_z <= 1.055E-40)) {
			vars.state++;
			return true;
		}
	}
	if(vars.state == 10){
		// finish the level
		return (current.level != old.level);
	}
}

