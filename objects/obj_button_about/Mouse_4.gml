var info = instance_find(obj_info_box, 0);                      // Encontra a instância do objeto de informações
audio_play_sound(snd_click_button, 1, false);                   // Toca o som de clique do botão
if (info != noone) {
    info.info_text = "Desenvolvido por Luis Henrique(PM), Eduardo Marmentini(DEV), Vinicius Dalleaste(MKT)"; // Define o texto informativo
    info.visible_box = true;                                   // Torna a caixa de informação visível
}
