// === CONTADOR DE TEMPO TOTAL ===
tempo += 1;

// === DIMINUI INTERVALO COM O TEMPO (DIFICULDADE PROGRESSIVA) ===
if (tempo mod 600 == 0 && spawn_interval > 30) {
    spawn_interval -= 10; // A cada 10 segundos, spawn fica mais rápido
}

// === TIMER DE SPAWN ===
spawn_timer -= 1;

// Aumenta pontos ao longo do tempo
if (tempo mod 30 == 0) { // A cada meio segundo
    pontos += 1;
}


if (spawn_timer <= 0) {
    // Escolhe tipo de inimigo aleatório: 0 = slime, 1 = morcego
    var tipo = irandom(1);

    // Posição aleatória no room
    var pos_x = irandom(room_width);
    var pos_y = irandom(room_height);

    // Spawna o inimigo escolhido
    if (tipo == 0) {
        instance_create_layer(pos_x, 380, "Instances", obj_enemy_slime);
    } else {
        instance_create_layer(pos_x, pos_y, "Instances", obj_enemy_bat);
    }

    // Reinicia o timer com base no intervalo atual
    spawn_timer = spawn_interval;
}
