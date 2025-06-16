// STEP EVENT
// Agora podemos verificar player_confirm com segurança
if (!player_confirm) {
    // Navegação entre personagens
    var play_sound = (snd_change != noone); // Verificação mais segura
    
    if (keyboard_check_pressed(ord("D"))) {
        player_index = (player_index + 1) mod array_length(characters);
        if (play_sound) audio_play_sound(snd_change, 1, false);
    }
    
    if (keyboard_check_pressed(ord("A"))) {
        player_index = (player_index - 1 + array_length(characters)) mod array_length(characters);
        if (play_sound) audio_play_sound(snd_change, 1, false);
    }

    if (keyboard_check_pressed(ord("Z"))) {
    global.player_character = characters[player_index]; // Nome do personagem (opcional)
    global.player_selected_object = charcter_objects[player_index]; // Objeto selecionado (obj_warrior, obj_wizard, etc.)
    
    player_confirm = true;
    if (snd_confirm != noone) audio_play_sound(snd_confirm, 1, false);
    room_goto(Room1);
}
}