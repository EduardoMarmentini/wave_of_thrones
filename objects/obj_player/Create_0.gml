// Verifica se há um objeto definido, senão usa padrão
if (!variable_global_exists("player_object")) {
    global.player_object = obj_warrior; // Objeto padrão
}

// Transforma no personagem selecionado
if (object_exists(global.player_object)) {
    instance_change(global.player_object, true);
} else {
    show_debug_message("Objeto do personagem não encontrado: " + string(global.player_object));
    instance_change(obj_warrior, true); // Fallback
}

// Atributos básicos
hp = 100;
max_hp = 100;
speed = 0;
attack = 10;