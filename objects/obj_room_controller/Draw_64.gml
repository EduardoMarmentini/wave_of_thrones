/// @description Desenho das informações da sala

// ========= CONFIGURAÇÕES DE LAYOUT =========
//
// Configurações das vidas
var life_pos_x = 30;          // Posição X inicial
var life_pos_y = 650;         // Posição Y 
var life_scale = 0.2;         // Escala dos sprites (1 = tamanho original)
var life_spacing = 70;        // Espaço entre cada vida
var max_lives = 3;            // Número máximo de vidas visíveis (3 vidas = 3 corações)

// Configurações das habilidades
var skills_pos_x = display_get_gui_width() / 2; // Centralizado
var skills_pos_y = display_get_gui_height() - 30; // 30px acima da base
var skills_scale = 0.1;       // Escala dos ícones
var skills_spacing = 120;      // Espaço entre habilidades
var skills_offset_x = -60;      // Ajuste fino horizontal (+/- move para os lados)
var skills_offset_y = -80;      // Ajuste fino vertical (+/- sobe/desce)

// Configurações dos abates
var kills_pos_x = display_get_gui_width() - 100; // 100px da direita
var kills_pos_y = display_get_gui_height() - 60;  // 60px da base
var kills_icon_scale = 0.5;   // Escala do ícone
var kills_icon_spacing = 20;  // Espaço entre ícone e texto

// ========= IMPLEMENTAÇÃO =========

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// 2. Verificação segura de variáveis
if (!variable_global_exists("vida")) global.vida = 3;
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

// 5. Desenho das habilidades do personagem (centro inferior) - APENAS SPRITES
if (variable_global_exists("player_skills")) {
    if (is_struct(global.player_skills)) {
        var skill_keys = variable_struct_get_names(global.player_skills);
        var num_skills = array_length(skill_keys);
        
        if (num_skills > 0) {
            var total_width = (num_skills * skills_spacing) - skills_spacing;
            var start_x = skills_pos_x - (total_width / 2) + skills_offset_x; // Aplica ajuste fino X
            
            for (var i = 0; i < num_skills; i++) {
                var skill_key = skill_keys[i];
                var skill_sprite = variable_struct_get(global.player_skills, skill_key);
                
                if (sprite_exists(skill_sprite)) {
                    draw_sprite_ext(
                        skill_sprite,
                        0,
                        start_x + (i * skills_spacing),
                        skills_pos_y + skills_offset_y, // Aplica ajuste fino Y
                        skills_scale,
                        skills_scale,
                        0,
                        c_white,
                        1
                    );
                } else {
                    // Fallback visual (retângulo)
                    draw_rectangle(
                        start_x + (i * skills_spacing) - 20,
                        skills_pos_y + skills_offset_y - 20,
                        start_x + (i * skills_spacing) + 20,
                        skills_pos_y + skills_offset_y + 20,
                        false
                    );
                }
            }
        }
    }
}
// 6. Desenho dos abates com ícone (canto inferior direito)
var abates_texto = string(global.kill_count);
draw_set_halign(fa_right);

if (sprite_exists(spr_kills)) {
    var icon_width = sprite_get_width(spr_kills) * kills_icon_scale;
    var text_width = string_width(abates_texto) * 1.5;

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