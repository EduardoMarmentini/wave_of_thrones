// No evento Draw GUI
var center_x = display_get_gui_width() / 2;
var center_y = display_get_gui_height() / 2;

// Estilo para os textos
var text_size = 32;
var text_color = c_white;
var text_alpha = 1;

// Desenha fundo semi-transparente (opcional)
draw_set_alpha(0.5);
draw_rectangle(0, center_y - 60, display_get_gui_width(), center_y + 100, false);
draw_set_alpha(1);

// Configura estilo do texto
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(text_color);

// Desenha P1 (lado esquerdo)
var p1_x = center_x - 200;
var p1_y = center_y;
draw_text(p1_x, p1_y, "P1");
draw_text(p1_x, p1_y + 50, charcters[player_index]);

