require'compe'.setup {
  autocomplete = true;
  debug = false;
  documentation = true;
  enabled = true;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  min_length = 1;
  preselect = 'enable';
  snippetSupport=true;
  source_timeout = 200;
  throttle_time = 80;

  source = {
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}
