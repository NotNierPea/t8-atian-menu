init_menus() {
    self add_menu("tool_menu", "Tools", "start_menu", true);
    self add_menu_item_modswitch("tool_menu", "Fly", "fly");
}
