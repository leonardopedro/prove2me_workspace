-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.apply_le_deg
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex




open Finset

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (a : Fin d →₀ ℕ) (i : Fin d) : a i ≤ deg a := Finset.single_le_sum (f := fun j => a j) (fun _ _ => Nat.zero_le _) (Finset.mem_univ i)
