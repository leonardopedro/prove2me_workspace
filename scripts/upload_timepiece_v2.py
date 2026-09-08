#!/usr/bin/env python3
"""
Upload timepiece theorems to Prove2me - v2.
Based on the working v3 approach: extract theorem/lemma lines with 500 chars of context.

Usage:
    python3 scripts/upload_timepiece_v2.py --dry-run    # preview
    python3 scripts/upload_timepiece_v2.py --limit 10    # test
    python3 scripts/upload_timepiece_v2.py             # full
"""

import json
import os
import re
import subprocess
import sys
import time
from pathlib import Path

# Configuration
API_BASE = "https://prove2.me/api/v1"
PROJECT_ROOT = Path("/home/leo/Projects/timepiece")
WORKSPACE_ROOT = Path("/home/leo/prove2me_workspace")

# Default prefixes to scan
DEFAULT_PREFIXES = ["BookProof", "UsedRoute", "UnusedRoute", "RandomMap"]

# QYM (Quantum Yang-Mills) related keywords
QYM_KEYWORDS = [
    "yqm", "qym", "yang", "mills", "mass_gap", "massgap", "ghost", "brst",
    "sirk", "quantum", "chromo", "gauge", "fock", "scalaron", "starobinsky",
    "navier", "stokes", "einstein", "hilbert", "spacetime", "metric", "riemann",
    "band", "enclosure", "dyson", "schwinger", "lagrangian", "hamiltonian",
    "unitary", "hermitian", "spectral", "fermi", "boson", "fermion", "ghost",
    "auxiliary", "gauge_fixing", "constraint", "physical", "ghost_sector",
    "causal", "causality", "locality", "unitarity", "renormalization",
    "counterterm", "regularization", "cutoff", "scale", "mass", "gap",
    "positive_definite", "positivity", "pos_semidef", "coercivity", "continuity",
    "differentiability", "holomorphic", "analytic", "meromorphic", "resolvent",
    "spectral_theorem", "spectral", "bounded_below", "stability", "self_adjoint",
    "ess_sup", "essentially_self_adjoint", "essentially", "symmetric",
    "closed_operator", "operator_core", "core", "dense", "unbounded_operator",
    "form", "sesquilinear", "quadratic_form",
]

# File state cache
STATE_FILE = Path("/home/leo/prove2me_workspace/state/state.json")
LOG_FILE = Path("/home/leo/prove2me_workspace/state/upload.log")
NAMES_CACHE = Path("/home/leo/prove2me_workspace/state/names_cache.txt")


def get_api_key():
    """Get API key from environment or workspace credentials."""
    key = os.environ.get("PROVE2ME_API_KEY")
    if key:
        return key
    creds_path = WORKSPACE_ROOT / "credentials.json"
    if creds_path.exists():
        with open(creds_path) as f:
            creds = json.load(f)
        return creds.get("api_key")
    return None


def get_access_token():
    """Get or refresh access token."""
    token = os.environ.get("PROVE2ME_TOKEN")
    if token:
        return token
    
    api_key = get_api_key()
    if not api_key:
        print("ERROR: No API key found", file=sys.stderr)
        return None
    
    # Refresh token
    url = f"{API_BASE}/agent/refresh"
    data = json.dumps({"api_key": api_key})
    r = subprocess.run(
        ["curl", "-s", "-X", "POST", url,
         "-H", "Content-Type: application/json",
         "-d", data],
        capture_output=True, text=True, timeout=30
    )
    result = json.loads(r.stdout)
    if "access_token" in result:
        os.environ["PROVE2ME_TOKEN"] = result["access_token"]
        return result["access_token"]
    print(f"ERROR: Failed to get token: {result.get('error', 'unknown')}", file=sys.stderr)
    return None


def api_call(method, endpoint, data=None, params=None):
    """Make an authenticated API call."""
    token = get_access_token()
    if not token:
        return None
    
    url = f"{API_BASE}/{endpoint}"
    
    if params:
        url += "?" + "&".join(f"{k}={v}" for k, v in params.items())
    
    if method.upper() == "GET":
        r = subprocess.run(["curl", "-s", url, "-H", f"Authorization: Bearer {token}"],
                           capture_output=True, text=True, timeout=30)
    else:
        r = subprocess.run(["curl", "-s", "-X", method.upper(), url,
                            "-H", f"Authorization: Bearer {token}",
                            "-H", "Content-Type: application/json",
                            "-d", json.dumps(data) if data else "{}"],
                           capture_output=True, text=True, timeout=60)
    
    try:
        return json.loads(r.stdout)
    except ValueError:
        return None


def is_qym(name):
    """Check if a theorem name is QYM-related."""
    name_lower = name.lower()
    for kw in QYM_KEYWORDS:
        if kw in name_lower:
            return True
    return False


