/// @description Desenho das informações da sala

var player_inst = instance_find(obj_warrior, 0);
if (!instance_exists(player_inst)) player_inst = instance_find(obj_wizard, 0);

// ========= CONFIGURAÇÕES DE LAYOUT =========

// Vidas
var life_pos_x = 30;
var life_pos_y = 650;
var life_scale = 0.2;
var life_spacing = 70;

// Skills
var skills_pos_x = display_get_gui_width() / 2;
var skills_pos_y = display_get_gui_height() - 30;
var skills_scale = 0.1;
var skills_spacing = 120;
var skills_offset_x = -60;
var skills_offset_y = -80;

// Cooldown (ajustável)
var cooldown_offset_x = 50;
var cooldown_offset_y = 50;
var cooldown_padding_x = 6;
var cooldown_padding_y = 8;

// Abates
var kills_pos_x = display_get_gui_width() - 100;
var kills_pos_y = display_get_gui_height() - 60;
var kills_icon_scale = 0.5;
var kills_icon_spacing = 20;

// ========= IMPLEMENTAÇÃO =========

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Verificação segura
if (!variable_global_exists("vida")) global.vida = 3;
if (!variable_global_exists("kill_count")) global.kill_count = 0;

// Tempo
draw_text_transformed(display_get_gui_width() / 2, 30, string(tempo div room_speed) + "s", 1.5, 1.5, 0);

// Vidas
if (sprite_exists(spr_life)) {
    for (var i = 0; i < global.vida; i++) {
        draw_sprite_ext(spr_life, 0, life_pos_x + (i * life_spacing), life_pos_y, life_scale, life_scale, 0, c_white, 1);
    }
} else {
    draw_set_halign(fa_left);
    draw_text_transformed(life_pos_x, life_pos_y, "Vida: " + string(global.vida), 1.5, 1.5, 0);
    draw_set_halign(fa_center);
}

// Skills
if (variable_global_exists("player_skills")) {
    if (is_struct(global.player_skills)) {
        var skill_keys = variable_struct_get_names(global.player_skills);
        var num_skills = array_length(skill_keys);

        if (num_skills > 0) {
            var total_width = (num_skills * skills_spacing) - skills_spacing;
            var start_x = skills_pos_x - (total_width / 2) + skills_offset_x;

            for (var i = 0; i < num_skills; i++) {
                var skill_key = skill_keys[i];
                var skill_sprite = variable_struct_get(global.player_skills, skill_key);

                if (sprite_exists(skill_sprite)) {
                    var draw_x = start_x + (i * skills_spacing);
                    var draw_y = skills_pos_y + skills_offset_y;

                    draw_sprite_ext(skill_sprite, 0, draw_x, draw_y, skills_scale, skills_scale, 0, c_white, 1);

                    var in_cooldown = false;
                    if (instance_exists(player_inst)) {
                        if (i == 0 && player_inst.cooldown_basic > 0) in_cooldown = true;
                        if (i == 1 && player_inst.cooldown_heavy > 0) in_cooldown = true;
                    }

                    if (in_cooldown) {
                        var sw = sprite_get_width(skill_sprite) * skills_scale;
                        var sh = sprite_get_height(skill_sprite) * skills_scale;

                        var sombra_x1 = draw_x - sw / 2 - cooldown_padding_x + cooldown_offset_x;
                        var sombra_y1 = draw_y - sh / 2 - cooldown_padding_y + cooldown_offset_y;
                        var sombra_x2 = draw_x + sw / 2 + cooldown_padding_x + cooldown_offset_x;
                        var sombra_y2 = draw_y + sh / 2 + cooldown_padding_y + cooldown_offset_y;

                        draw_set_alpha(0.5);
                        draw_set_color(c_black);
                        draw_rectangle(sombra_x1, sombra_y1, sombra_x2, sombra_y2, false);
                        draw_set_alpha(1);
                        draw_set_color(c_white);
                    }
                } else {
                    draw_rectangle(
                        start_x + (i * skills_spacing) - 60,
                        skills_pos_y + skills_offset_y - 60,
                        start_x + (i * skills_spacing) + 60,
                        skills_pos_y + skills_offset_y + 60,
                        false
                    );
                }
            }
        }
    }
}

// Abates
draw_set_halign(fa_right);
var abates_texto = string(global.kill_count);

if (sprite_exists(spr_kills)) {
    var icon_width = sprite_get_width(spr_kills) * kills_icon_scale;
    var text_width = string_width(abates_texto) * 1.5;

    draw_sprite_ext(
        spr_kills,
        0,
        kills_pos_x - text_width - kills_icon_spacing * 5,
        kills_pos_y - (sprite_get_height(spr_kills) * kills_icon_scale) / 2,
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

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
