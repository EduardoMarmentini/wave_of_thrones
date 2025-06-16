// CREATE EVENT
// Inicializa todas as variáveis primeiro
characters = ["Warrior", "Wizard"];
character_sprites = [spr_player_idle, spr_wizard_idle]; // Certifique-se que estas sprites existem
charcter_objects = [obj_warrior, obj_wizard]

player_index = 0;
player_confirm = false; // INICIALIZE A VARIÁVEL AQUI
animation_timer = 0;

// Tratamento opcional de sons
snd_change = noone; // Valor inicial
snd_confirm = noone;

// Inicializa a fonte (se necessário)
fnt_title = -1; // Valor inicial padrão

try {
    snd_change = snd_menu_change;
    snd_confirm = snd_menu_confirm;
}
catch(e) {
    show_debug_message("Sons não carregados: " + string(e));
}