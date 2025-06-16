// Garante que a fonte será liberada se o objeto for destruído manualmente
if (variable_instance_exists(id, "fnt_title") && fnt_title != -1) {
    font_delete(fnt_title);
}