def lean_check(statement):
    """Compile-check a statement with the project toolchain. Returns (ok, err)."""
    import tempfile
    try:
        with tempfile.NamedTemporaryFile("w", suffix=".lean", delete=False, dir="/tmp") as f:
            f.write(statement)
            path = f.name
        try:
            import shutil
            lake = shutil.which("lake") or "/etc/profiles/per-user/leo/bin/lake"
            r = subprocess.run([lake, "env", "lean", path],
                               cwd="/home/leo/Projects/timepiece",
                               capture_output=True, text=True, timeout=180)
            return r.returncode == 0, (r.stderr or r.stdout)[:400]
        except subprocess.TimeoutExpired:
            return False, "lean check timeout"
        finally:
            os.unlink(path)
    except Exception as e:
        return False, f"lean check error: {e}"


def extract_theorem_statement(filepath, name):
    """
    Extract a COMPILABLE statement: file imports + namespaces + the full
    declaration up to its proof start (:= by). Validated with the local Lean
    toolchain; returns (None, None) if it cannot be made to compile.
    """
    try:
        with open(filepath, encoding="utf-8") as f:
            lines = f.read().split("\n")
    except Exception as e:
        print(f"  WARNING: Could not read {filepath}: {e}", file=sys.stderr)
        return None, None

    decl_re = re.compile(r"^\s*(?:(?:protected|private|unsafe|noncomputable|partial)\s+)*(theorem|lemma)\s+" + re.escape(name) + r"\b")
    decl_idx = None
    for i, line in enumerate(lines):
        if decl_re.match(line):
            decl_idx = i
            break
    if decl_idx is None:
        return None, None

    # Docstring directly above the declaration
    docstring = ""
    j = decl_idx - 1
    if j >= 0 and lines[j].strip().endswith("-/"):
        k = j
        while k >= 0 and not lines[k].strip().startswith("/--"):
            k -= 1
        if k >= 0:
            docstring = "\n".join(l.strip() for l in lines[k:j+1])
            docstring = docstring.replace("/--", "").replace("-/", "").strip()

    # Whole-file prefix: everything from the top through the target statement.
    # Compiles for the same reason the project does, and carries all in-file
    # definitions (Band etc.) the statement may reference.
    stmt_body_lines = [lines[decl_idx].rstrip()]
    found = None
    for line in lines[decl_idx + 1 : decl_idx + 400]:
        stmt_body_lines.append(line.rstrip())
        if re.search(r":=\s*by\b", "\n".join(stmt_body_lines)):
            found = True
            break
    if not found:
        return None, None
    stmt_body = "\n".join(stmt_body_lines)
    stmt_body = re.sub(r":=\s*by\b.*$", " := by sorry", stmt_body, flags=re.S)

    # Scope tracking: strip Lean modifiers before matching namespace/section.
    def scope_open(st):
        st2 = re.sub(r"^(noncomputable|private|protected|unsafe)\s+", "", st)
        return st2.startswith("namespace ") or st2.startswith("section ")

    def scope_name(st):
        st2 = re.sub(r"^(noncomputable|private|protected|unsafe)\s+", "", st)
        return st2.split(None, 1)[1].strip() if len(st2.split(None, 1)) > 1 else ""

    def skip_line(st):
        # returns state string: "block", "comment", "code"
        if skip_line.in_block:
            if st.endswith("-/") or st == "-/":
                skip_line.in_block = False
            return "block"
        if st.startswith("/-"):
            if not (st.endswith("-/") or st == "-/"):
                skip_line.in_block = True
            return "block"
        if st.startswith("--"):
            return "comment"
        return "code"

    # Scopes open at the declaration point.
    ns_stack = []
    skip_line.in_block = False
    for line in lines[:decl_idx]:
        st = line.strip()
        state = skip_line(st)
        if state != "code":
            continue
        if scope_open(st):
            ns_stack.append(scope_name(st))
        elif re.match(r"^end\b", st) and ns_stack:
            ns_stack.pop()

    prefix = "\n".join(lines[:decl_idx]).rstrip()

    # Closes: reuse the file's OWN `end` lines (verbatim, correct names,
    # handles noncomputable/private sections and bare ends) until the scopes
    # open at the declaration point are drained.
    closes_lines = []
    stack2 = list(ns_stack)
    skip_line.in_block = False
    for line in lines[decl_idx + len(stmt_body_lines):]:
        st = line.strip()
        state = skip_line(st)
        if state != "code":
            continue
        if re.match(r"^end\b", st):
            if not stack2:
                break
            closes_lines.append(line.rstrip())
            stack2.pop()
        elif scope_open(st):
            stack2.append(scope_name(st))
    closes = "\n".join(closes_lines)
    statement = prefix + "\n" + stmt_body + ("\n" + closes if closes else "") + "\n"


    ok, err = lean_check(statement)
    if not ok:
        print(f"  SKIP: does not compile locally: {err[:120]}", file=sys.stderr)
        return None, None
    return statement, docstring


