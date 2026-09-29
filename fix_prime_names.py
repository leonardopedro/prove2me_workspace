#!/usr/bin/env python3
"""Fix thm files with invalid Lean names (apostrophe)."""
import os

thms_dir = os.path.join(os.path.dirname(__file__), "Theorems")

# Find files with apostrophe in the name
for fname in os.listdir(thms_dir):
    if "'" in fname and fname.startswith("Thm_"):
        # Remove the apostrophe
        new_name = fname.replace("'", "")
        old_path = os.path.join(thms_dir, fname)
        new_path = os.path.join(thms_dir, new_name)
        
        if os.path.exists(new_path):
            # The target already exists - we need to remove the old one
            # and keep the existing one
            print(f"Removing duplicate: {fname} (target {new_name} already exists)")
            os.remove(old_path)
        else:
            os.rename(old_path, new_path)
            print(f"Renamed: {fname} -> {new_name}")

print("Done.")
