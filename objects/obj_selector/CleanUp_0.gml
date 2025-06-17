// Limpeza dos maps de habilidades
for (var i = 0; i < array_length(character_system.characters); i++) {
    if (ds_exists(character_system.characters[i].skills, ds_type_map)) {
        ds_map_destroy(character_system.characters[i].skills);
    }
}