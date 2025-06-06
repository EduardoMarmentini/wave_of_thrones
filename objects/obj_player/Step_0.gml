// Verificação de vida do jogador
if (global.vida <= 0) {
    instance_destroy();                      // Destroi o jogador
    show_message("Você morreu!");            // Exibe mensagem de morte
    room_goto(menu);                         // Volta para o menu
}

// Movimento do jogador
hsp = 0;
if (keyboard_check(vk_left)) {
    hsp = -vel;                              // Move para a esquerda
    facing = -1;                             // Define direção
}
if (keyboard_check(vk_right)) {
    hsp = vel;                               // Move para a direita
    facing = 1;                              // Define direção
}
image_xscale = facing;                       // Espelha o sprite conforme a direção

// Pulo
vsp += grv;                                  // Aplica gravidade
if (place_meeting(x, y + 1, obj_ground)) {
    if (!keyboard_check(vk_up)) {
        vsp = 0;                             // Para o pulo se não estiver pressionando cima
        pulando = false;
    }
    if (keyboard_check_pressed(vk_up)) {
        vsp = pulo;                          // Realiza o pulo
        pulando = true;
    }
}

// Ataque
if (keyboard_check_pressed(ord("Z")) && pode_atacar && !global.is_attacking) {
    pode_atacar = false;
    global.is_attacking = true;
    sprite_index = spr_player_attack;        // Muda para sprite de ataque
    image_index = 0;

    alarm[0] = 10;                            // Define a duração do ataque
}

// Durante o ataque
if (global.is_attacking) {
    // Causa dano se colidir com slime
    var slime = instance_place(x, y, obj_enemy_slime);
    if (slime != noone) {
        slime.vida -= 1;
    }

    // Causa dano se colidir com morcego
    var bat = instance_place(x, y, obj_enemy_bat);
    if (bat != noone) {
        bat.vida -= 1;
    }

} else {
    // Se não estiver atacando, toma dano ao colidir com inimigos
    if (place_meeting(x, y, obj_enemy_slime) || place_meeting(x, y, obj_enemy_bat)) {
        global.vida -= 1;
    }
}

// Animações
if (!pode_atacar) {
    // Espera cooldown do ataque
} else if (!place_meeting(x, y + 1, obj_ground)) {
    if (vsp < 0) {
        sprite_index = spr_player_jump;      // Animação de pulo
    } else {
        sprite_index = spr_player_fall;      // Animação de queda
    }
} else if (hsp != 0) {
    sprite_index = spr_player_run;           // Animação de corrida
} else {
    sprite_index = spr_player_idle;          // Animação parado
}

// Movimento
x += hsp;                                     // Aplica movimento horizontal
y += vsp;                                     // Aplica movimento vertical