def load_existing_names(cache_file):
    """Load previously uploaded theorem names."""
    existing = set()
    if cache_file.exists():
        with open(cache_file) as f:
            for line in f:
                name = line.strip()
                if name:
                    existing.add(name)
    return existing


def save_existing_names(cache_file, names):
    """Save uploaded theorem names."""
    with open(cache_file, 'w') as f:
        for name in sorted(names):
            f.write(name + "\n")


def load_state(state_file):
    """Load upload state."""
    if state_file.exists():
        with open(state_file) as f:
            return json.load(f)
    return {"next_index": 0, "total": 0, "ok": 0, "fail": 0, "rejected": {}, "attempts": {}}


def save_state(state_file, state):
    """Save upload state."""
    with open(state_file, 'w') as f:
        json.dump(state, f)


def submit_theorem(prefix, name, statement, docstring):
    """
    Submit a single theorem to prove2me.
    Returns (success, result_dict).
    """
    clean_docstring = docstring
    clean_docstring = clean_docstring.replace('/--', '').replace('-/', '').strip()

    title = name.replace("_", " ").title()

    tags = ["timepiece", "auto-upload", "v4-28-to-v4-33"]
    if is_qym(name):
        tags.append("qym")

    data = {
        "theorem_name": name,
        "theorem_title": title,
        "formal_statement": statement,
        "natural_language_statement": clean_docstring or f"Formal statement of {name}.",
        "description": f"From timepiece project: {prefix}.{name}",
        "tags": tags,
    }

    result = api_call("POST", "submit-problem", data)

    if result is None:
        return False, {"error": "API call failed"}

    if "jobs" in result and result["jobs"]:
        job_id = result["jobs"][0].get("job_id")
        if not job_id:
            return False, result

        # Poll for completion (path-param endpoint)
        for _ in range(60):
            time.sleep(2)
            poll = api_call("GET", f"publish-jobs/{job_id}", None)
            if poll is None:
                continue

            status = poll.get("status", "")
            if status == "PUBLISHED":
                return True, {"theorem_id": poll.get("theorem_id"), "status": "PUBLISHED"}
            elif status in ("FAILED", "ERROR"):
                return False, poll
            elif not status and (poll.get("kind") == "problem" or ("theorem_name" in poll and "formal_statement" in poll)):
                # Completed job returns the published problem object (no status field)
                return True, {"theorem_id": poll.get("id"), "status": "PUBLISHED"}

        return False, {"error": "Poll timeout"}

    return False, result


def scan_project(prefixes):
    """Scan the project for all theorems/lemmas."""
    print("Scanning project for theorems...", file=sys.stderr)
    
    theorems = []
    for prefix in prefixes:
        dirpath = PROJECT_ROOT / prefix
        if not dirpath.exists():
            print(f"  WARNING: Directory {dirpath} does not exist", file=sys.stderr)
            continue
        
        for filepath in sorted(dirpath.glob("*.lean")):
            try:
                with open(filepath, encoding="utf-8") as f:
                    content = f.read()
            except:
                continue
            
            for m in re.finditer(r'^(theorem|lemma)\s+(\S+)', content, re.MULTILINE):
                name = m.group(2)
                line_start = content.rfind('\n', 0, m.start()) + 1
                line_end = content.find('\n', m.end())
                line = content[line_start:line_end]
                if 'sorry' in line:
                    continue
                theorems.append((prefix, name, str(filepath)))
    
    # Sort: QYM first, then by name
    theorems.sort(key=lambda x: (0 if is_qym(x[1]) else 1, x[1]))
    
    qym_count = sum(1 for t in theorems if is_qym(t[1]))
    print(f"Found {len(theorems)} theorems ({qym_count} QYM)", file=sys.stderr)
    
    return theorems


