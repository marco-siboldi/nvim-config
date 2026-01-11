return {
  -- Plugin principal de DAP
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI mejorado para DAP
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- Dependencia de dap-ui
      
      -- Texto virtual para mostrar valores de variables
      "theHamsta/nvim-dap-virtual-text",
      
      -- Instalador de adaptadores vía Mason
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Configurar dap-ui
      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            size = 40,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      -- Configurar texto virtual
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = true,
        show_stop_reason = true,
        commented = false,
      })

      -- Abrir/cerrar dap-ui automáticamente
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Configuración para C/C++ con codelldb
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          -- Intenta encontrar codelldb en Mason, con fallback a PATH
          command = (function()
            local codelldb_path = vim.fn.exepath("codelldb")
            return codelldb_path ~= "" and codelldb_path
              or vim.fn.stdpath("data") .. "/mason/bin/codelldb"
          end)(),
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
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
      -- Compartir la configuración para C y C++
      dap.configurations.c = dap.configurations.cpp

      -- Configuración para Python con debugpy
      dap.adapters.python = function(callback, config)
        -- Intenta encontrar el adaptador de debugpy en Mason
        local mason_registry_ok, mason_registry = pcall(require, "mason-registry")
        if mason_registry_ok and mason_registry.is_installed("debugpy") then
          local debugpy_pkg = mason_registry.get_package("debugpy")
          local debugpy_path = debugpy_pkg:get_install_path() .. "/venv/bin/python"
          callback({
            type = "executable",
            command = debugpy_path,
            args = { "-m", "debugpy.adapter" },
          })
        else
          -- Fallback: busca debugpy en PATH
          callback({
            type = "executable",
            command = "python3",
            args = { "-m", "debugpy.adapter" },
          })
        end
      end

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            -- Intenta usar el entorno virtual si existe
            local venv = os.getenv("VIRTUAL_ENV")
            if venv then
              return venv .. "/bin/python"
            end
            -- Intenta encontrar python3 en PATH
            local python3_path = vim.fn.exepath("python3")
            if python3_path ~= "" then
              return python3_path
            end
            local python_path = vim.fn.exepath("python")
            if python_path ~= "" then
              return python_path
            end
            -- Fallback para sistemas Unix
            return "/usr/bin/python3"
          end,
        },
      }

      -- Iconos para signos de breakpoints
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "◎", texthl = "DapLogPoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

      -- Keymaps para DAP
      local map = vim.keymap.set
      map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
      map("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
      map("n", "<leader>di", dap.step_into, { desc = "DAP: Step into" })
      map("n", "<leader>do", dap.step_over, { desc = "DAP: Step over" })
      map("n", "<leader>dO", dap.step_out, { desc = "DAP: Step out" })
      map("n", "<leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
      map("n", "<leader>dl", dap.run_last, { desc = "DAP: Run last" })
      map("n", "<leader>dt", dap.terminate, { desc = "DAP: Terminate" })
      map("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
    end,
  },

  -- Instalador de adaptadores de debug vía Mason
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      ensure_installed = {
        "codelldb",  -- Para C/C++
        "debugpy",   -- Para Python
      },
      automatic_installation = true,
      handlers = {},
    },
  },
}
