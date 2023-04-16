
MainRunner() {
    self endon(#"disconnect", #"spawned_player");
    level endon(#"end_game", #"game_ended");

    for(;;)
    {
        if (is_mod_activated("maxpoints")) {
            self.score = 99999;
        }

        if (is_mod_activated("spin_me")) {
            angles = self GetPlayerAngles();
            if (!isdefined(self.spin_me_old_angles_roll)) {
                self.spin_me_old_angles_roll = angles[2];
            }
            self setPlayerAngles((angles[0], angles[1], (GetTime() / 3000 * 360))); // every 3s 1 turn
        } else if (isdefined(self.spin_me_old_angles_roll)) {
            angles = self GetPlayerAngles();
            self setPlayerAngles((angles[0], angles[1], self.spin_me_old_angles_roll));
            self.spin_me_old_angles_roll = undefined;
        }

        if (isdefined(self.tool_invulnerability) && self.tool_invulnerability) {
            self freezeControls(false);
            self enableInvulnerability();
            self val::set(#"atianmod", "disable_oob", true);
        }
        if (isdefined(self.tool_zmignoreme) && self.tool_zmignoreme) {
            self val::set(#"atianmod", "ignoreme", true);
        }

        if (isdefined(self.rocketman_rocket) && self key_mgr_has_key_pressed(#"fly_key", false)) {
            // delete the rocketman rocket if the user is sprinting
            self.rocketman_rocket delete();
        }

        // waits a single frame
        waitframe(1);
    }
}

WaypointPlaced(response, intpayload) {
	if(!isalive(self) || response != "placed" || !self is_mod_activated("waypoint_tp")) {
		return;
	}
    
    if (!isdefined(level.var_405a6738) || !isdefined(level.var_8a390df2)) {
        self iPrintLnBold("^1can't get map size");
        return;
    }
    
    xcoord = int(intpayload / 1000);
    ycoord = intpayload - (xcoord * 1000);

    // map size x : var_405a6738
    // map size y : var_8a390df2
    y = (xcoord - 500) / 500 * (0-level.var_405a6738);
    x = (ycoord - 500) / 500 * (0-level.var_8a390df2);
    
    self iPrintLnBold("^3teleported to ^4" + x + "^3/^4" + y);

    position = bullettrace((x, y, 5000), (x, y, -5000), 0, self, 1)[#"position"];
    self setOrigin(position);
}