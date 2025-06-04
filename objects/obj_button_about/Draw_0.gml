if (hover) {
    // Desenha o botão levemente maior quando o mouse está em cima (efeito hover)
    draw_sprite_ext(sprite_index, image_index, x, y, 1.1, 1.1, 0, c_white, 1);
} else {
    // Desenha o botão normalmente
    draw_sprite(sprite_index, image_index, x, y);
}
