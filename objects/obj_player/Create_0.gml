// Inicializa variáveis básicas (opcional, mas recomendado)
hp = 100;
speed = 0;
attack = 10;

// Verifica se um personagem foi selecionado
if (variable_global_exists("player_selected_object")) 
{
    var target_obj = global.player_selected_object;
    
    // Confirma se o objeto existe antes da transformação
    if (object_exists(target_obj)) 
    {
        instance_change(target_obj, true); // Transforma o obj_player no personagem escolhido
    }
    else
    {
        show_debug_message("Erro: Objeto do personagem não existe (" + string(target_obj) + ")");
    }
}
else
{
    show_debug_message("Aviso: Nenhum personagem foi selecionado. Usando obj_player padrão.");
}