/// @description Desenho das informações da sala

// ========= CONFIGURAÇÕES DE LAYOUT =========
//
// Configurações das vidas
var life_pos_x = 30;          // Posição X inicial
var life_pos_y = 650;         // Posição Y 
var life_scale = 0.2;         // Escala dos sprites (1 = tamanho original)
var life_spacing = 70;        // Espaço entre cada vida
var max_lives = 3;            // Número máximo de vidas visíveis (3 vidas = 3 corações)

// Configurações dos abates
var kills_pos_x = display_get_gui_width() - 100;
var kills_pos_y = display_get_gui_height() - 60;
var kills_icon_scale = 0.5;
var kills_icon_spacing = 20;

// ========= IMPLEMENTAÇÃO =========

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// 2. Verificação segura de variáveis
if (!variable_global_exists("vida")) global.vida = 3;         // Agora o máximo é 3
if (!variable_global_exists("kill_count")) global.kill_count = 0;

// 3. Desenho do tempo (centro superior)
var tempo_texto = string(tempo div room_speed) + "s";
draw_text_transformed(display_get_gui_width() / 2, 30, tempo_texto, 1.5, 1.5, 0);

// 4. Sistema de vidas personalizável
if (sprite_exists(spr_life)) {
    for (var i = 0; i < global.vida; i++) {
        var frame = (global.vida > i) ? 0 : 1; // 0 = cheio, 1 = vazio

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
    draw_text_transformed(life_pos_x, life_pos_y, "Vida: " + string(global.vida), 1.5, 1.5, 0);
    draw_set_halign(fa_center);
}

// 5. Desenho da pontuação (centro inferior)
var pontos_texto = string(pontos);
draw_text_transformed(display_get_gui_width() / 2, display_get_gui_height() - 30, pontos_texto, 1.5, 1.5, 0);

// 6. Desenho dos abates com ícone (canto inferior direito)
var abates_texto = string(global.kill_count);
draw_set_halign(fa_right);

if (sprite_exists(spr_kills)) {
    var icon_width = sprite_get_width(spr_kills) * kills_icon_scale;
    var text_width = string_width(abates_texto) * 1.5; // Ajuste para escala horizontal

    draw_sprite_ext(
        spr_kills,
        0,
        kills_pos_x - text_width - kills_icon_spacing * 5,
        kills_pos_y - (sprite_get_height(spr_kills) * kills_icon_scale)/2,
        kills_icon_scale,
        kills_icon_scale,
        0,
        c_white,
        1
    );

    draw_text_transformed(kills_pos_x, kills_pos_y, abates_texto, 1.5, 1.5, 0);
} else {
    draw_text_transformed(kills_pos_x, kills_pos_y, abates_texto, 1.5, 1.5, 0);
}

// 7. Reset das configurações
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
