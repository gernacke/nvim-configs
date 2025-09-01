return {
  {
    "github/copilot.vim",
    cmd = "Copilot",
    lazy = false,
    config = function()
      -- Change <C-F> to accept copilot suggestion
      vim.keymap.set("i", "<C-F>", 'copilot#Accept("")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
    end,
    -- config = function()
    --   require("copilot").setup({})
    -- end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    lazy = false,
    opts = {
      model = "gpt-4.1", -- AI model to use
      temperature = 0.3, -- Lower = focused, higher = creative
      window = {
        layout = "vertical", -- 'vertical', 'horizontal', 'float'
        width = 0.55, -- 55% of screen width
      },
      highlight_headers = false,
      separator = "---",
      error_header = "> [!ERROR] Error",
      -- window = {
      --   layout = "float",
      --   relative = "cursor",
      --   width = 1,
      --   height = 0.4,
      --   row = 1,
      -- },
      auto_follow_cursor = true,
      headers = {
        user = "👤 Ger  ",
        assistant = "  Copilot",
        tool = "🔧 Tool",
      },
      -- separator = "━━",
      auto_insert_mode = false, -- Enter insert mode when opening
      prompts = {},
    },
    config = function(_, opts)
      require("CopilotChat").setup(opts)
      require("which-key").add({
        mode = { "n", "v" },
        nowait = true,
        remap = false,
        { "<leader>aa", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Chat with Copilot" },
        { "<C-g>x", "<cmd>CopilotChatFix<cr>", desc = "Copilot Chat Fix" },
      })
      -- Quick chat keybinding
      vim.keymap.set("n", "<leader>aq", function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          require("CopilotChat").ask("#buffers " .. input, {})
        end
      end, { desc = "CopilotChat - Quick chat" })
      -- Visual mode keybinding for code optimization
      vim.keymap.set("v", "<leader>ao", function()
        require("CopilotChat").ask("#selection optimize the code", {
          system_prompt = "Act as a seasoned programmer with over 20 years of commercial experience. Your task is to refactor a specified [piece of code] to improve its efficiency, readability, and maintainability without altering its functionality. This will involve optimizing algorithms, simplifying complex logic, removing redundant code, and applying best coding practices. Ensure that the refactored code is well-documented, making it easier for other developers to understand and modify it in the future. Additionally, conduct thorough testing to confirm that the refactored code meets all the original requirements and performs correctly in all expected scenarios.",
        })
      end, { desc = "CopilotChat - Optimize Code" })

      -- Visual mode keybinding for explaining code
      vim.keymap.set("v", "<leader>ae", function()
        require("CopilotChat").ask("#selection ", {
          system_prompt = "Act as a seasoned programmer with over 20 years of commercial experience. Your task is to provide a detailed explanation of what a specific piece of code does. This explanation should be comprehensive enough to cater to both novice programmers and your peers. Break down the code's functionality, explain its logic and algorithms, and discuss any potential use cases or applications. Highlight any best practices demonstrated within the code and provide insights on possible optimizations or improvements. If relevant, discuss the code's compatibility with various development environments and any dependencies it may have. Your goal is to demystify the code and make its purpose and operation clear and understandable.",
        })
      end, { desc = "CopilotChat - Explain Code" })

      -- Normal mode keybinding for generating commit message
      vim.keymap.set({ "n", "v" }, "<leader>ac", function()
        require("CopilotChat").ask("#buffer generate a commit message", {
          system_prompt = "I want you to act as a conventional commit message generator following the Conventional Commits specification. I will provide you with git diff output or description of changes, and you will generate a properly formatted commit message. The structure must be: [optional scope]: , followed by optional body and footers. Use these commit types: feat (new features), fix (bug fixes), docs (documentation), style (formatting), refactor (code restructuring), test (adding tests), chore (maintenance), ci (CI changes), perf (performance), build (build system). Include scope in parentheses when relevant (e.g., feat(api):). For breaking changes, add ! after type/scope or include BREAKING CHANGE: footer. The description should be imperative mood, lowercase, no period. Body should explain what and why, not how. Include relevant footers like Refs: #123, Reviewed-by:, etc. Do not include markdown code blocks in output. (This is just an example, make sure do not use anything from in this example in actual commit message) The output should only contains commit message and nothing more. Do not include markdown code blocks in output",
        })
      end, { desc = "CopilotChat - Git Commit Message" })

      -- Normal mode keybinding for proofreading
      vim.keymap.set({ "n", "v" }, "<leader>ap", function()
        require("CopilotChat").ask("#buffer proof read", {
          system_prompt = "I want you act as a proofreader. I would like you to review them for any spelling, logic, grammar, or punctuation errors. Suggest it with a more positive attitude/vibe. Please reply me with the suggested version only without any extra explanation.",
        })
      end, { desc = "CopilotChat - Proof Read" })

      -- Visual mode keybinding for writing tests
      vim.keymap.set({ "v" }, "<leader>at", function()
        require("CopilotChat").ask("#selection ", {
          system_prompt = "Act as a seasoned programmer with over 20 years of commercial software development experience. Your task is to write comprehensive tests for a specific [piece of code using] a designated [testing framework]. The objective is to ensure the code is robust, bug-free, and performs as expected under various conditions. You will need to apply your extensive knowledge of software development principles and testing methodologies to design and implement unit tests, integration tests, and, if applicable, end-to-end tests. Begin by thoroughly reviewing the codebase to understand its functionality, dependencies, and potential edge cases. Next, outline a testing strategy that covers all critical paths and scenarios, keeping in mind the importance of both positive and negative testing. Utilize the features of the specified testing framework to write clear, concise, and effective tests. Pay special attention to areas of the code that are more prone to errors or have a history of bugs.",
        })
      end, { desc = "CopilotChat - Write Test" })

      vim.keymap.set({ "v" }, "<leader>ad", function()
        require("CopilotChat").ask("#selection ", {
          system_prompt = "Act as a seasoned programmer with over 20 years of commercial experience. Your task is to write comprehensive documentation for a given [code]. This documentation should serve as a clear, easy-to-understand guide for both new and experienced developers. Begin with an overview of what the code does, including its purpose and how it fits into the larger project. Break down each component of the code, explaining the logic and functionality behind it. Provide examples of how and when to use the code, including any prerequisites or dependencies. Highlight any potential pitfalls or common mistakes to avoid. Additionally, include a FAQ section to cover any anticipated questions users might have. Ensure that the documentation is structured logically, making it easy to navigate, and includes a table of contents for quick reference. Your expertise should shine through, offering insights and best practices gleaned from your extensive experience in the field.",
        })
      end, { desc = "CopilotChat - Write Documentation" })
    end,
  },
}
