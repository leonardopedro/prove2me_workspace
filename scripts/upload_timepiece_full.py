#!/usr/bin/env python3
"""
Full upload of timepiece theorems to Prove2me.
Handles v4.28 -> v4.33.1 conversion by extracting full formal statements
and submitting them to the prove2me API.

Usage:
    # Preview mode (dry run)
    python3 scripts/upload_timepiece_full.py --dry-run
    
    # Limited upload (first N theorems)
    python3 scripts/upload_timepiece_full.py --limit 10
    
    # Full upload
    python3 scripts/upload_timepiece_full.py
    
    # Resume from last state
    python3 scripts/upload_timepiece_full.py --resume

Environment:
    PROVE2ME_API_KEY - API key (p2m_...)
    PROVE2ME_TOKEN   - Access token (optional, will refresh if needed)
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
STATE_FILE = Path("/tmp/timepiece_upload_full_state.json")
LOG_FILE = Path("/tmp/timepiece_upload_full.log")
NAMES_CACHE = Path("/tmp/prove2me_names_cache_full.txt")


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
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json",
    }
    
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
    
    return json.loads(r.stdout)


def is_qym(name):
    """Check if a theorem name is QYM-related."""
    name_lower = name.lower()
    for kw in QYM_KEYWORDS:
        if kw in name_lower:
            return True
    return False


def extract_theorems_from_file(filepath, prefix):
    """
    Extract theorems/lemmas from a Lean file.
    Returns list of (kind, name, full_statement, docstring, context_lines).
    context_lines are the lines needed to make the statement compile (imports, variables, etc.)
    """
    try:
        with open(filepath, encoding="utf-8") as f:
            content = f.read()
    except Exception as e:
        print(f"  WARNING: Could not read {filepath}: {e}", file=sys.stderr)
        return []
    
    results = []
    lines = content.split('\n')
    
    # Track docstring state
    in_docstring = False
    docstring_lines = []
    
    i = 0
    while i < len(lines):
        stripped = lines[i].strip()
        
        # Handle docstrings
        if not in_docstring:
            if stripped.startswith('/--') or stripped.startswith('/-!'):
                in_docstring = True
                docstring_lines = [stripped]
                i += 1
                continue
            elif stripped.startswith('/-') and not stripped.endswith('-/'):
                # Might be a module doc, skip until end
                in_docstring = True
                docstring_lines = [stripped]
                i += 1
                continue
        else:
            docstring_lines.append(stripped)
            if stripped.endswith('-/') or stripped == '-/':
                in_docstring = False
                i += 1
                continue
            i += 1
            continue
        
        # Skip comment lines
        if stripped.startswith('--') or stripped.startswith('/-'):
            i += 1
            continue
        
        # Match theorem/lemma/def declarations
        m = re.match(r'^(theorem|lemma|def|abbrev|instance|noncomputable\s+def)\s+(\S+)', stripped)
        if m:
            kind = m.group(1)
            name = m.group(2)
            
            # Get docstring
            docstring = '\n'.join(docstring_lines).strip() if docstring_lines else ""
            docstring_lines = []  # Reset for next declaration
            
            # Collect context: imports before this declaration
            context = []
            j = 0
            while j < i:
                line = lines[j]
                stripped_ctx = line.strip()
                # Include only import statements
                if stripped_ctx.startswith('import '):
                    context.append(line)
                j += 1
            
            # Find the full statement (type signature)
            full_statement = stripped
            j = i + 1
            while j < len(lines) and j < i + 20:
                line = lines[j]
                # Stop at blank line or new declaration
                if line.strip() == '':
                    break
                if re.match(r'^(theorem|lemma|def|abbrev|instance|noncomputable\s+def|--|/-|\s*#)', line):
                    break
                full_statement += '\n' + line
                j += 1
            
            # Check if it has a proof (not sorry)
            has_proof = ':= by' in full_statement and 'sorry' not in full_statement
            
            results.append((kind, name, full_statement, docstring, context, has_proof))
        
        i += 1
    
    return results


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
    """Save theorem names to cache."""
    with open(cache_file, 'w') as f:
        for name in sorted(names):
            f.write(name + '\n')


def load_state(state_file):
    """Load upload state for resumption."""
    if state_file.exists():
        with open(state_file) as f:
            return json.load(f)
    return {"next_index": 0, "total": 0, "ok": 0, "fail": 0}


def save_state(state_file, state):
    """Save upload state."""
    with open(state_file, 'w') as f:
        json.dump(state, f)


def build_formal_statement(statement, kind):
    """
    Build the formal_statement for API submission.
    Replaces the proof with ':=' and adds sorry.
    Converts lemma/def to theorem for the platform.
    """
    # Normalize kind to theorem for the platform
    normalized_kind = "theorem" if kind in ("theorem", "lemma") else kind
    
    # Find where the proof starts
    proof_match = re.search(r':=\s*(by|\S)', statement)
    if proof_match:
        # Everything up to and including ':=' is the type signature
        # Replace the kind with "theorem"
        before_proof = statement[:proof_match.start()]
        # Replace lemma/def with theorem if needed
        before_proof = re.sub(r'^(lemma|def|abbrev)\s+', f'{normalized_kind} ', before_proof)
        return before_proof.strip() + " := by sorry"
    
    # If no proof found, just add sorry
    normalized = re.sub(r'^(lemma|def|abbrev)\s+', f'{normalized_kind} ', statement)
    return normalized + " := by sorry"


def submit_theorem(prefix, name, kind, full_statement, docstring, context_lines, has_proof):
    """
    Submit a single theorem to prove2me.
    Returns (success, result_dict).
    """
    # Build the formal statement with context
    formal_statement = build_formal_statement(full_statement, kind)
    
    # Combine context + formal statement
    full_text = '\n'.join(context_lines + [formal_statement])
    
    # Clean up docstring (remove /-- and -/)
    clean_docstring = docstring
    clean_docstring = clean_docstring.replace('/--', '').replace('-/', '').strip()
    
    # Build title
    title = name.replace("_", " ").title()
    
    # Determine tags
    tags = ["timepiece", "auto-upload"]
    if is_qym(name):
        tags.append("qym")
    if not has_proof:
        tags.append("open")
    
    data = {
        "theorem_name": name,
        "theorem_title": title,
        "formal_statement": full_text,
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
        
        # Poll for completion
        for _ in range(60):  # 2 minutes max
            time.sleep(2)
            poll = api_call("GET", "publish-jobs", {"job_id": job_id})
            if poll is None:
                continue
            
            status = poll.get("status", "")
            if status == "PUBLISHED":
                return True, {"theorem_id": poll.get("theorem_id"), "status": "PUBLISHED"}
            elif status in ("FAILED", "ERROR"):
                return False, poll
        
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
            results = extract_theorems_from_file(str(filepath), prefix)
            for kind, name, full_statement, docstring, context_lines, has_proof in results:
                theorems.append((prefix, name, kind, str(filepath), full_statement, docstring, context_lines, has_proof))
    
    # Sort: QYM first, then by name
    theorems.sort(key=lambda x: (0 if is_qym(x[1]) else 1, x[1]))
    
    qym_count = sum(1 for t in theorems if is_qym(t[1]))
    proved = sum(1 for t in theorems if t[7])
    open_count = len(theorems) - proved
    
    print(f"Found {len(theorems)} declarations ({qym_count} QYM, {proved} proved, {open_count} open)", file=sys.stderr)
    
    return theorems


def main():
    import argparse
    
    parser = argparse.ArgumentParser(description="Upload timepiece theorems to Prove2me")
    parser.add_argument("--dry-run", action="store_true", help="Preview without submitting")
    parser.add_argument("--limit", type=int, help="Limit number of theorems to process")
    parser.add_argument("--resume", action="store_true", help="Resume from last state")
    parser.add_argument("--prefixes", nargs="+", default=DEFAULT_PREFIXES, help="Prefixes to scan")
    parser.add_argument("--skip-qym", action="store_true", help="Skip QYM theorems")
    parser.add_argument("--only-qym", action="store_true", help="Only QYM theorems")
    
    args = parser.parse_args()
    
    # Load state
    state = load_state(STATE_FILE)
    existing_names = load_existing_names(NAMES_CACHE)
    
    # Scan project
    theorems = scan_project(args.prefixes)
    
    # Filter
    if args.skip_qym:
        theorems = [t for t in theorems if not is_qym(t[1])]
    if args.only_qym:
        theorems = [t for t in theorems if is_qym(t[1])]
    
    # Skip already uploaded
    new_theorems = []
    for theorem in theorems:
        name = theorem[1]
        if name not in existing_names:
            new_theorems.append(theorem)
        else:
            print(f"  SKIP (already uploaded): {theorem[0]}.{name}", file=sys.stderr)
    
    print(f"New theorems to process: {len(new_theorems)}", file=sys.stderr)
    
    if args.dry_run:
        print("\nDRY RUN - would process the following:", file=sys.stderr)
        for prefix, name, kind, filepath, statement, docstring, context, has_proof in new_theorems[:20]:
            status = "PROVED" if has_proof else "OPEN"
            print(f"  [{status}] {prefix}.{name}", file=sys.stderr)
        if len(new_theorems) > 20:
            print(f"  ... and {len(new_theorems) - 20} more", file=sys.stderr)
        return
    
    # Process
    start_idx = state["next_index"] if args.resume else 0
    ok = state.get("ok", 0)
    fail = state.get("fail", 0)
    skip = 0
    
    for i in range(start_idx, len(new_theorems)):
        if i > 0 and i % 20 == 0:
            save_state(STATE_FILE, {**state, "next_index": i})
            # Update names cache
            save_existing_names(NAMES_CACHE, existing_names)
        
        prefix, name, kind, filepath, full_statement, docstring, context_lines, has_proof = new_theorems[i]
        tag = " [QYM]" if is_qym(name) else ""
        status_tag = "PROVED" if has_proof else "OPEN"
        
        print(f"\n[{i+1}/{len(new_theorems)}] {prefix}.{name} ({status_tag}){tag}", file=sys.stderr)
        
        # Submit
        success, result = submit_theorem(prefix, name, kind, full_statement, docstring, context_lines, has_proof)
        
        if success:
            theorem_id = result.get("theorem_id", "unknown")
            existing_names.add(name)
            print(f"  OK -> {theorem_id}", file=sys.stderr)
            with open(LOG_FILE, 'a') as f:
                f.write(f"OK: {prefix}.{name} -> {theorem_id} (job: {result.get('job_id', 'unknown')}){tag}\n")
            ok += 1
        else:
            error = result.get("error", str(result))
            print(f"  FAIL: {error}", file=sys.stderr)
            with open(LOG_FILE, 'a') as f:
                f.write(f"FAIL: {prefix}.{name} - {error}{tag}\n")
            fail += 1
            # Stop on API errors (likely auth issues)
            if "401" in str(result) or "403" in str(result):
                print("  ERROR: Authentication failed. Stopping.", file=sys.stderr)
                break
    
    # Final state
    final_state = {**state, "next_index": len(new_theorems), "total": len(theorems), 
                   "ok": ok, "fail": fail}
    save_state(STATE_FILE, final_state)
    save_existing_names(NAMES_CACHE, existing_names)
    
    with open(LOG_FILE, 'a') as f:
        f.write(f"DONE: {ok} ok, {fail} fail, {skip} skip out of {len(new_theorems)} total\n")
    
    print(f"\nSUMMARY: {ok} ok, {fail} fail, {skip} skip out of {len(new_theorems)} total", file=sys.stderr)


if __name__ == "__main__":
    main()
