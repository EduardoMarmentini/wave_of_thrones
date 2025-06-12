// Movimento orbital ao redor do wizard
if (instance_exists(obj_wizard)) {
    var centro_x = obj_wizard.x;
    var centro_y = obj_wizard.y;
    
    // Calcula ângulo para o mouse
    var angulo = point_direction(centro_x, centro_y, mouse_x, mouse_y);
    
    // Limita o ângulo para evitar flips
    if (angulo > 180 && angulo < (360 - angulo_minimo)) {
        angulo = angulo_minimo;
    }
    else if (angulo <= 180) {
        angulo = clamp(angulo, angulo_minimo, angulo_maximo);
    }
    else {
        angulo = clamp(360 - angulo, angulo_minimo, angulo_maximo);
    }
    
    // Calcula posição alvo
    var alvo_x = centro_x + lengthdir_x(raio_orbita, angulo);
    var alvo_y = centro_y + lengthdir_y(raio_orbita, angulo);
    
    // Movimento suave
    if (point_distance(x, y, alvo_x, alvo_y) > 2) {
        var fator = min(velocidade_movimento, 5/point_distance(x, y, alvo_x, alvo_y));
        x = lerp(x, alvo_x, fator);
        y = lerp(y, alvo_y, fator);
    }
    
    // Rotação para mirar no mouse
    image_angle = point_direction(x, y, mouse_x, mouse_y);
    
    // Sistema de disparo com botão esquerdo do mouse
    if (disparo_cooldown > 0) {
        disparo_cooldown -= 1;
    }
    else if (mouse_check_button_pressed(mb_left)) {
        criar_fire_ball();
        disparo_cooldown = 15; // 15 frames de cooldown
    }
}

// Função para criar fireball
function criar_fire_ball() {
    var dir = point_direction(x, y, mouse_x, mouse_y);
    
    // Cria fireball ligeiramente à frente do livro
    var fb_x = x + lengthdir_x(20, dir);
    var fb_y = y + lengthdir_y(20, dir);
    
    var fire_ball = instance_create_depth(fb_x, fb_y, -1, obj_fire_ball);
    
    // Configura fireball
    fire_ball.direction = dir;
    fire_ball.speed = 8;
    fire_ball.image_angle = dir;
    
    // Efeito visual
    effect_create_above(ef_spark, x, y, 1, c_red);
    
    // Recuo
    var recuo = 3;
    x -= lengthdir_x(recuo, dir);
    y -= lengthdir_y(recuo, dir);
}