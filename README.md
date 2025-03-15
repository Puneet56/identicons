# Identicons

Code to generate [Identicons](https://en.wikipedia.org/wiki/Identicon)

[Some patching required](https://elixirforum.com/t/error-when-rendring-in-egd-undefinedfunctionerror-function-zlib-crc32-2-is-undefined-or-private/66639/3)

## Usage

```bash
iex -S iex

iex(1)> Identicons.main("<username>")

# output will be saved as <username>.png
```
