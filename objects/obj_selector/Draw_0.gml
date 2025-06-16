// DRAW EVENT - Selecionador de Personagem

// ============== ÁREA DE CONTROLE PRINCIPAL ==============
// POSIÇÃO GERAL DE TODOS OS ELEMENTOS
var base_x = display_get_gui_width() / 2;  // Centro horizontal
var base_y = display_get_gui_height() / 2; // Centro vertical
var offset_x = 110;     // Posição horizontal geral
var offset_y = 190;     // Posição vertical geral

// CONTROLE DE POSIÇÃO DO TEXTO (NOVO)
var texto_offset_x = -90;  // ← Controla posição horizontal dos textos (negativo = esquerda)

// CONTROLE DE TEXTO - POSICIONAMENTO VERTICAL
var texto_nome_offset_y = -10;   // Posição vertical do nome
var texto_instrucoes_offset_y = 30; // Distância entre nome e instruções
var texto_espacamento_sombra = 2;   // Tamanho da sombra

// CONTROLE DE TEXTO - APARÊNCIA
var texto_cor = c_white;  
var texto_sombra = c_black; 
var texto_tamanho = 1.5;      // Tamanho do nome
var instrucoes_tamanho = 1.0; // Tamanho das instruções
var instrucoes_cor = c_white; // Cor das instruções

// CONTROLE DA SPRITE
var largura_desejada = 200;   // Largura da sprite
var altura_desejada = 210;    // Altura da sprite
var manter_proporcao = false; // Manter proporção?
// ========================================================

// Calcula escala da sprite
var current_sprite = character_sprites[player_index];
var escala_x = largura_desejada / sprite_get_width(current_sprite);
var escala_y = altura_desejada / sprite_get_height(current_sprite);

if (manter_proporcao) {
    var escala_uniforme = min(escala_x, escala_y);
    escala_x = escala_uniforme;
    escala_y = escala_uniforme;
}

// Correção de altura para o mago
var correcao_altura = (characters[player_index] == "wizard") ? 15 : 0;

// ============== DESENHO DA SPRITE ==============
var spr_w = sprite_get_width(current_sprite) * escala_x;
var spr_h = sprite_get_height(current_sprite) * escala_y;

draw_sprite_ext(
    current_sprite,
    floor(animation_timer) mod sprite_get_number(current_sprite),
    base_x - (spr_w/2) + offset_x,
    base_y - (spr_h/2) + offset_y + correcao_altura,
    escala_x, 
    escala_y,
    0,
    c_white,
    1
);

// ============== DESENHO DOS TEXTOS ==============
draw_set_font(-1); // Fonte padrão
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Posição dos textos (com novo texto_offset_x aplicado)
var texto_x = base_x + offset_x + texto_offset_x; // ← Textos movidos para esquerda
var texto_nome_y = base_y + offset_y + (spr_h/2) + texto_nome_offset_y + correcao_altura;

// Desenha sombra do nome
draw_set_color(texto_sombra);
draw_text_transformed(texto_x + texto_espacamento_sombra, 
                     texto_nome_y + texto_espacamento_sombra, 
                     characters[player_index], 
                     texto_tamanho, texto_tamanho, 0);

// Desenha nome do personagem
draw_set_color(texto_cor);
draw_text_transformed(texto_x, texto_nome_y, characters[player_index], texto_tamanho, texto_tamanho, 0);

// Desenha instruções
var texto_instrucoes_y = texto_nome_y + texto_instrucoes_offset_y;
var instrucoes_texto = "A/D: Trocar personagem\nZ: Selecionar";

draw_set_color(texto_sombra);
draw_text_transformed(texto_x + texto_espacamento_sombra, 
                     texto_instrucoes_y + texto_espacamento_sombra, 
                     instrucoes_texto, 
                     instrucoes_tamanho, instrucoes_tamanho, 0);

draw_set_color(instrucoes_cor);
draw_text_transformed(texto_x, texto_instrucoes_y, instrucoes_texto, instrucoes_tamanho, instrucoes_tamanho, 0);

// Reseta configurações
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);