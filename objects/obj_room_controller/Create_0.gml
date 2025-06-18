/// @description Inicialização à prova de erros

global.vidas = 3;
global.vida = 100;
global.kill_count = 0;
global.pontos = 0;
global.tempo = 0;

// Tempo do jogo
tempo = 0;

// Sistema de spawn
spawn_interval = 120;
spawn_timer = spawn_interval;

// Sistema de sprites
tem_sprite_vida = false;
tem_sprite_kills = false;

// Tenta detectar os sprites sem gerar erros
try {
    if (sprite_exists(spr_life)) {
        tem_sprite_vida = true;
    }
} catch (e) {
    show_debug_message("Aviso: Sprite de vida não encontrado");
}

try {
    if (sprite_exists(spr_kills)) {
        tem_sprite_kills = true;
    }
} catch (e) {
    show_debug_message("Aviso: Sprite de kills não encontrado");
}

// Inicializa os pontos
pontos = 0;