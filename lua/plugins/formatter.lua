return
{
  "mhartington/formatter.nvim",
  config = function()
    require('formatter').setup({
      logging = false,
      filetype = {
        go = {
          function()
            return {
              exe = "gofmt",
              args = { vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
              stdin = true
            }
          end
        },
      }
    })

    vim.cmd([[
            augroup FormatAutogroup
                autocmd!
                autocmd BufWritePost *.go silent! FormatWrite
            augroup END
        ]])
  end
}
