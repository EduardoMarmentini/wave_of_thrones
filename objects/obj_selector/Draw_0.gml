// DRAW EVENT
var base_x = display_get_gui_width() / 2;
var base_y = display_get_gui_height() / 2;

/* ************* CONTROLES DA SPRITE ************* */
var offset_x = 110;     // Posição X da sprite
var offset_y = 190;     // Posição Y da sprite
var scale = 1.5;        // Escala da sprite

// ============== CONTROLE DE TAMANHO ==============
// (Adicione esses 3 valores e ajuste como quiser)
var largura_desejada = 200;   // Largura exata que você quer para todas as sprites
var altura_desejada = 210;    // Altura exata
var manter_proporcao = false; // Se true, mantém a proporção original da sprite

// ============== CÁLCULO AUTOMÁTICO ==============
var current_sprite = character_sprites[player_index];
var escala_x = largura_desejada / sprite_get_width(current_sprite);
var escala_y = altura_desejada / sprite_get_height(current_sprite);

if (manter_proporcao) {
    // Usa a menor escala para não distorcer
    var escala_uniforme = min(escala_x, escala_y);
    escala_x = escala_uniforme;
    escala_y = escala_uniforme;
}

/* ************* CONTROLES DO TEXTO ************** */
var texto_offset_x = -90;    // Ajuste horizontal do texto
var texto_offset_y = -10;   // Ajuste vertical do texto
var texto_cor = c_white;  // Cor do texto
var texto_sombra = c_black; // Cor da sombra
var texto_espacamento_sombra = 2; // Tamanho da sombra

// ============== DESENHO DA SPRITE ==============
var current_sprite = character_sprites[player_index];
var spr_w = sprite_get_width(current_sprite) * escala_x;  // Largura escalada
var spr_h = sprite_get_height(current_sprite) * escala_y; // Altura escalada

// Correção de altura para o mago
var correcao_altura = (characters[player_index] == "wizard") ? 15 : 0;

draw_sprite_ext(
    current_sprite,
    floor(animation_timer) mod sprite_get_number(current_sprite),
    base_x - (spr_w/2) + offset_x,
    base_y - (spr_h/2) + offset_y + correcao_altura, // Aplica correção
    escala_x, 
    escala_y,
    0,
    c_white,
    1
);

// ============== TEXTO DO PERSONAGEM ==============
// Configura texto
draw_set_halign(fa_center);
draw_set_valign(fa_top);

// Posição do texto (centralizado na sprite + offsets)
var texto_x = base_x + offset_x + texto_offset_x;
var texto_y = base_y + offset_y + (spr_h/2) + texto_offset_y + correcao_altura;

// Desenha sombra
draw_set_color(texto_sombra);
draw_text(texto_x + texto_espacamento_sombra, texto_y + texto_espacamento_sombra, characters[player_index]);

// Desenha texto principal
draw_set_color(texto_cor);
draw_text(texto_x, texto_y, characters[player_index]);

// Reseta configurações
draw_set_color(c_white);
draw_set_halign(fa_left);

// DEBUG: Verifica se os nomes estão corretos
if (keyboard_check_pressed(vk_space)) {
    show_debug_message("Personagem atual: " + characters[player_index]);
    show_debug_message("Índice atual: " + string(player_index));
}