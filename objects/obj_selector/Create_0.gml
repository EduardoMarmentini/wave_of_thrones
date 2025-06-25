/// @description Inicialização do seletor de personagens

// 1. Configuração dos personagens
characters = ["Warrior", "Wizard"];
character_sprites = [spr_player_idle, spr_wizard_idle];
character_objects = [obj_warrior, obj_wizard];

// 2. Habilidades (sprites)
warrior_skills = {
    basic: spr_warrior_basic_attack
};

wizard_skills = {
    basic: spr_wizard_basic_attack

};

// 3. Descrições das habilidades (estrutura segura)
skill_descriptions = ds_map_create();

// Warrior skills
var warrior_desc = ds_map_create();
ds_map_add(warrior_desc, "basic", {
    nome: "Corte Ascendente (Key Z)",
    desc: "Lança um ataque com sua espada e causa dano moderado"
});
ds_map_add(skill_descriptions, "Warrior", warrior_desc);

// Wizard skills
var wizard_desc = ds_map_create();
ds_map_add(wizard_desc, "basic", {
    nome: "Projétil Flamejante (Left Mouse)",
    desc: "Lança uma bola de fogo azul de seu grimório"
});

ds_map_add(skill_descriptions, "Wizard", wizard_desc);

// 4. Variáveis de controle
player_index = 0;
player_confirm = false;
animation_timer = 0;
hovered_skill = noone;
tooltip_alpha = 0;
max_tooltip_width = 300;

// 5. Configurações de áudio (com tratamento seguro)
snd_change = noone;
snd_confirm = noone;

if (variable_global_exists("snd_menu_change")) {
    snd_change = snd_menu_change;
}
if (variable_global_exists("snd_menu_confirm")) {
    snd_confirm = snd_menu_confirm;
}