if (!player_confirm) {
    if (keyboard_check_pressed(ord("D"))) {
        player_index = (p1_index + 1) mod array_length(charcters);
    }
    if (keyboard_check_pressed(ord("A"))) {
        player_index = (p1_index - 1 + array_length(charcters)) mod array_length(charcters);
    }

    if (keyboard_check_pressed(ord("Z"))) { // tecla de confirmar
        global.player_charcter = charcters[player_index];
        player_index = true;
    }
}