/// @description Desenho do menu de seleção

// 1. Configurações de layout
var base_x = display_get_gui_width() / 2;
var base_y = display_get_gui_height() / 2;
var offset_x = 50;
var offset_y = 190;

// 2. Obtenção das variáveis atuais
var current_sprite = character_sprites[player_index];
var char_name = characters[player_index];
var skills = (char_name == "Warrior") ? warrior_skills : wizard_skills;
var correcao_altura = (char_name == "Wizard") ? 15 : 0;

// 3. Cálculos de tamanho
var escala_x = 200 / sprite_get_width(current_sprite);
var escala_y = 210 / sprite_get_height(current_sprite);
var escala_uniforme = min(escala_x, escala_y);
var spr_w = sprite_get_width(current_sprite) * escala_uniforme;
var spr_h = sprite_get_height(current_sprite) * escala_uniforme;

// 4. Desenho do personagem
draw_sprite_ext(
    current_sprite,
    floor(animation_timer) mod sprite_get_number(current_sprite),
    base_x - (spr_w/2) + offset_x,
    base_y - (spr_h/2) + offset_y + correcao_altura,
    escala_uniforme, 
    escala_uniforme,
    0,
    c_white,
    1
);

// 5. Desenho dos ícones de habilidades
var icon_size = 80;
var icon_spacing = 90;
var icons_start_x = base_x + offset_x + 50;
var icons_start_y = base_y + offset_y - 200;

hovered_skill = noone;

// Ícone básico
if (variable_struct_exists(skills, "basic") && skills.basic != noone) {
    var icon_scale = icon_size / sprite_get_width(skills.basic);
    var icon_x = icons_start_x;
    var icon_y = icons_start_y;
    
    // Verificação de mouse sobre o ícone
    if (point_in_circle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 
                       icon_x, icon_y, icon_size/2)) {
        hovered_skill = "basic";
        tooltip_alpha = min(tooltip_alpha + 0.1, 1);
    }
    
    draw_sprite_ext(
        skills.basic,
        0,
        icon_x,
        icon_y,
        icon_scale,
        icon_scale,
        0,
        c_white,
        1
    );
}

// Ícone heavy
if (variable_struct_exists(skills, "heavy") && skills.heavy != noone) {
    var icon_scale = icon_size / sprite_get_width(skills.heavy);
    var icon_x = icons_start_x;
    var icon_y = icons_start_y + icon_spacing;
    
    if (point_in_circle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 
                       icon_x, icon_y, icon_size/2)) {
        hovered_skill = "heavy";
        tooltip_alpha = min(tooltip_alpha + 0.1, 1);
    }
    
    draw_sprite_ext(
        skills.heavy,
        0,
        icon_x,
        icon_y,
        icon_scale,
        icon_scale,
        0,
        c_white,
        1
    );
}

// 6. Tooltips (versão corrigida)
if (hovered_skill != noone && tooltip_alpha > 0 && ds_map_exists(skill_descriptions, char_name)) {
    var class_skills = skill_descriptions[? char_name];
    
    if (ds_map_exists(class_skills, hovered_skill)) {
        var desc = class_skills[? hovered_skill];
        var text = desc.nome + "\n" + desc.desc;
        
        // Configurações do tooltip
        draw_set_font(-1);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_alpha(tooltip_alpha);
        
        // Fundo (versão retangular simples)
        var text_w = string_width_ext(text, -1, max_tooltip_width);
        var text_h = string_height_ext(text, -1, max_tooltip_width);
        var tooltip_x = device_mouse_x_to_gui(0) + 20;
        var tooltip_y = device_mouse_y_to_gui(0);
        
        draw_set_color(make_color_rgb(30, 30, 40));
        draw_rectangle(tooltip_x - 10, tooltip_y - 10, 
                      tooltip_x + text_w + 10, 
                      tooltip_y + text_h + 10, false);
        
        // Texto
        draw_set_color(c_white);
        draw_text_ext(tooltip_x, tooltip_y, text, -1, max_tooltip_width);
        
        // Reset
        draw_set_alpha(1);
    }
} else {
    tooltip_alpha = max(tooltip_alpha - 0.05, 0);
}

// 7. Textos do menu
var texto_x = base_x + offset_x - 30;
var texto_nome_y = base_y + offset_y + (spr_h/2) - 10 + correcao_altura;

draw_set_font(-1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Nome do personagem
draw_set_color(c_black);
draw_text(texto_x + 2, texto_nome_y + 2, char_name);
draw_set_color(c_white);
draw_text(texto_x, texto_nome_y, char_name);

// Instruções
var instrucoes_y = texto_nome_y + 40;
draw_set_color(c_black);
draw_text(texto_x + 2, instrucoes_y + 2, "A/D: Trocar\nZ: Selecionar");
draw_set_color(c_white);
draw_text(texto_x, instrucoes_y, "A/D: Trocar\nZ: Selecionar");

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);