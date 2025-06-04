audio_play_sound(snd_music_background, 1, true); // Toca a música de fundo em loop
if (!instance_exists(obj_info_box)) {
    instance_create_layer(0, 0, "Instances", obj_info_box); // Cria a caixa de informação se ela ainda não existir
}
