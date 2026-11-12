import re, sys, os

DECL = re.compile(r"^(?:@\[[^\n]*\]\s*)?(?:private\s+|protected\s+|noncomputable\s+|partial\s+|nonrec\s+)*"
                  r"(?:theorem|lemma|def|abbrev|structure|class|inductive|instance|opaque)\s+"
                  r"([A-Za-z_][A-Za-z0-9_.'!?]*)", re.M)
IMPORT = re.compile(r"^import\s+Definitions\.(Def_\w+)", re.M)

def decls(path):
    try:
        txt = open(path, encoding="utf-8").read()
    except OSError:
        return set()
    out = set()
    for m in DECL.finditer(txt):
        n = m.group(1).split(".")[-1]
        out.add(n)
    return out

def main(targets):
    for ch in targets:
        src = f"Definitions/Def_{ch}.lean"
        txt = open(src, encoding="utf-8").read()
        body = IMPORT.sub("", txt)
        toks = set(re.findall(r"[A-Za-z_][A-Za-z0-9_']*", body))
        missing = {}
        for mod in sorted(set(IMPORT.findall(txt))):
            ws = f"Definitions/{mod}.lean"
            pub = f"state/published_bundles/{mod}.lean"
            if not os.path.exists(pub):
                continue
            ws_d = decls(ws)
            pub_d = decls(pub)
            for name in ws_d - pub_d:
                if name in toks:
                    missing.setdefault(name, []).append(mod)
        print(f"== {ch}: {len(missing)} used-but-unpublished decl(s)")
        for name, mods in sorted(missing.items()):
            print(f"   {name:42s} ws-only in {', '.join(mods)}")

if __name__ == "__main__":
    main(sys.argv[1:])
