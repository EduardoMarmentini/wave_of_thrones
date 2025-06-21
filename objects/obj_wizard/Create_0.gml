hsp = 0;           // Velocidade horizontal (será usada no Step)
vsp = 0;           // Velocidade vertical
grv = 0.5;         // Gravidade
pulo = -10;        // Força do pulo
vel = 6;           // Velocidade de movimento
facing = 1;        // Direção inicial
pulando = false;   // Começa no chão
pode_atacar = true;
invulneravel = false;
invul_timer = 0;

book_inst = instance_create_layer(x, y, "Instances_1", obj_book);
book_inst.wizard_id = id;

global.is_attacking = false;
global.dano = 1;
global.kill_count = 0;
