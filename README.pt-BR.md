# TIC-80 TINY COMPUTER — Fork Lua 5.4 (PT-BR)

Leia a versão principal (em inglês): [README.md](README.md)

## Sobre este fork

Este repositório é um fork do projeto original [nesbox/TIC-80](https://github.com/nesbox/TIC-80).
Diferenças principais neste fork:

- O engine usa Lua 5.4 (Lua 5.4.6) mantendo o restante do projeto compatível.
- A biblioteca padrão `os` do Lua está habilitada (os.* disponível nos carts).
- A biblioteca padrão `io` do Lua está habilitada (io.* disponível nos carts).
- Suporte a importação de arquivos `.lua` no mesmo diretório do cart em desenvolvimento.
- Integração com LuaRocks para módulos puros em Lua, com instalação por projeto (árvore de dependências fica em `./rocks` dentro do projeto).
 - Save/load de projeto em texto (.lua e outros formatos de script) habilitado em todas as builds (não requer PRO neste fork).

## Integração com LuaRocks

Você pode usar o [LuaRocks](https://luarocks.org) para gerenciar dependências puras em Lua nos seus projetos TIC-80.

1. Crie uma árvore local dentro do projeto atual:
   ```bash
   mkdir -p rocks/share/lua/5.4
   ```
2. Instale as rocks usando o LuaRocks do sistema, apontando para `./rocks` (do projeto atual):
   ```bash
   luarocks install inspect --tree=./rocks
   ```
3. (Opcional) Copie os arquivos puros Lua do runtime do LuaRocks para ativação automática:
   - Copie o diretório `luarocks/` (módulos puros) para `rocks/share/lua/5.4/luarocks/`.
   - Quando presente, o TIC-80 tentará `require('luarocks.loader')` silenciosamente durante a inicialização da VM Lua.
4. No código do cart:
   ```lua
   local inspect = require('inspect')
   ```

Notas:
- Apenas rocks puras em Lua são suportadas (sem módulos nativos `.so` / C) para preservar o sandbox.
- Caminhos adicionados: `./?.lua`, `./?/init.lua`, `./rocks/share/lua/5.4/?.lua`, `./rocks/share/lua/5.4/?/init.lua` (sempre relativos ao diretório de trabalho/projeto atual do console).
- Se uma rock não for encontrada, o erro padrão do TIC-80 será exibido.
- Stub incluso: um `luarocks.loader` mínimo está em `vendor/luarocks_stub/` para que `require('luarocks.loader')` não falhe, mas ele NÃO implementa instalação/pesquisa.

### Projetos e instalação por projeto

Crie um projeto pelo console:

```
project <nome>
```

Isso cria e entra em `<nome>/` com a estrutura:
- `<nome>/main.lua`
- `<nome>/prepared_rocks/`
- `<nome>/rocks/share/lua/5.4/`

Tudo que você instalar via `luarocks install ...` passa a usar `./rocks` relativo ao diretório do projeto atual. Cada projeto mantém sua própria árvore de dependências e `require` funciona de forma isolada por projeto.

### LuaRocks via console do TIC-80 (Desktop)

- Requisitos:
  - `luarocks` instalado e disponível no PATH do sistema.
  - Instala na árvore do projeto atual: `./rocks`.

- Uso:
  ```
  luarocks install <pacote> [versão]
  ```

- Exemplos:
  ```
  luarocks install inspect
  luarocks install loglua 1.0-5
  ```

Após a instalação, `require('<pacote>')` já funciona no seu cart.

Fluxo web (sem CLI):
- Baixe um `.rock` e descompacte apenas `.lua` e `.rockspec` em `./prepared_rocks/<nome>/` usando o comando integrado `downloadrock`.
- Depois, rode `install <nome>` para copiar os `.lua` para `./rocks/share/lua/5.4/`.

Onde ficam as coisas:
- Árvore de instalação da CLI (projeto atual): `./rocks/share/lua/5.4/<pacote>/...`
- Diretório de staging do fluxo web: `./prepared_rocks/<pacote>/...`
- `package.path` já inclui esses caminhos automaticamente.

Limitações:
- A ponte de CLI (luarocks) é apenas para desktop. O fluxo web funciona onde o HTTP estiver habilitado.
- Apenas rocks puras em Lua são suportadas.

## Observações de segurança

- `os.*` e `io.*` estão habilitados. Isso permite operações de sistema e E/S de arquivos conforme permissões do processo. Se você quiser restringir o IO a um subdiretório (por exemplo, apenas dentro do projeto), podemos ajustar o sandbox.
- Funções como `dofile` e `loadfile` continuam bloqueadas por padrão para manter a segurança. Podemos liberar sob demanda.

## Build / Instruções gerais

Para instruções completas de build e plataformas, consulte a versão em inglês: [README.md](README.md).
