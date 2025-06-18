// Limpeza segura dos ds_maps
if (ds_exists(warrior_skills, ds_type_map)) {
    ds_map_destroy(warrior_skills);
}

if (ds_exists(wizard_skills, ds_type_map)) {
    ds_map_destroy(wizard_skills);
}