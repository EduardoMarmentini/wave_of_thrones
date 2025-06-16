// Verifica de forma segura antes de deletar
if (variable_instance_exists(id, "fnt_title")) {
    if (fnt_title != -1) { // -1 significa fonte inválida/não carregada
        font_delete(fnt_title);
        fnt_title = -1; // Marca como já deletada
        // show_debug_message("Fonte deletada com sucesso"); // Debug opcional
    }
}
else {
    // show_debug_message("Aviso: fnt_title não existe nesta instância"); // Debug opcional
}