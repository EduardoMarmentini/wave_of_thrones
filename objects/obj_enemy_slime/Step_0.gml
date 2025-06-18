/// @description Comportamento seguro do slime

// 1. Busca de alvo com verificação extrema
var alvo = noone;
if (variable_global_exists("player_object") && object_exists(global.player_object)) {
    alvo = instance_find(global.player_object, 0);
}

if (!instance_exists(alvo)) {
    // Busca alternativa por personagens
    var instancias = instance_find_all(obj_warrior);
    if (array_length(instancias) > 0) {
        alvo = instancias[0];
    } else {
        instancias = instance_find_all(obj_wizard);
        if (array_length(instancias) > 0) alvo = instancias[0];
    }
}

// 2. Movimentação segura
if (instance_exists(alvo)) {
    var distancia_x = alvo.x - x;
    var distancia_abs = abs(distancia_x);
    
    if (distancia_abs > 1) {
        // Movimento com direção
        var dir = sign(distancia_x);
        x += dir * velocidade;
        direcao = dir;
        image_xscale = direcao;
    }
}

// 3. Sistema de gravidade seguro
if (object_exists(obj_ground) && instance_exists(obj_ground)) {
    if (place_meeting(x, y + 1, obj_ground)) {
        vsp = 0;
    } else {
        vsp = min(vsp + 0.3, 8);
    }
}
y += vsp;

// 4. Animação 100% segura
if (vsp != 0 && tem_sprite_pulo) {
    sprite_index = spr_slime_jump;
} else if (velocidade != 0 && tem_sprite_movimento) {
    sprite_index = spr_slime_move;
} else {
    sprite_index = sprite_padrao;
}

// 5. Controle de morte robusto
if (vida <= 0) {
    if (variable_global_exists("kill_count")) {
        global.kill_count += 1;
    }
    instance_destroy();
}