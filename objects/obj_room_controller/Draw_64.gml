// Define a cor e o alinhamento do texto
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Desenha as informações do jogo na tela
draw_text(20, 20, "Tempo: " + string(tempo div room_speed) + "s"); // Mostra o tempo em segundos
draw_text(20, 40, "Pontos: " + string(pontos));                    // Mostra os pontos do jogador
draw_text(20, 60, "Vida: " + string(global.vida));                // Mostra a vida atual do jogador
draw_text(20, 80, "Abates: " + string(global.kill_count));        // Mostra o número de inimigos derrotados
