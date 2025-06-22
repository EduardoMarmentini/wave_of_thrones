hsp = 0;           // Velocidade horizontal
vsp = 0;           // Velocidade vertical
grv = 0.5;         // Gravidade
pulo = -10;        // Força do pulo
vel = 6;           // Velocidade de movimento do jogador
facing = 1;        // define o lado que o jogador olha
pulando = false;   // Flag para saber se o jogador está pulando
pode_atacar = true;  // Flag para controlar se o jogador pode atacar
invulneravel = false;
invul_timer = 0;

cooldown_basic = 0;
cooldown_heavy = 0;

global.is_attacking = false;
global.dano = 1;   // Dano do jogador
global.kill_count = 0; // Quantos mobs matou
