# AI tools

A portable collection of coding-agent skills for Codex, OpenCode, and Claude
Code.

The canonical skill files live in `.agents/skills`. OpenCode and Codex discover
that directory directly. `.claude/skills` contains relative symbolic links to
the same files, because Claude Code uses its own project directory. This means
that after cloning this repository and starting an agent from its root, no
installation step is required.

## Included workflows

- `grill-with-docs` -> `to-spec` -> `to-tickets` -> `implement` ->
  `thermo-nuclear-code-quality-review` -> `improve-codebase-architecture`
- `diagnosing-bugs`
- `improve-codebase-architecture`
- `thermo-nuclear-code-quality-review`
- `improve` (the shadcn plan-first audit workflow)
- Supporting skills required by those workflows

A reusable [AGENTS.md template](templates/AGENTS.md) makes the six-stage flow
the default in another repository. Copy it to that repository's root:

```bash
cp /path/to/ai-tools/templates/AGENTS.md /path/to/your-project/AGENTS.md
```

Merge it with an existing `AGENTS.md` rather than replacing project-specific
build commands, conventions, or safety rules.

Run `setup-matt-pocock-skills` once in each codebase where you use Matt
Pocock's workflow. It asks where project documentation and tickets should go.

Invocation syntax varies by client/version. Claude Code exposes project skills
as `/skill-name`. In Codex and OpenCode, select the named skill from the skill
picker/tool or mention it explicitly (for example, `$diagnosing-bugs`) if slash
completion does not list it.

## Use these skills in other repositories

Project-level discovery only applies while an agent is working inside this
repository. To make this checkout the shared source for every repository on a
machine, run:

```bash
./scripts/install-global-links.sh
```

The script creates per-skill symbolic links in:

- `~/.codex/skills` for Codex
- `~/.agents/skills` for OpenCode
- `~/.claude/skills` for Claude Code

It never replaces an existing file or link. Resolve any reported name conflict
manually, then restart the relevant client. Because these are links, a later
`git pull` updates all three clients from this single checkout.

## Machine-level tools

RTK, Ponytail's lifecycle hooks, and the Caveman proxy are executable tools or
plugins, not ordinary portable skills. They are intentionally not vendored
here. Review and install those separately on a work machine only if company
policy permits them. `reference-repo.txt` keeps the research links and upstream
ideas.

## Updating vendored skills

The files are intentionally committed so a checkout is reproducible and does
not download executable instructions at agent startup. Review upstream changes
before copying them here, especially permissions, hooks, scripts, and tool
allowlists.
