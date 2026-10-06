-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.lc1_vanish'
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Theorems.Thm_BookProof_CarlemanTwoStep_lc1_vanish
open BookProof.CarlemanSimplex




open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) (h : ¬ Finsupp.single i 1 ≤ a) :
    lc1 a i = 0 := by

  classical
  refine lc1_vanish i a ?_
  by_contra hge
  refine h ?_
  rw [Finsupp.le_def]
  intro k
  by_cases hk : k = i
  · subst hk
    simpa using (by omega : 1 ≤ a k)
  · simp [Ne.symm hk]
