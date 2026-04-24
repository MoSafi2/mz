# mz

Support for Mojo in Zed

# Highlights

Highlights based on the default for Python, with additional Mojo-specific keywords.

# LSP

Basic support for `mojo-lsp-server`.

# Development

Zed extension development expects Rust installed via `rustup`.

This repository depends on `zed_extension_api = "0.7.0"`, which requires Rust 2024 support. The repo pins Rust `1.85.0` in [rust-toolchain.toml](/home/mohamed/Documents/Projects/mz/rust-toolchain.toml:1).

# Zed settings

Zed needs to be configured to use the Mojo language server:

```json
"languages": {
    "Mojo": {
      "language_servers": ["mojo-lsp"]
    }
  },
```

And the configuration for the Mojo LSP:

```json
"lsp": {
    "mojo-lsp": {
      "binary": {
        "path": "pixi",
        "arguments": ["run", "mojo-lsp-server"]
      }
    }
  },
```
