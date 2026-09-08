#!/usr/bin/env python3
"""
Background upload of timepiece theorems to Prove2me.
Based on the v3 approach: extract theorem/lemma lines with 500 chars of context.
Runs continuously until all theorems are processed.

Usage:
    python3 scripts/upload_timepiece_bg.py            # full upload
    python3 scripts/upload_timepiece_bg.py --limit 10  # test
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
STATE_FILE = Path("/tmp/timepiece_upload_bg_state.json")
LOG_FILE = Path("/tmp/timepiece_upload_bg.log")
NAMES_CACHE = Path("/tmp/prove2me_names_cache_bg.txt")


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
    Returns list of (name, statement, docstring) or empty list if file can't be read.
    """
    try:
        with open(filepath, encoding="utf-8") as f:
            content = f.read()
    except Exception as e:
        print(f"  WARNING: Could not read {filepath}: {e}", file=sys.stderr)
        return []
    
    results = []
    
    for m in re.finditer(r'^(theorem|lemma)\s+(\S+)', content, re.MULTILINE):
        name = m.group(2)
        line_start = content.rfind('\n', 0, m.start()) + 1
        line_end = content.find('\n', m.end())
        line = content[line_start:line_end]
        
        # Skip if it contains sorry (already uploaded or open)
        if 'sorry' in line:
            continue
        
        # Get context: 500 chars before the declaration
        start_ctx = max(0, m.start() - 500)
        ctx = content[start_ctx:m.end()]
        
        # Find where the proof starts
        stmt_m = re.search(r':=\s*(by|\S)', ctx)
        if stmt_m:
            # Everything up to and including ':=' is the type signature
            statement = ctx[:stmt_m.end()].strip() + " := by sorry"
        else:
            statement = ctx + " := by sorry"
        
        # Extract docstring
        docstring = ""
        doc_match = re.search(r'/--([\s\S]*?)\s*/', content[:m.start()])
        if doc_match:
            docstring = doc_match.group(1).strip()
        
        results.append((name, statement, docstring))
    
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


def submit_theorem(prefix, name, statement, docstring):
    """
    Submit a single theorem to prove2me.
    Returns (success, result_dict).
    """
    # Clean up docstring (remove /-- and -/)
    clean_docstring = docstring
    clean_docstring = clean_docstring.replace('/--', '').replace('-/', '').strip()
    
    # Build title
    title = name.replace("_", " ").title()
    
    # Determine tags
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
            for name, statement, docstring in results:
                theorems.append((prefix, name, statement, docstring))
    
    # Sort: QYM first, then by name
    theorems.sort(key=lambda x: (0 if is_qym(x[1]) else 1, x[1]))
    
    qym_count = sum(1 for t in theorems if is_qym(t[1]))
    print(f"Found {len(theorems)} theorems ({qym_count} QYM)", file=sys.stderr)
    
    return theorems


def main():
    import argparse
    
    parser = argparse.ArgumentParser(description="Upload timepiece theorems to Prove2me")
    parser.add_argument("--limit", type=int, help="Limit number of theorems to process (for testing)")
    parser.add_argument("--prefixes", nargs="+", default=DEFAULT_PREFIXES, help="Prefixes to scan")
    
    args = parser.parse_args()
    
    # Load state
    state = load_state(STATE_FILE)
    existing_names = load_existing_names(NAMES_CACHE)
    
    # Scan project
    theorems = scan_project(args.prefixes)
    
    # Skip already uploaded
    new_theorems = []
    for prefix, name, statement, docstring in theorems:
        if name not in existing_names:
            new_theorems.append((prefix, name, statement, docstring))
        else:
            print(f"  SKIP (already uploaded): {prefix}.{name}", file=sys.stderr)
    
    print(f"New theorems to process: {len(new_theorems)}", file=sys.stderr)
    
    if not new_theorems:
        print("Nothing to do!", file=sys.stderr)
        return
    
    # Process
    ok = state.get("ok", 0)
    fail = state.get("fail", 0)
    skip = 0
    
    # If resuming, start from saved index
    start_idx = state.get("next_index", 0)
    
    for i in range(start_idx, len(new_theorems)):
        # Save state every 50 theorems
        if i > 0 and i % 50 == 0:
            save_state(STATE_FILE, {**state, "next_index": i})
            save_existing_names(NAMES_CACHE, existing_names)
        
        # Check if we've hit the limit
        if args.limit and i >= args.limit:
            print(f"Limit reached ({args.limit} theorems)", file=sys.stderr)
            break
        
        prefix, name, statement, docstring = new_theorems[i]
        tag = " [QYM]" if is_qym(name) else ""
        
        print(f"\n[{i+1}/{len(new_theorems)}] {prefix}.{name}{tag}", file=sys.stderr)
        
        # Submit
        success, result = submit_theorem(prefix, name, statement, docstring)
        
        if success:
            theorem_id = result.get("theorem_id", "unknown")
            existing_names.add(name)
            print(f"  OK -> {theorem_id}", file=sys.stderr)
            with open(LOG_FILE, 'a') as f:
                f.write(f"OK: {prefix}.{name} -> {theorem_id}{tag}\n")
            ok += 1
        else:
            error = result.get("error", str(result))
            print(f"  FAIL: {error[:100]}", file=sys.stderr)
            with open(LOG_FILE, 'a') as f:
                f.write(f"FAIL: {prefix}.{name} - {error[:200]}{tag}\n")
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
