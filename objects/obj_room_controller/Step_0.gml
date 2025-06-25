// === CONTADOR DE TEMPO TOTAL ===
tempo += 1;

// === DIMINUI INTERVALO COM O TEMPO (DIFICULDADE PROGRESSIVA) ===
if (tempo mod 600 == 0 && spawn_interval > 30) {
    spawn_interval -= 10; // A cada 10 segundos, spawn fica mais rápido
}

// === TIMER DE SPAWN ===
spawn_timer -= 1;

if (spawn_timer <= 0) {
    // Só spawnar se existir obj_warrior ou obj_wizard
    if (instance_exists(obj_warrior) || instance_exists(obj_wizard)) {
        // Escolhe tipo de inimigo aleatório: 0 = slime, 1 = morcego
        var tipo = irandom(1);

        // Posição aleatória no room
        var pos_x = irandom(room_width);
        var pos_y = irandom(room_height);

        // Spawna o inimigo escolhido
        if (tipo == 0) {
            instance_create_layer(pos_x, 380, "Instances_1", obj_enemy_slime);
        } else {
            instance_create_layer(pos_x, pos_y, "Instances_1", obj_enemy_bat);
        }
    }

    // Reinicia o timer com base no intervalo atual
    spawn_timer = spawn_interval;
}
