-----------------------
--- Snippet File
-----------------------

local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet


ls.add_snippets("typescript", {
  s("ternary", {
    i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else")
  }),
  s("form", {
    t({
      "  form = new FormGroup({",
      "  	field1: new FormControl('', { validators: [Validators.required] }),",
      "  })",
      "",
      "  submitted = false;",
      "",
      "",
    }),
    t({
      "  get f() {",
      "    return this.form.controls;",
      "  }",
      "",
      "",
    }),
    t({
      "  onSubmit() {",
      "    this.submitted = true;",
      "    if (this.form.invalid) {",
      "      return;",
      "    }",
      "  }",
      "",
      "",
    }),
  }),
  s("debugFormState",
    fmta([[
    debugFormState() {
      const formControls = this.form.controls;
      for (const key in formControls) {
        if (formControls.hasOwnProperty(key)) {
          const control = formControls[key];
          if (control.invalid) {
            console.log(key + ' control is invalid.');
          }
          if (control.errors) {
            console.log(key + ' control has an error: ' + JSON.stringify(control.errors));
          }
        }
      }
    }
    ]], {}, {})
  )
})



ls.add_snippets("html", {
  s("form", {
    t("<form (ngSubmit)=\"onSubmit()\" [formGroup]=\"form\">"),
    t(""),
    t("</form>")
  }),
  s("field", fmt([[
  <input [ngClass]="{ 'is-invalid': submitted && f.^name$.errors }" class="form-control" formControlName="^name$" type="text" inputRef noWhitespace />
  <div *ngIf="submitted && f.^name$.errors" class="invalid-feedback">
    <div *ngIf="f.^name$.errors.required" i18n="@@idevice.validations.required">必填</div>
    <div *ngIf="f.^name$.errors.min">最小值為1</div>
    <div *ngIf="f.^name$.errors.pattern">必須是正整數</div>
  </div>
			]], {
    name = i(1, "name"),
  }, {
    delimiters = "^$",
    repeat_duplicates = true
  })),
  s("select", fmt([[
  <select (ngModelChange)="on^name2~Change($event)" class="form-control" formControlName="^name~">
    <option [ngValue]="'ALL'">全部</option>
    <option *ngFor="let opt of ^name~s" [ngValue]="opt.value">{{ opt.key }}</option>
  </select>
   ]], {
    name = i(1, "name"),
    name2 = i(2, "CaptalName")
  }, {
    delimiters = "^~",
    repeat_duplicates = true
  }))
})

ls.add_snippets("python", {
  s({ trig = "main", name = "Main gaurd.", dscr = "Python __main__ gaurd." }, {
    t({ 'if __name__ == "__main__":', "\t" }),
    c(1, {
      t(""),
      t("main()"),
    }),
  }),
  s({ trig = "def", dscr = "Create a function/method definition with standard parameters." }, {
    t({ "def " }),
    i(1, "fn_name"),
    d(2, function(_)
      -- Immediate parent must be a class definition (first method created in a class will have the current node
      -- as a class definition)
      local in_class = false
      local node = vim.treesitter.get_node()
      if node then
        in_class = node:type() == "class_definition" or node:parent():type() == "class_definition"
        if node:type() == "ERROR" then in_class = node:parent():parent():type() == "class_definition" end
      end

      local pos = vim.api.nvim_win_get_cursor(0)
      local decorator = vim.api.nvim_buf_get_lines(0, pos[1] - 3, pos[1] - 2, false)

      -- Decide default arguments based on nodes
      local arguments = "("
      if in_class then
        if string.find(decorator[1], "classmethod") then
          arguments = arguments .. "cls, "
        elseif not string.find(decorator[1], "staticmethod") then
          arguments = arguments .. "self, "
        end
      end

      return sn(nil, {
        t({ arguments }),
        i(1, ""),
        t({ ") -> " }),
      })
    end),
    i(3, "None"),
    t({ ":", "\t" }),
    i(0, "pass"),
  }),
})


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
