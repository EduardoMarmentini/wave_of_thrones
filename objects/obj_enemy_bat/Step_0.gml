/// @description Comportamento do morcego

// 1. Busca de alvo com verificação extrema
if (!instance_exists(alvo)) {
    // Tenta pelo objeto global primeiro
    if (variable_global_exists("player_object") && object_exists(global.player_object)) {
        alvo = instance_find(global.player_object, 0);
    }
    
    // Busca alternativa se não encontrou
    if (!instance_exists(alvo)) {
        var instancias = instance_find_all(obj_warrior);
        if (array_length(instancias) > 0) {
            alvo = instancias[0];
        } else {
            instancias = instance_find_all(obj_wizard);
            if (array_length(instancias) > 0) alvo = instancias[0];
        }
    }
}

// 2. Movimentação segura
if (instance_exists(alvo)) {
    var dist_x = alvo.x - x;
    var dist_y = alvo.y - y;
    var dist_total = point_distance(x, y, alvo.x, alvo.y);
    
    if (dist_total < distancia_perseguicao) {
        // Movimento suavizado
        x += (dist_x / max(1, dist_total)) * velocidade;
        y += (dist_y / max(1, dist_total)) * velocidade;
        
        // Direção do sprite
        image_xscale = sign(dist_x);
    }
}

// 3. Animação segura
if (tem_sprite_voando) {
    sprite_index = spr_bat_fly;
    image_speed = 0.15 + (velocidade * 0.03);
} else {
    sprite_index = sprite_padrao;
    image_speed = 0.1;
}

// 4. Sistema de morte robusto
if (vida <= 0) {
    if (tem_sprite_morte) {
        sprite_index = spr_bat_death;
        image_speed = 0.25;
    }
    
    if (!tem_sprite_morte || image_index >= sprite_get_number(sprite_index)-1) {
        if (variable_global_exists("kill_count")) {
            global.kill_count += 1;
            if (tem_som_morte) audio_play_sound(snd_enemy_death, 1, false);
        }
        instance_destroy();
    }
    exit;
}