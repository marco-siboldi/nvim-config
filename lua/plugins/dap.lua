return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")

      -- Configurar adaptador codelldb (C/C++/Rust)
      local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb"
      if vim.fn.has("win32") == 1 then
        codelldb_path = codelldb_path .. ".exe"
      end
      
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.c = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }
      dap.configurations.cpp = dap.configurations.c
      dap.configurations.rust = dap.configurations.c

      -- Configurar adaptador debugpy (Python)
      local debugpy_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      if vim.fn.has("win32") == 1 then
        debugpy_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/Scripts/python.exe"
      end
      
      dap.adapters.python = {
        type = "executable",
        command = debugpy_python,
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            -- Usar el python del venv si existe, sino buscar en PATH
            local cwd = vim.fn.getcwd()
            if vim.fn.has("win32") == 1 then
              -- Windows usa Scripts/ en vez de bin/
              if vim.fn.executable(cwd .. "/venv/Scripts/python.exe") == 1 then
                return cwd .. "/venv/Scripts/python.exe"
              elseif vim.fn.executable(cwd .. "/.venv/Scripts/python.exe") == 1 then
                return cwd .. "/.venv/Scripts/python.exe"
              end
            else
              -- Unix/Linux usa bin/
              if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                return cwd .. "/venv/bin/python"
              elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                return cwd .. "/.venv/bin/python"
              end
            end
            return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
          end,
        },
      }

      -- Configurar dap-ui
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()

      -- Auto-abrir/cerrar dap-ui
      dap.listeners.after.event_initialized["dapui_config"] = function()
        require("dapui").open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        require("dapui").close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        require("dapui").close()
      end
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
  },
}
