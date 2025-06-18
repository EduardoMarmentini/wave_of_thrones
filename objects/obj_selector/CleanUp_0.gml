/// @description Limpeza de memória

// Limpa os ds_maps de descrições
if (ds_exists(skill_descriptions, ds_type_map)) {
    var key = ds_map_find_first(skill_descriptions);
    while (!is_undefined(key)) {
        var submap = skill_descriptions[? key];
        if (ds_exists(submap, ds_type_map)) {
            ds_map_destroy(submap);
        }
        key = ds_map_find_next(skill_descriptions, key);
    }
    ds_map_destroy(skill_descriptions);
}