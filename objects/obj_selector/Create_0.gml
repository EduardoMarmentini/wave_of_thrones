// Inicializa todas as variáveis primeiro
characters = ["Warrior", "Wizard"];
character_sprites = [spr_player_idle, spr_wizard_idle];
character_objects = [obj_warrior, obj_wizard];

// Adicionando as sprites de habilidades
warrior_skills = {
    basic: spr_warrior_basic_attack,
    heavy: spr_warrior_heavy_attack
};

wizard_skills = {
    basic: spr_wizard_basic_attack,
    heavy: spr_wizard_heavy_attack
};

player_index = 0;
player_confirm = false;
animation_timer = 0;

// Tratamento opcional de sons
snd_change = noone;
snd_confirm = noone;
fnt_title = -1;

try {
    snd_change = snd_menu_change;
    snd_confirm = snd_menu_confirm;
} catch(e) {
    show_debug_message("Sons não carregados: " + string(e));
}