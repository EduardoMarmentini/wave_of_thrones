/// @description Controle de seleção de personagem

// 1. Navegação entre personagens
if (!player_confirm) {
    var play_sound = (snd_change != noone);
    
    if (keyboard_check_pressed(ord("D"))) {
        player_index = (player_index + 1) mod array_length(characters);
        if (play_sound) audio_play_sound(snd_change, 1, false);
    }
    
    if (keyboard_check_pressed(ord("A"))) {
        player_index = (player_index - 1 + array_length(characters)) mod array_length(characters);
        if (play_sound) audio_play_sound(snd_change, 1, false);
    }

    // 2. Confirmação de seleção
    if (keyboard_check_pressed(ord("Z"))) {
        global.player_character = characters[player_index];
        global.player_object = character_objects[player_index];
        global.player_sprite = character_sprites[player_index];
        global.player_skills = (characters[player_index] == "Warrior") ? warrior_skills : wizard_skills;
        
        player_confirm = true;
        if (snd_confirm != noone) audio_play_sound(snd_confirm, 1, false);
        room_goto(Room1);
    }
}

// 3. Atualização da animação
animation_timer += 0.1;