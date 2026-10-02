-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.shiftm_apply_self
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex




open Finset

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}

set_option maxHeartbeats 1000000 in
theorem solution {a : Fin d →₀ ℕ} {i j : Fin d} :
    (shiftm a i j) i = (a - Finsupp.single j 1 : Fin d →₀ ℕ) i + 1 := by

  simp [shiftm]
