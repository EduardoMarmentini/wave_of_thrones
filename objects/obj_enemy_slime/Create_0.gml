/// @description Inicialização 100% segura do slime

// Configurações básicas
velocidade = 1.2;
vsp = 0;
vida = 3;
direcao = 1; // 1 = direita, -1 = esquerda

// Sistema de sprites totalmente seguro
sprite_padrao = sprite_index; // Usa o sprite atribuído ao objeto

// Verificação segura de sprites especiais
tem_sprite_pulo = (variable_instance_exists(id, "spr_slime_jump") && sprite_exists(spr_slime_jump));
tem_sprite_movimento = (variable_instance_exists(id, "spr_slime_move") && sprite_exists(spr_slime_move));

// Debug para verificar sprites
show_debug_message("Slime sprites - Pulo: "+string(tem_sprite_pulo)+", Movimento: "+string(tem_sprite_movimento));