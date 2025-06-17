// ============== CONFIGURAÇÕES DE LAYOUT ==============
// (AJUSTE ESTES VALORES PARA MODIFICAR O LAYOUT)

// Posição base do menu (centro da tela)
var base_x = display_get_gui_width() / 2;
var base_y = display_get_gui_height() / 2;

// POSIÇÃO DO PERSONAGEM (valores padrão: 110, 190)
var offset_x = 50;
var offset_y = 190;

// TAMANHO DO PERSONAGEM (valores padrão: 200, 210)
var largura_desejada = 200;
var altura_desejada = 210;
var manter_proporcao = true;

// ============== INICIALIZAÇÃO DAS VARIÁVEIS ==============
// (IMPORTANTE: Esta seção deve vir antes de usar as variáveis)
var current_sprite = character_sprites[player_index];
var char_name = characters[player_index];  // DEFININDO char_name AQUI
var skills = (char_name == "Warrior") ? warrior_skills : wizard_skills;

// CORREÇÃO ESPECÍFICA PARA O MAGO (agora usando char_name já definido)
var correcao_altura = (char_name == "Wizard") ? 15 : 0;

// CONFIGURAÇÕES DOS ÍCONES DE HABILIDADE
var icon_size = 80;
var icon_spacing = 90;  
var icons_start_x = base_x + offset_x + 50;
var icons_start_y = base_y + offset_y - 200;  

// CONFIGURAÇÕES DE TEXTO
var texto_x = base_x + offset_x - 30;
var texto_nome_offset_y = -10;
var texto_instrucoes_spacing = 40;
var texto_sombra_offset = 2;

// ============== CÁLCULOS DE ESCALA ==============
var escala_x = largura_desejada / sprite_get_width(current_sprite);
var escala_y = altura_desejada / sprite_get_height(current_sprite);

if (manter_proporcao) {
    var escala_uniforme = min(escala_x, escala_y);
    escala_x = escala_uniforme;
    escala_y = escala_uniforme;
}

var spr_w = sprite_get_width(current_sprite) * escala_x;
var spr_h = sprite_get_height(current_sprite) * escala_y;
var texto_nome_y = base_y + offset_y + (spr_h/2) + texto_nome_offset_y + correcao_altura;

// ============== DESENHO DOS ELEMENTOS ==============
// 1. DESENHO DO PERSONAGEM
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

// 2. DESENHO DOS ÍCONES DE HABILIDADE (AGORA VERTICAL)
if (variable_struct_exists(skills, "basic") && skills.basic != noone) {
    var icon_scale = icon_size / sprite_get_width(skills.basic);
    draw_sprite_ext(
        skills.basic,
        0,
        icons_start_x,
        icons_start_y,  // Primeiro ícone na posição inicial
        icon_scale,
        icon_scale,
        0,
        c_white,
        1
    );
}

if (variable_struct_exists(skills, "heavy") && skills.heavy != noone) {
    var icon_scale = icon_size / sprite_get_width(skills.heavy);
    draw_sprite_ext(
        skills.heavy,
        0,
        icons_start_x,
        icons_start_y + icon_spacing,  // Segundo ícone abaixo do primeiro
        icon_scale,
        icon_scale,
        0,
        c_white,
        1
    );
}

// 3. DESENHO DOS TEXTOS
draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Texto do nome (com sombra)
draw_set_color(c_black);
draw_text(texto_x + texto_sombra_offset, texto_nome_y + texto_sombra_offset, char_name);
draw_set_color(c_white);
draw_text(texto_x, texto_nome_y, char_name);

// Texto das instruções (com sombra)
var instrucoes_y = texto_nome_y + texto_instrucoes_spacing;
draw_set_color(c_black);
draw_text(texto_x + texto_sombra_offset, instrucoes_y + texto_sombra_offset, "A/D: Trocar\nZ: Selecionar");
draw_set_color(c_white);
draw_text(texto_x, instrucoes_y, "A/D: Trocar\nZ: Selecionar");

// Reset das configurações de desenho
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);