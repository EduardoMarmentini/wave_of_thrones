/// @description Desenho das informações da sala

// ========= CONFIGURAÇÕES DE LAYOUT =========
//
// Configurações das vidas
var life_pos_x = 30;          // Posição X inicial
var life_pos_y = 650;         // Posição Y 
var life_scale = 0.2;         // Escala dos sprites (1 = tamanho original)
var life_spacing = 70;        // Espaço entre cada vida
var max_lives = 3;            // Número máximo de vidas visíveis

// Configurações dos abates
var kills_pos_x = display_get_gui_width() - 100;  // Posição X (canto direito)
var kills_pos_y = display_get_gui_height() - 60;  // Posição Y
var kills_icon_scale = 0.5;   // Escala do ícone de abates
var kills_icon_spacing = 20;  // ← NOVO: Espaçamento entre ícone e texto (aumente para afastar)

// ========= IMPLEMENTAÇÃO =========

// 1. Configurações iniciais
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// 2. Verificação segura de variáveis
if (!variable_global_exists("vida")) global.vida = 100;
if (!variable_global_exists("kill_count")) global.kill_count = 0;

// 3. Desenho do tempo (centro superior)
var tempo_texto = string(tempo div room_speed) + "s";
draw_text(display_get_gui_width() / 2, 30, tempo_texto);

// 4. Sistema de vidas personalizável
if (sprite_exists(spr_life)) {
    var life_width = sprite_get_width(spr_life) * life_scale;
    var life_height = sprite_get_height(spr_life) * life_scale;
    
    for (var i = 0; i < max_lives; i++) {
        var vida_por_sprite = 100 / max_lives;
        var mostrar_vida = global.vida > i * vida_por_sprite;
        var frame = mostrar_vida ? 0 : 1;
        
        draw_sprite_ext(
            spr_life,
            frame,
            life_pos_x + (i * life_spacing),
            life_pos_y,
            life_scale,
            life_scale,
            0,
            c_white,
            1
        );
    }
} else {
    draw_set_halign(fa_left);
    draw_text(life_pos_x, life_pos_y, "Vida: " + string(global.vida) + "%");
    draw_set_halign(fa_center);
}

// 5. Desenho da pontuação (centro inferior)
var pontos_texto = string(pontos);
draw_text(display_get_gui_width() / 2, display_get_gui_height() - 30, pontos_texto);

// 6. Desenho dos abates com ícone (canto inferior direito)
var abates_texto = string(global.kill_count);
draw_set_halign(fa_right);

if (sprite_exists(spr_kills)) {
    var icon_width = sprite_get_width(spr_kills) * kills_icon_scale;
    var text_width = string_width(abates_texto);
    
    // Desenha o ícone com espaçamento personalizado
    draw_sprite_ext(
        spr_kills,
        0,
        kills_pos_x - text_width - kills_icon_spacing * 5, // ← Usa kills_icon_spacing aqui
        kills_pos_y - (sprite_get_height(spr_kills) * kills_icon_scale)/2,
        kills_icon_scale,
        kills_icon_scale,
        0,
        c_white,
        1
    );
    
    // Desenha o texto
    draw_text(kills_pos_x, kills_pos_y, abates_texto);
} else {
    draw_text(kills_pos_x, kills_pos_y, abates_texto);
}

// 7. Reset das configurações
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);