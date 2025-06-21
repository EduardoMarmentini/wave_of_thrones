// ================= VERIFICAÇÃO DE VIDA =================
if (global.vida <= 0) {
    instance_destroy();
    show_message("Você morreu!");
    room_goto(select_character);
}

// ================= MOVIMENTO HORIZONTAL =================
hsp = 0;
if (keyboard_check(vk_left)) {
    hsp = -vel;
    facing = -1;
}
if (keyboard_check(vk_right)) {
    hsp = vel;
    facing = 1;
}
image_xscale = facing;

// Verificação de parede (frente)
var wall_check = 4 * facing;
if (hsp != 0 && place_meeting(x + hsp + wall_check, y, obj_wall)) {
    hsp = 0;
}

// ================= GRAVIDADE =================
vsp += grv;

// ================= PULO =================
// Só pula se estiver no chão (evita pulo duplo)
if (place_meeting(x, y + 1, obj_ground)) {
    vsp = 0;         // Para a queda ao tocar no chão
    pulando = false; // Está no chão, pode pular

    if (keyboard_check_pressed(vk_up)) {
        vsp = pulo;
        pulando = true;
    }
}

// ================= ATAQUE =================
if (keyboard_check_pressed(ord("Z")) && pode_atacar && !global.is_attacking) {
    pode_atacar = false;
    global.is_attacking = true;
    sprite_index = spr_player_attack; // Ajuste para o sprite de ataque do guerreiro
    image_index = 0;
    alarm[0] = 10; // duração do ataque (exemplo)
}

// Durante o ataque
if (global.is_attacking) {
    var slime = instance_place(x, y, obj_enemy_slime);
    if (slime != noone) slime.vida -= 1;

    var bat = instance_place(x, y, obj_enemy_bat);
    if (bat != noone) bat.vida -= 1;
} else if (!invulneravel) {
    if (place_meeting(x, y, obj_enemy_slime) || place_meeting(x, y, obj_enemy_bat)) {
        global.vida -= 1;
        invulneravel = true;
        invul_timer = room_speed * 2;
    }
}

// ================= ANIMAÇÕES =================
if (!pode_atacar) {
    // Pode adicionar animação de ataque aqui, se quiser
} else if (!place_meeting(x, y + 1, obj_ground)) {
    if (vsp < 0) {
        sprite_index = spr_player_jump;
    } else {
        sprite_index = spr_player_fall;
    }
} else if (hsp != 0) {
    sprite_index = spr_player_run;
} else {
    sprite_index = spr_player_idle;
}

// ================= MOVIMENTO FINAL =================
if (!place_meeting(x + hsp, y, obj_wall)) {
    x += hsp;
}
y += vsp;

// ================= INVULNERABILIDADE =================
if (invulneravel) {
    invul_timer--;
    image_alpha = ((invul_timer div 5) mod 2 == 0) ? 0.3 : 1;
    if (invul_timer <= 0) {
        invulneravel = false;
        image_alpha = 1;
    }
}
