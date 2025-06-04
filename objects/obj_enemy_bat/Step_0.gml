// Movimentação do morcego em direção ao jogador (livremente em X e Y)
var distancia_x = obj_player.x - x;   // Diferença de posição X entre o jogador e o morcego
var distancia_y = obj_player.y - y;   // Diferença de posição Y entre o jogador e o morcego

if (vida <= 0){
	instance_destroy();
	global.kill_count += 1;
}

// Movimentação horizontal do morcego (movimento livre em X)
if (abs(distancia_x) > 1) {  // Se a diferença de X for maior que 1 pixel, move na direção do jogador
    if (distancia_x > 0) {
        x += velocidade;    // Move para a direita
    } else {
        x -= velocidade;    // Move para a esquerda
    }
}

// Movimentação vertical do morcego (movimento livre em Y)
if (abs(distancia_y) > 1) {  // Se a diferença de Y for maior que 1 pixel, move na direção do jogador
    if (distancia_y > 0) {
        y += velocidade;    // Move para baixo
    } else {
        y -= velocidade;    // Move para cima
    }
}
