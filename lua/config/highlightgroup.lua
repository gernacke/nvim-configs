local M = {}

local api = vim.api
local hl_mappings = {
  ["SagaWinbarFile"] = { fg = "#eeac50" },
  ["SagaWinbarModule"] = { fg = "#CFD8DC" },
  ["SagaWinbarNamespace"] = { fg = "#60b5cc" },
  ["SagaWinbarPackage"] = { fg = "#FF9800" },
  ["SagaWinbarClass"] = { fg = "#D67E00" },
  ["SagaWinbarMethod"] = { fg = "#652D90" },
  ["SagaWinbarProperty"] = { fg = "#428ff5" },
  ["SagaWinbarField"] = { fg = "#007ACC" },
  ["SagaWinbarConstructor"] = { fg = "#fce444" },
  ["SagaWinbarEnum"] = { fg = "#D67E00" },
  ["SagaWinbarInterface"] = { fg = "#007ACC" },
  ["SagaWinbarFunction"] = { fg = "#E51400" },
  ["SagaWinbarVariable"] = { fg = "#007ACC" },
  ["SagaWinbarConstant"] = { fg = "#044c84" },
  ["SagaWinbarString"] = { fg = "#1e7a29" },
  ["SagaWinbarNumber"] = { fg = "#1e7a29" },
  ["SagaWinbarBoolean"] = { fg = "#cfba95" },
  ["SagaWinbarArray"] = { fg = "#58897b" },
  ["SagaWinbarObject"] = { fg = "#a6d1ca" },
  ["SagaWinbarKey"] = { fg = "#045594" },
  ["SagaWinbarNull"] = { fg = "#F07178" },
  ["SagaWinbarEnumMember"] = { fg = "#007ACC" },
  ["SagaWinbarStruct"] = { fg = "#424242" },
  ["SagaWinbarEvent"] = { fg = "#D67E00" },
  ["SagaWinbarOperator"] = { fg = "#414141" },
  ["SagaWinbarTypeParameter"] = { fg = "#F57C00" },
  ["SagaWinbarSep"] = { fg = "#FFAB91" },
  ["IlluminatedWordText"] = { link = "CursorLine" },
  ["IlluminatedWordRead"] = { link = "CursorLine" },
  ["IlluminatedWordWrite"] = { link = "CursorLine" },

  -- VSCODE Codicon icon themes
  -- light blue
  ["CmpItemKindVariable"] = { bg = "NONE", fg = "#9CDCFE" },
  ["CmpItemKindInterface"] = { link = "CmpItemKindVariable" },
  ["CmpItemKindText"] = { link = "CmpItemKindVariable" },
  -- pink
  ["CmpItemKindFunction"] = { bg = "NONE", fg = "#C586C0" },
  ["CmpItemKindMethod"] = { link = "CmpItemKindFunction" },
  -- front
  ["CmpItemKindKeyword"] = { bg = "NONE", fg = "#D4D4D4" },
  ["CmpItemKindProperty"] = { link = "CmpItemKindKeyword" },
  ["CmpItemKindUnit"] = { link = "CmpItemKindKeyword" },
  -- gray
  ["CmpItemAbbrDeprecated"] = { bg = "NONE", strikethrough = true, fg = "#808080" },
  -- blue
  ["CmpItemAbbrMatch"] = { bg = "NONE", fg = "#569CD6" },
  ["cmpItemAbbrMatchFuzzy"] = { link = "CmpItemAbbrMatch" },
}

function M.set_hl()
  for k, v in pairs(hl_mappings) do
    api.nvim_set_hl(0, k, v)
  end
end

M.set_hl()
