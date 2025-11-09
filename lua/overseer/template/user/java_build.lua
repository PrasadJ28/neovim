return {
  name = "Java: Detect and Run",

  builder = function()
     local file = vim.fn.expand("%:p")
      return {
        command = "java",
        args = { file },
        cwd = cwd,
      }
  end,

  condition = {
    filetype = { "java" }
  },

}

