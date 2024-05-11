local home_directory = os.getenv("HOME")
-- The bundle_path is where PowerShell Editor Services was installed
local bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services"
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        powershell_es = {
          bundle_path = bundle_path,
          -- Format without having braces in separate lines
          settings = { powershell = { codeFormatting = { Preset = "OTBS" } } },
        },
      },
    },
  },
}
