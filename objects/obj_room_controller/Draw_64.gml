// Define a cor e o alinhamento do texto
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Verifica e inicializa variáveis globais se não existirem
if (!variable_global_exists("vida")) global.vida = 100; // Valor padrão para vida
if (!variable_global_exists("kill_count")) global.kill_count = 0;

// Desenha as informações do jogo na tela com verificações seguras
draw_text(20, 20, "Tempo: " + string(tempo div room_speed) + "s"); // Tempo em segundos
draw_text(20, 40, "Pontos: " + string(pontos));                    // Pontos do jogador

// Vida com fallback seguro
var texto_vida = "Vida: " + (variable_global_exists("vida") ? string(global.vida) : "100");
draw_text(20, 60, texto_vida);

// Abates com fallback seguro
var texto_abates = "Abates: " + (variable_global_exists("kill_count") ? string(global.kill_count) : "0");
draw_text(20, 80, texto_abates);