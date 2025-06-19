// Verificação de vida do jogador
if (global.vida <= 0) {
    instance_destroy();                      // Destroi o jogador
    show_message("Você morreu!");            // Exibe mensagem de morte
    room_goto(select_character);             // Volta para o menu
}

// Movimento do jogador (A e D)
hsp = 0;
if (keyboard_check(ord("A"))) {
    hsp = -vel;
    facing = -1;
}
if (keyboard_check(ord("D"))) {
    hsp = vel;
    facing = 1;
}
image_xscale = facing;

// Pulo (W)
vsp += grv;
if (place_meeting(x, y + 1, obj_ground)) {
    if (!keyboard_check(ord("W"))) {
        vsp = 0;
        pulando = false;
    }
    if (keyboard_check_pressed(ord("W"))) {
        vsp = pulo;
        pulando = true;
    }
}

// Durante o ataque
if (global.is_attacking) {
    var slime = instance_place(x, y, obj_enemy_slime);
    if (slime != noone) {
        slime.vida -= 1;
    }

    var bat = instance_place(x, y, obj_enemy_bat);
    if (bat != noone) {
        bat.vida -= 1;
    }
} else {
    // Dano se encostar em inimigo (com invulnerabilidade)
    if (!invulneravel) {
        if (place_meeting(x, y, obj_enemy_slime) || place_meeting(x, y, obj_enemy_bat)) {
            global.vida -= 1;
            invulneravel = true;
            invul_timer = room_speed * 2; // 2 segundos de invulnerabilidade
        }
    }
}

// Animações
if (!pode_atacar) {
    // Espera cooldown do ataque
} else if (!place_meeting(x, y + 1, obj_ground)) {
    if (vsp < 0) {
        sprite_index = spr_wizard_idle;
    } else {
        sprite_index = spr_wizard_idle;
    }
} else if (hsp != 0) {
    sprite_index = spr_wizard_run;
} else {
    sprite_index = spr_wizard_idle;
}

// Aplica movimento
x += hsp;
y += vsp;

// Controle de invulnerabilidade e efeito de piscar
if (invulneravel) {
    invul_timer--;

    if ((invul_timer div 5) mod 2 == 0) {
        image_alpha = 0.3;
    } else {
        image_alpha = 1;
    }

    if (invul_timer <= 0) {
        invulneravel = false;
        image_alpha = 1;
    }
}
