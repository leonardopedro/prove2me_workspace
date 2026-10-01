-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.sum_mterm_im
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.sum_mterm_im {M : Fin d → Fin d → ℂ} (hM : ∀ i j, M j i = (starRingEnd ℂ) (M i j))
    (N : ℕ) : (∑ i, ∑ j, ∑ a ∈ simplexF d N, mterm u M a i j).im = 0 := by sorry
