// Controle de tempo de vida
tempo_vida -= 1; // Corrigido o nome da variável (sem "d")
if (tempo_vida <= 0) {
    instance_destroy();
}

// Verifica se saiu da sala
if (x < -sprite_width || x > room_width + sprite_width ||
    y < -sprite_height || y > room_height + sprite_height) {
    instance_destroy();
}

// Movimento do projétil (adicione se necessário)
x += lengthdir_x(velocidade, image_angle);
y += lengthdir_y(velocidade, image_angle);