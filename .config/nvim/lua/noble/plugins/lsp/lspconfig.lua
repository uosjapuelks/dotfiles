return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
            local cmp_nvim_lsp = require("cmp_nvim_lsp")
            local mason_lspconfig = require("mason-lspconfig")

            local capabilities = cmp_nvim_lsp.default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities.textDocument.foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true,
            }

            local servers = {
                    clangd = {
                            cmd = {
                                    "clangd",
                                    "--background-index",
                                    "--clang-tidy",
                                    "--completion-style=bundled",
                                    "--cross-file-rename",
                                    "--header-insertion=iwyu",
                            },
                    },

                    pyright = {
                            settings = {
                                    python = {
                                            analysis = {
                                                    autoSearchPaths = true,
                                                    diagnosticMode = "openFilesOnly",
                                                    useLibraryCodeForTypes = true,
                                                    reportDuplicateImport = true,
                                            },
                                    },
                            },
                    },

                    lua_ls = {
                            settings = {
                                    Lua = {
                                            runtime = { version = "LuaJIT" },
                                            diagnostics = {
                                                    globals = { "vim" },
                                            },
                                            workspace = {
                                                    checkThirdParty = false,
                                                    library = vim.api.nvim_get_runtime_file("", true),
                                            },
                                            completion = {
                                                    callSnippet = "Replace",
                                            },
                                    },
                            },
                    },
            }

            mason_lspconfig.setup({
                    ensure_installed = vim.tbl_keys(servers),
            })

            for server_name, server in pairs(servers) do
                    server.capabilities = vim.tbl_deep_extend(
                            "force",
                            {},
                            capabilities,
                            server.capabilities or {}
                    )

                    vim.lsp.config(server_name, server)
                    vim.lsp.enable(server_name)
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                    callback = function(ev)
                            local keymap = vim.keymap
                            local opts = { buffer = ev.buf, silent = true }

                            opts.desc = "Show LSP references"
                            keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

                            opts.desc = "Go to declaration"
                            keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

                            opts.desc = "Show LSP definitions"
                            keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

                            opts.desc = "Show LSP implementations"
                            keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

                            opts.desc = "Show LSP type definitions"
                            keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

                            opts.desc = "See available code actions"
                            keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

                            opts.desc = "Smart rename"
                            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

                            opts.desc = "Show buffer diagnostics"
                            keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

                            opts.desc = "Show line diagnostics"
                            keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

                            opts.desc = "Go to previous diagnostic"
                            keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

                            opts.desc = "Go to next diagnostic"
                            keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

                            opts.desc = "Show documentation for what is under cursor"
                            keymap.set("n", "K", vim.lsp.buf.hover, opts)

                            opts.desc = "Restart LSP"
                            keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
                    end,
            })
    end,
}
