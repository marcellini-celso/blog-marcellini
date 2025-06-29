# Blog do Marcellini

Este é o repositório do meu blog pessoal, criado com [Quarto](https://quarto.org/). Aqui compartilho conteúdos sobre estatística, matemática, programação e física, com foco em explicações didáticas e exemplos práticos.

---

## 📚 Publicações em destaque

- [A Beleza é o Primeiro Teste — G. H. Hardy e a Matemática como Arte](https://marcellini-celso.github.io/blog-marcellini/posts/matematica/beleza-matematica.html)
- [Por que \( 0! = 1 \)?](https://marcellini-celso.github.io/blog-marcellini/posts/matematica/fatorial-zero.html)

---

## ⚙️ Como este blog foi feito

- Desenvolvido com [Quarto](https://quarto.org/)
- Publicado via **GitHub Pages**
- Códigos escritos em **R**, **Python** e **LaTeX**
- Tema: `flatly`, com ajustes em `styles.css`

---

## 🧭 Navegação por Tags

O blog possui um sistema automatizado para geração de páginas de tags, nuvem de palavras e navegação visual.

### Scripts mantidos

- `gerar_posts_json.py`: extrai `title`, `tags`, `href` dos posts `.qmd` e salva em `docs/posts.json`
- `nuvem_tags.py`: gera a imagem `nuvem_tags.png` com base em `tags_freq.txt`
- `atualizar_tags_completo_com_botao.sh`: script completo que:
  - Gera `tags.qmd` com visual limpo
  - Cria `tags/*.qmd` com os posts de cada tag
  - Adiciona botão de retorno para `tags.qmd` em cada página de tag
  - Gera a imagem da nuvem

### Scripts substituídos (podem ser removidos)

- `atualizar_tags.sh`
- `gerar_paginas_de_tags.py`

### Como usar

1. Gere `posts.json` com:

```bash
python3 gerar_posts_json.py
```

2. Execute o script principal:

```bash
chmod +x atualizar_tags_completo_com_botao.sh
./atualizar_tags_completo_com_botao.sh
```

3. Renderize o blog normalmente:

```bash
quarto render
```

---

## 🎨 Estilo

- CSS personalizado em: `assets/css/custom.css`
- Adicionado no `_quarto.yml`:

```yaml
format:
  html:
    css: 
      - styles.css
      - assets/css/custom.css
```

---

## 🌐 Acesse o blog

➡️ [https://marcellini-celso.github.io/blog-marcellini/](https://marcellini-celso.github.io/blog-marcellini/)

---

## 📬 Contato

Para dúvidas, sugestões ou colaborações, entre em contato por e-mail:  
✉️ **[prof.marcellini@gmail.com](mailto:prof.marcellini@gmail.com)**
