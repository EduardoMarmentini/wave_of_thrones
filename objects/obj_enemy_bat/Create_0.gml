/// @description Inicialização segura do morcego

// 1. Configurações básicas
vida = 1;
velocidade = 3;
vsp = 0;
gravidade = 0; // Morcego voa, não precisa de gravidade
direcao = 1;
alvo = noone;
distancia_perseguicao = 500;

// 2. Sistema de sprites ultra-seguro
sprite_padrao = sprite_index; // Usa o sprite atribuído ao objeto

// Verificação com proteção total
tem_sprite_voando = false;
tem_sprite_morte = false;

// Método 100% seguro para verificar sprites
if (variable_global_exists("spr_bat_fly")) {
    tem_sprite_voando = sprite_exists(spr_bat_fly);
}
if (variable_global_exists("spr_bat_death")) {
    tem_sprite_morte = sprite_exists(spr_bat_death);
}

// 3. Sistema de som seguro
tem_som_morte = false;
if (variable_global_exists("snd_enemy_death")) {
    tem_som_morte = audio_exists(snd_enemy_death);
}

// Debug opcional
show_debug_message("Sprites do morcego - Voar: "+string(tem_sprite_voando)+", Morte: "+string(tem_sprite_morte));