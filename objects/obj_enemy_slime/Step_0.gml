// Movimentação do slime (irá se mover na direção do jogador)
var distancia_x = obj_warrior.x - x;   // Diferença de posição X entre o jogador e o slime
var distancia_y = obj_warrior.y - y;   // Diferença de posição Y entre o jogador e o slime

if (vida <= 0){
	instance_destroy();
	global.kill_count += 1;
}

// Movimentação horizontal na direção do jogador
if (abs(distancia_x) > 1) {  // Se a diferença for maior que 1 pixel, o slime se move
    if (distancia_x > 0) {
        x += velocidade;    // Move para a direita
    } else {
        x -= velocidade;    // Move para a esquerda
    }
}

// Movimentação vertical (sem gravidade para o slime, ele só anda no chão)
if (place_meeting(x, y + 1, obj_ground)) {  // Verifica se está no chão
    vsp = 0;  // Não há gravidade se o slime está no chão
} else {
    vsp = 10;  // Aplica uma leve gravidade caso o slime esteja no ar
}
y += vsp;  // Aplica a movimentação vertical (gravidade)
