broadcast_message(str_message) {
    players = getplayers();
    foreach(player in players) {
        player iPrintLnBold(str_message);
    }
}
broadcase_message_wait(str_message, ttw) {
    if (!isdefined(ttw) || ttw <= 0) {
        broadcast_message(str_message);
        return;
    }

    for (i = 1; i <= ttw; i++) {
        broadcast_message(str_message + "^2 (" + i + "/" + ttw + "s)");
        wait 1;
    }
}

to_str_bool(bool_value) {
    if (!isdefined(bool_value)) {
        return "undefined";
    }
    if (bool_value) {
        return "true";
    }
    return "false";
}
nullable_to_str(obj, default_obj = "") {
    if (isdefined(obj)) {
        return obj;
    } else {
        return default_obj;
    }
}