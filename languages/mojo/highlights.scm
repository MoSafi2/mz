; Based on Zed's highlights for Python in crates/languages/src/python/highlights.scm
; Adapted for Mojo to achieve parity with the tree-sitter-mojo grammar

(attribute attribute: (identifier) @property)
(type (identifier) @type)
(generic_type (identifier) @type)

; Mojo-specific type nodes
(mlir_type) @type.builtin
(type_parameter) @type
(union_type (type) @type)
(constrained_type (type) @type)
(member_type (type) @type)

; Type alias
(type_alias_statement "type" @keyword)

; Identifier naming conventions

((identifier) @type.class
 (#match? @type.class "^[A-Z]"))

((identifier) @constant
 (#match? @constant "^_*[A-Z][A-Z\\d_]*$"))

; TypeVar with constraints in type parameters
(type
  (tuple (identifier) @type)
)

; Function calls

(decorator
  "@" @punctuation.special
  (identifier) @function.decorator)

(call
  function: (attribute attribute: (identifier) @function.method.call))
(call
  function: (identifier) @function.call)

; Function and class definitions

(function_definition
  name: (identifier) @function.definition)

; Class definitions and calling: needs to come after the regex matching above

(class_definition
  name: (identifier) @type.class.definition)

; Traits 
(trait_definition
  name: (identifier) @type.class.definition)

(call
  function: (identifier) @type.class.call
  (#match? @type.class.call "^[A-Z][A-Z0-9_]*[a-z]"))

; Builtin functions

((call
  function: (identifier) @function.builtin)
 (#match?
   @function.builtin
   "^(abs|all|any|ascii|bin|bool|breakpoint|bytearray|bytes|callable|chr|classmethod|compile|complex|delattr|dict|dir|divmod|enumerate|eval|exec|filter|float|format|frozenset|getattr|globals|hasattr|hash|help|hex|id|input|int|isinstance|issubclass|iter|len|list|locals|map|max|memoryview|min|next|object|oct|open|ord|pow|print|property|range|repr|reversed|round|set|setattr|slice|sorted|staticmethod|str|sum|super|tuple|type|vars|zip|__import__)$"))

; Literals

[
  (none)
  (true)
  (false)
  (ellipsis)
] @constant.builtin

[
  (integer)
  (float)
] @number

; Self references and keyword identifiers

[
  (parameters (identifier) @variable.special)
  (attribute (identifier) @variable.special)
  (#match? @variable.special "^self|cls$")
]

(keyword_identifier) @variable
(argument_convention) @keyword.modifier

(comment) @comment
(string) @string
(escape_sequence) @string.escape

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

(interpolation
  "{" @punctuation.special
  "}" @punctuation.special) @embedded

; Docstrings.
(function_definition
  "async"?
  ["def" "fn"]
  name: (_)
  (parameters)?
  body: (block (expression_statement (string) @string.doc)))

(module
  (expression_statement (assignment))
  . (expression_statement (string) @string.doc))

(class_definition
  body: (block
    (expression_statement (assignment))
    . (expression_statement (string) @string.doc)))

(class_definition
  body: (block
    (function_definition
      name: (identifier) @function.method.constructor
      (#eq? @function.method.constructor "__init__")
      body: (block
        (expression_statement (assignment))
        . (expression_statement (string) @string.doc)))))


[
  "-"
  "-="
  "!="
  "*"
  "**"
  "**="
  "*="
  "/"
  "//"
  "//="
  "/="
  "@"
  "@="
  "&"
  "%"
  "%="
  "^"
  "+"
  "->"
  "+="
  "<"
  "<<"
  "<="
  "<>"
  "="
  ":="
  "=="
  ">"
  ">="
  ">>"
  "|"
  "~"
  "and"
  "in"
  "is"
  "not"
  "or"
  "is not"
  "not in"
] @operator

[
  "as"
  "assert"
  "async"
  "await"
  "borrowed"
  "break"
  "capturing"
  "case"
  "class"
  "comptime"
  "continue"
  "def"
  "deinit"
  "del"
  "elif"
  "else"
  "escaping"
  "except"
  "exec"
  "finally"
  "fn"
  "for"
  "from"
  "global"
  "if"
  "import"
  "inout"
  "lambda"
  "match"
  "mut"
  "nonlocal"
  "out"
  "owned"
  "pass"
  "print"
  "raise"
  "raises"
  "read"
  "ref"
  "return"
  "struct"
  "trait"
  "try"
  "unified"
  "var"
  "where"
  "while"
  "with"
  "__comptime_assert"
] @keyword
