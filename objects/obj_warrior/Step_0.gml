// ================= VERIFICAÇÃO DE VIDA =================
if (global.vida <= 0 && !instance_exists(obj_die_screen)) {
    var cx = 450;
    var cy = -10;
    instance_create_layer(cx, cy, "Instances_1", obj_die_screen);
    instance_destroy();
	if (instance_exists(obj_enemy_slime)) {
		instance_destroy(obj_enemy_slime)
	}
	if (instance_exists(obj_enemy_bat)) {
		instance_destroy(obj_enemy_bat)
	}
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
if (place_meeting(x, y + 1, obj_ground)) {
    vsp = 0;
    pulando = false;

    if (keyboard_check_pressed(vk_up)) {
        vsp = pulo;
        pulando = true;
    }
}

// ================= ATAQUES =================
// Ataque básico (Z)
if (keyboard_check_pressed(ord("Z")) && cooldown_basic <= 0 && pode_atacar && !global.is_attacking) {
    cooldown_basic = 0.2;
    pode_atacar = false;
    global.is_attacking = true;
    sprite_index = spr_player_attack;
    image_index = 0;
    alarm[0] = 10;
}

// Ataque pesado (X)
if (keyboard_check_pressed(ord("X")) && cooldown_heavy <= 0 && pode_atacar && !global.is_attacking) {
    cooldown_heavy = 5;
    pode_atacar = false;
    global.is_attacking = true;
    sprite_index = spr_player_attack;
    image_index = 0;
    alarm[0] = 20;
}

// Durante o ataque – aplicar dano
if (global.is_attacking) {
    var slime = instance_place(x + 16 * facing, y, obj_enemy_slime);
    if (slime != noone) slime.vida -= global.dano;

    var bat = instance_place(x + 16 * facing, y, obj_enemy_bat);
    if (bat != noone) bat.vida -= global.dano;
}

// ================= DANO DE INIMIGOS =================
if (!invulneravel) {
    var inimigo = instance_place(x, y, obj_enemy_slime);
    if (inimigo == noone) {
        inimigo = instance_place(x, y, obj_enemy_bat);
    }

    if (inimigo != noone) {
        global.vida -= 1;
        invulneravel = true;
        invul_timer = room_speed * 2;
    }
}

// ================= ANIMAÇÕES =================
if (global.is_attacking) {
    sprite_index = spr_player_attack;
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

// ================= COOLDOWN =================
if (cooldown_basic > 0) cooldown_basic -= 1 / room_speed;
if (cooldown_heavy > 0) cooldown_heavy -= 1 / room_speed;
