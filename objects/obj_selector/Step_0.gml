// STEP EVENT - Controle de seleção de personagem
if (!player_confirm) {
    // Navegação entre personagens
    var play_sound = (snd_change != noone); // Verificação segura de som
    
    if (keyboard_check_pressed(ord("D"))) {
        player_index = (player_index + 1) mod array_length(characters);
        if (play_sound) audio_play_sound(snd_change, 1, false);
    }
    
    if (keyboard_check_pressed(ord("A"))) {
        player_index = (player_index - 1 + array_length(characters)) mod array_length(characters);
        if (play_sound) audio_play_sound(snd_change, 1, false);
    }

    // Confirmação de seleção
    if (keyboard_check_pressed(ord("Z"))) {
        global.player_character = characters[player_index]; // Nome do personagem
        global.player_object = character_objects[player_index]; // Objeto do personagem
        
        // Salva as habilidades selecionadas
        global.player_skills = (characters[player_index] == "Warrior") ? warrior_skills : wizard_skills;
        
        player_confirm = true;
        if (snd_confirm != noone) audio_play_sound(snd_confirm, 1, false);
        room_goto(Room1);
    }
}

// Atualização da animação
animation_timer += 0.1;