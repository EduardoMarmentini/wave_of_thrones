// Controle de tempo de vida
tempo_vida -= 1;
if (tempo_vida <= 0) {
    instance_destroy();
}

// Verifica se saiu da sala (maneira correta)
if (x < -sprite_width || x > room_width + sprite_width ||
    y < -sprite_height || y > room_height + sprite_height) {
    instance_destroy();
}


