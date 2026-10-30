-- Mason installs language servers per-user (~/.local/share/nvim/mason), never system-wide.
-- PATH = "append": binaries from the project's devenv shell win over Mason's copies.
return {
  {
    "mason-org/mason.nvim",
    opts = {
      PATH = "append",
    },
  },
}