def main():
    import argparse
    
    parser = argparse.ArgumentParser(description="Upload timepiece theorems to Prove2me")
    parser.add_argument("--dry-run", action="store_true", help="Preview without submitting")
    parser.add_argument("--limit", type=int, help="Limit number of theorems to process")
    parser.add_argument("--resume", action="store_true", help="Resume from last state")
    parser.add_argument("--prefixes", nargs="+", default=DEFAULT_PREFIXES, help="Prefixes to scan")
    
    args = parser.parse_args()
    
    # Load state
    state = load_state(STATE_FILE)
    existing_names = load_existing_names(NAMES_CACHE)
    
    # Scan project
    theorems = scan_project(args.prefixes)
    
    # Skip already uploaded
    new_theorems = []
    rejected = state.get("rejected", {})
    for prefix, name, filepath in theorems:
        if name not in existing_names and name not in rejected:
            new_theorems.append((prefix, name, filepath))
        else:
            print(f"  SKIP (already uploaded): {prefix}.{name}", file=sys.stderr)
    
    print(f"New theorems to process: {len(new_theorems)}", file=sys.stderr)
    
    if args.dry_run:
        print("\nDRY RUN - would process the following:", file=sys.stderr)
        for prefix, name, filepath in new_theorems[:20]:
            print(f"  {prefix}.{name}", file=sys.stderr)
        if len(new_theorems) > 20:
            print(f"  ... and {len(new_theorems) - 20} more", file=sys.stderr)
        return
    
    # Process
    start_idx = 0  # resume = skip via existing_names + rejected (robust to list changes)
    ok = state.get("ok", 0)
    fail = state.get("fail", 0)
    skip = 0
    
    rejected = state.get("rejected", {})
    attempts = state.get("attempts", {})
    PERMANENT_HINTS = ("must be", "valid", "invalid", "exist", "duplicate", "identifier")
    if rejected:
        print(f"  {len(rejected)} previously rejected/skipped names", file=sys.stderr)

    for i, (prefix, name, filepath) in enumerate(new_theorems):
        tag = " [QYM]" if is_qym(name) else ""

        if name in rejected:
            skip += 1
            continue

        print(f"\n[{i+1}/{len(new_theorems)}] {prefix}.{name}{tag}", file=sys.stderr)

        try:
            statement, docstring = extract_theorem_statement(filepath, name)
            if statement is None:
                print("  SKIP: Could not extract statement", file=sys.stderr)
                rejected[name] = "extraction failed"
                skip += 1
            else:
                success, result = submit_theorem(prefix, name, statement, docstring)
                if success:
                    theorem_id = result.get("theorem_id", "unknown")
                    existing_names.add(name)
                    print(f"  OK -> {theorem_id}", file=sys.stderr)
                    with open(LOG_FILE, 'a') as f:
                        f.write(f"OK: {prefix}.{name} -> {theorem_id}{tag}\n")
                    ok += 1
                else:
                    error = str(result.get("error", result))
                    print(f"  FAIL: {error[:100]}", file=sys.stderr)
                    with open(LOG_FILE, 'a') as f:
                        f.write(f"FAIL: {prefix}.{name} - {error[:200]}{tag}\n")
                    low = error.lower()
                    if "401" in error or "403" in error:
                        print("  ERROR: Authentication failed. Stopping.", file=sys.stderr)
                        break
                    elif any(h in low for h in PERMANENT_HINTS):
                        rejected[name] = error[:200]
                        skip += 1
                        print("  -> rejected permanently", file=sys.stderr)
                    else:
                        attempts[name] = attempts.get(name, 0) + 1
                        if attempts[name] >= 5:
                            rejected[name] = f"gave up after 5 attempts: {error[:150]}"
                            skip += 1
                            print("  -> gave up after 5 attempts", file=sys.stderr)
                        else:
                            fail += 1
        except Exception as e:
            print(f"  ERROR: {type(e).__name__}: {e}", file=sys.stderr)
            with open(LOG_FILE, 'a') as f:
                f.write(f"ERROR: {prefix}.{name} - {type(e).__name__}: {e}{tag}\n")
            attempts[name] = attempts.get(name, 0) + 1

        # Persist after EVERY item: a crash/reboot loses at most one in-flight upload
        save_state(STATE_FILE, {**state, "next_index": i + 1, "ok": ok, "fail": fail,
                                "rejected": rejected, "attempts": attempts})
        save_existing_names(NAMES_CACHE, existing_names)

    # Final state
    final_state = {**state, "next_index": len(new_theorems), "total": len(theorems),
                   "ok": ok, "fail": fail, "rejected": rejected, "attempts": attempts}
    save_state(STATE_FILE, final_state)
    save_existing_names(NAMES_CACHE, existing_names)

    with open(LOG_FILE, 'a') as f:
        f.write(f"DONE: {ok} ok, {fail} fail, {skip} skip out of {len(new_theorems)} total\n")

    print(f"\nSUMMARY: {ok} ok, {fail} fail, {skip} skip out of {len(new_theorems)} total", file=sys.stderr)

    pending = sum(1 for _, n, _ in new_theorems if n not in existing_names and n not in rejected)
    if pending > 0:
        print(f"EXIT_RETRY: {pending} theorems still pending", file=sys.stderr)
        sys.exit(1)
    sys.exit(0)


if __name__ == "__main__":
    main()
