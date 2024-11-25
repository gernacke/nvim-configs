-- local home = vim.fn.expand("$HOME")
local wk = require("which-key")
return {
  "robitx/gp.nvim",
  lazy = false,
  config = function()
    local conf = {
      openai_api_key = { "cat", "/Users/ger/Documents/recovery_codes/openai_api_key" },
      -- default command agents (model + persona)
      -- name, model and system_prompt are mandatory fields
      -- to use agent for chat set chat = true, for command set command = true
      -- to remove some default agent completely set it like:
      -- agents = {  { name = "ChatGPT3-5", disable = true, }, ... },
      agents = {
        { name = "ChatGPT3-5", disable = true },
        { name = "ChatGPT4o", disable = true },
        {
          name = "ChatGPT4o-mini",
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = require("gp.defaults").chat_system_prompt,
        },
        {
          name = "Virtualised-Terminal",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "I want you to act as a linux terminal. I will type commands and you will reply with what the terminal should show. I want you to only reply with the terminal output inside one unique code block, and nothing else. do not write explanations. do not type commands unless I instruct you to do so. When I need to tell you something in English, I will do so by putting text inside curly brackets {like this}. My first command is pwd",
        },
        {
          name = "Linux-Commands",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "I want you to act as a senior Linux Administrator. I will ask you with the task I want to do, you just reply me with the suggested code in block. No explanation. When I need it, I will ask for it.",
        },
        {
          name = "Proof-reader",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "I want you act as a proofreader. I would like you to review them for any spelling, logic, grammar, or punctuation errors. Suggest it with a more positive attitude/vibe. Please reply me with the suggested version only without anything else.",
        },
        {
          name = "Senior-Programmer",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "I want you to act as a senior programmer. I will provide you with snippets of code, and your task will be to review the code for best practices, better readability, consider to make it more ergonomical, and identify any potential bugs or inefficiencies, and reply me with the suggested code in block. Explain with the minimal number of words possible for the changes. Point out the changes with the minimum number of words.",
        },
        {
          name = "Translator",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "You are a Translator, please translate between English and Chinese. Please reply with the opposite translation only.",
        },
        {
          name = "Holiday-Guide",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "I want you to act as a travel guide. I will write you my location and you will suggest some places to visit near my location. In some cases, I will also give you the type of places I will visit. You will also suggest me places of similar type that are close to my first location.",
        },
        {
          name = "Personal-Trainer",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "I want you to act as a personal trainer. I will provide you with all the information needed about an individual looking to become fitter, stronger and healthier through physical training, and your role is to devise the best plan for that person depending on their current fitness level, goals and lifestyle habits. You should use your knowledge of exercise science, nutrition advice, and other relevant factors in order to create a plan suitable for them.",
        },
        {
          name = "Chef",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "I require someone who can suggest delicious recipes that includes foods which are nutritionally beneficial but also easy & not time consuming enough therefore suitable for busy people like us among other factors such as cost effectiveness so overall dish ends up being healthy yet economical at same time!",
        },
        {
          name = "Prompt-Generator",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "I want you to act as a prompt generator. Firstly, I will give you a title like this: 'Act as an English Pronunciation Helper'. Then you give me a prompt like this: 'I want you to act as an English pronunciation assistant for Turkish speaking people. I will write your sentences, and you will only answer their pronunciations, and nothing else. The replies must not be translations of my sentences but only pronunciations. Pronunciations should use Turkish Latin letters for phonetics. Do not write explanations on replies. My first sentence is 'how the weather is in Istanbul?'.' (You should adapt the sample prompt according to the title I gave. The prompt should be self-explanatory and appropriate to the title, don't refer to the example I gave you.). My first title is 'Act as a Code Review Helper' (Give me prompt only)",
        },
        {
          name = "Prompt-Enhancer",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "Act as a Prompt Enhancer AI that takes user-input prompts and transforms them into more engaging, detailed, and thought-provoking questions. Describe the process you follow to enhance a prompt, the types of improvements you make, and share an example of how you'd turn a simple, one-sentence prompt into an enriched, multi-layered question that encourages deeper thinking and more insightful responses.",
        },
        {
          name = "SQL-Terminal",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "I want you to act as a SQL terminal in front of an example database. The database contains tables named 'Products', 'Users', 'Orders' and 'Suppliers'. I will type queries and you will reply with what the terminal would show. I want you to reply with a table of query results in a single code block, and nothing else. Do not write explanations. Do not type commands unless I instruct you to do so. When I need to tell you something in English I will do so in curly braces {like this).",
        },
        {
          name = "Tech-Reviwer",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "I want you to act as a tech reviewer. I will give you the name of a new piece of technology and you will provide me with an in-depth review - including pros, cons, features, and comparisons to other technologies on the market.",
        },
        {
          name = "Machine-Learning-Engineer",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "I want you to act as a machine learning engineer. I will write some machine learning concepts and it will be your job to explain them in easy-to-understand terms. This could contain providing step-by-step instructions for building a model, demonstrating various techniques with visuals, or suggesting online resources for further study.",
        },
        {
          name = "Git-Commit-Generator",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "I want you to act as a commit message generator. I will provide you with information about the task and the prefix for the task code, and I would like you to generate an appropriate commit message using the conventional commit format. Reply with the commit message only, do not explain.",
        },
        {
          name = "Documentation-Generator",
          chat = true,
          command = false,
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          system_prompt = "I want you to act as a documentation comment generator for code snippets. I will provide you with a piece of code, and you will generate concise and clear documentation comments that describe the purpose of the code. Ensure that the comments are easy to understand and follow best practices for documentation. My first code snippet is: [SELECT @id = IIF(@id = 0, ISNULL(MAX(StaffID), 0), @id) FROM vStaff s].",
        },
        {
          name = "Git-Advisor",
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "I want you to act as a Git commands advisor for an intermediate user. I will ask you about specific Git commands, and you will provide a very brief explanation of what each command does. Please keep the explanations concise and focus only on the command itself without any extensive details. My first command is `git diff`",
        },
        {
          name = "auto-completion",
          chat = true,
          command = false,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4o-mini", temperature = 1.1, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "I want you to act as an auto completion agent. I will provide you with snippets of code, and you will try to complete the code by following the conventions and styles evident in my provided snippets at the place where I have inserted 'xxx'. Please ensure your suggestions align with the programming language and structure I use. My first code snippet is: def calculate_sum(a, b):",
        },
      },
      hooks = {
        UnitTests = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
            .. "Please respond by writing unit tests for the code above."
          local agent = gp.get_command_agent()
          gp.Prompt(params, gp.Target.vnew, agent, template)
        end,
        Explain = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
            .. "Please respond by concisely explaining the code above."
          local agent = gp.get_chat_agent("ChatGPT4o-mini")
          gp.Prompt(params, gp.Target.vnew, agent, template)
        end,
        Documentation = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
          local agent = gp.get_chat_agent("Documentation-Generator")
          gp.Prompt(params, gp.Target.vnew("markdown"), agent, template)
        end,
        AutoComplete = function(gp, params)
          local template = "{{selection}}\n\n"
          local agent = gp.get_chat_agent("auto-completion")
          gp.Prompt(params, gp.Target.append, agent, template)
        end,
        GitCommitAppend = function(gp, params)
          local template = "{{selection}}\n\n"
          local agent = gp.get_chat_agent("Git-Commit-Generator")
          gp.Prompt(params, gp.Target.append, agent, template)
        end,
        GitCommitBuffer = function(gp, params)
          local template = "{{selection}}\n\n"
          local agent = gp.get_chat_agent("Git-Commit-Generator")
          gp.Prompt(params, gp.Target.vnew, agent, template)
        end,
        CodeReview = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
          local agent = gp.get_chat_agent("Senior-Programmer")
          gp.Prompt(params, gp.Target.vnew("markdown"), agent, template)
        end,
        Translator = function(gp, params)
          local template = "I have the following code from {{filename}}:\n\n"
            .. "```{{filetype}}\n{{selection}}\n```\n\n"
          local agent = gp.get_chat_agent("Translator")
          gp.Prompt(params, gp.Target.vnew, agent, template)
        end,
        ProofRead = function(gp, params)
          local template = "I have the writing from {{filename}}:\n\n" .. "```{{filetype}}\n{{selection}}\n```\n\n"
          local agent = gp.get_chat_agent("Proof-reader")
          gp.Prompt(params, gp.Target.vnew, agent, template)
        end,
      },
    }
    require("gp").setup(conf)
    require("which-key").add({
      -- VISUAL mode mappings
      -- s, x, v modes are handled the same way by which_key
      {
        mode = { "v" },
        nowait = true,
        remap = false,
        { "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", desc = "ChatNew tabnew" },
        { "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = "ChatNew vsplit" },
        { "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", desc = "ChatNew split" },
        { "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", desc = "Visual Append (after)" },
        { "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", desc = "Visual Prepend (before)" },
        { "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", desc = "Visual Chat New" },
        { "<C-g>g", group = "generate into new .." },
        { "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", desc = "Visual GpEnew" },
        { "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", desc = "Visual GpNew" },
        { "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", desc = "Visual Popup" },
        { "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", desc = "Visual GpTabnew" },
        { "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", desc = "Visual GpVnew" },
        { "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", desc = "Implement selection" },
        { "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
        { "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", desc = "Visual Chat Paste" },
        { "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", desc = "Visual Rewrite" },
        { "<C-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
        { "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", desc = "Visual Toggle Chat" },
        { "<C-g>h", group = "Preset Prompts" },
        { "<C-g>hc", ":<C-u>'<,'>GpCodeReview<cr>", desc = "Code Review" },
        { "<C-g>hd", ":<C-u>'<,'>GpDocumentation<cr>", desc = "Generate Documentation" },
        { "<C-g>hg", ":<C-u>'<,'>GpGitCommitAppend<cr>", desc = "Git Commit Message" },
        { "<C-g>hp", ":<C-u>'<,'>GpAutoComplete<cr>", desc = "Auto Complete Code" },
        { "<C-g>hr", ":<C-u>'<,'>GpProofRead<cr>", desc = "Proof Read" },
        { "<C-g>ht", ":<C-u>'<,'>GpTranslator<cr>", desc = "Translate" },
        { "<C-g>hu", ":<C-u>'<,'>GpUnitTests<cr>", desc = "Unit Tests" },
        { "<C-g>hx", ":<C-u>'<,'>GpExplain<cr>", desc = "Explain" },
        { "<C-g>w", group = "Whisper" },
        { "<C-g>wa", ":<C-u>'<,'>GpWhisperAppend<cr>", desc = "Whisper Append" },
        { "<C-g>wb", ":<C-u>'<,'>GpWhisperPrepend<cr>", desc = "Whisper Prepend" },
        { "<C-g>we", ":<C-u>'<,'>GpWhisperEnew<cr>", desc = "Whisper Enew" },
        { "<C-g>wn", ":<C-u>'<,'>GpWhisperNew<cr>", desc = "Whisper New" },
        { "<C-g>wp", ":<C-u>'<,'>GpWhisperPopup<cr>", desc = "Whisper Popup" },
        { "<C-g>wr", ":<C-u>'<,'>GpWhisperRewrite<cr>", desc = "Whisper Rewrite" },
        { "<C-g>wt", ":<C-u>'<,'>GpWhisperTabnew<cr>", desc = "Whisper Tabnew" },
        { "<C-g>wv", ":<C-u>'<,'>GpWhisperVnew<cr>", desc = "Whisper Vnew" },
        { "<C-g>ww", ":<C-u>'<,'>GpWhisper<cr>", desc = "Whisper" },
        { "<C-g>x", ":<C-u>'<,'>GpContext<cr>", desc = "Visual GpContext" },
      },

      -- NORMAL mode mappings
      {
        mode = { "n" },
        nowait = true,
        remap = false,
        { "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "New Chat tabnew" },
        { "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat vsplit" },
        { "<C-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "New Chat split" },
        { "<C-g>a", "<cmd>GpAppend<cr>", desc = "Append (after)" },
        { "<C-g>b", "<cmd>GpPrepend<cr>", desc = "Prepend (before)" },
        { "<C-g>c", "<cmd>GpChatNew<cr>", desc = "New Chat" },
        { "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
        { "<C-g>r", "<cmd>GpRewrite<cr>", desc = "Inline Rewrite" },
        { "<C-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
        { "<C-g>t", "<cmd>GpChatToggle<cr>", desc = "Toggle Chat" },
        { "<C-g>x", "<cmd>GpContext<cr>", desc = "Toggle GpContext" },
        { "<C-g>p", ":<CMD>GpChatNew popup<cr>", desc = "New Chat Popup" },
        { "<C-g>g", group = "generate into new .." },
        { "<C-g>ge", "<cmd>GpEnew<cr>", desc = "GpEnew" },
        { "<C-g>gn", "<cmd>GpNew<cr>", desc = "GpNew" },
        { "<C-g>gp", "<cmd>GpPopup<cr>", desc = "Popup" },
        { "<C-g>gt", "<cmd>GpTabnew<cr>", desc = "GpTabnew" },
        { "<C-g>gv", "<cmd>GpVnew<cr>", desc = "GpVnew" },
        { "<C-g>h", group = "Preset Prompts .." },
        { "<C-g>hg", ":%GpGitCommitBuffer<CR>", desc = "Git Commit Message" },
        { "<C-g>hr", ":%GpProofRead<CR>", desc = "Proof Read Buffer" },
        { "<C-g>w", group = "Whisper" },
        { "<C-g>wa", "<cmd>GpWhisperAppend<cr>", desc = "Whisper Append (after)" },
        { "<C-g>wb", "<cmd>GpWhisperPrepend<cr>", desc = "Whisper Prepend (before)" },
        { "<C-g>we", "<cmd>GpWhisperEnew<cr>", desc = "Whisper Enew" },
        { "<C-g>wn", "<cmd>GpWhisperNew<cr>", desc = "Whisper New" },
        { "<C-g>wp", "<cmd>GpWhisperPopup<cr>", desc = "Whisper Popup" },
        { "<C-g>wr", "<cmd>GpWhisperRewrite<cr>", desc = "Whisper Inline Rewrite" },
        { "<C-g>wt", "<cmd>GpWhisperTabnew<cr>", desc = "Whisper Tabnew" },
        { "<C-g>wv", "<cmd>GpWhisperVnew<cr>", desc = "Whisper Vnew" },
        { "<C-g>ww", "<cmd>GpWhisper<cr>", desc = "Whisper" },
        { "<leader>sg", "<cmd>GpChatFinder<cr>", desc = "Chat Finder" },
      },

      -- INSERT mode mappings
      {
        mode = { "i" },
        nowait = true,
        remap = false,
        { "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "New Chat tabnew" },
        { "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat vsplit" },
        { "<C-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "New Chat split" },
        { "<C-g>a", "<cmd>GpAppend<cr>", desc = "Append (after)" },
        { "<C-g>b", "<cmd>GpPrepend<cr>", desc = "Prepend (before)" },
        { "<C-g>c", "<cmd>GpChatNew<cr>", desc = "New Chat" },
        { "<C-g>f", "<cmd>GpChatFinder<cr>", desc = "Chat Finder" },
        { "<C-g>g", group = "generate into new .." },
        { "<C-g>ge", "<cmd>GpEnew<cr>", desc = "GpEnew" },
        { "<C-g>gn", "<cmd>GpNew<cr>", desc = "GpNew" },
        { "<C-g>gp", "<cmd>GpPopup<cr>", desc = "Popup" },
        { "<C-g>gt", "<cmd>GpTabnew<cr>", desc = "GpTabnew" },
        { "<C-g>gv", "<cmd>GpVnew<cr>", desc = "GpVnew" },
        { "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
        { "<C-g>r", "<cmd>GpRewrite<cr>", desc = "Inline Rewrite" },
        { "<C-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
        { "<C-g>t", "<cmd>GpChatToggle<cr>", desc = "Toggle Chat" },
        { "<C-g>w", group = "Whisper" },
        { "<C-g>wa", "<cmd>GpWhisperAppend<cr>", desc = "Whisper Append (after)" },
        { "<C-g>wb", "<cmd>GpWhisperPrepend<cr>", desc = "Whisper Prepend (before)" },
        { "<C-g>we", "<cmd>GpWhisperEnew<cr>", desc = "Whisper Enew" },
        { "<C-g>wn", "<cmd>GpWhisperNew<cr>", desc = "Whisper New" },
        { "<C-g>wp", "<cmd>GpWhisperPopup<cr>", desc = "Whisper Popup" },
        { "<C-g>wr", "<cmd>GpWhisperRewrite<cr>", desc = "Whisper Inline Rewrite" },
        { "<C-g>wt", "<cmd>GpWhisperTabnew<cr>", desc = "Whisper Tabnew" },
        { "<C-g>wv", "<cmd>GpWhisperVnew<cr>", desc = "Whisper Vnew" },
        { "<C-g>ww", "<cmd>GpWhisper<cr>", desc = "Whisper" },
        { "<C-g>x", "<cmd>GpContext<cr>", desc = "Toggle GpContext" },
      },
    })
  end,
}
