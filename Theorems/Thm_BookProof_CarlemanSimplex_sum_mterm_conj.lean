-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.sum_mterm_conj
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}



open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

theorem BookProof.CarlemanSimplex.sum_mterm_conj {M : Fin d → Fin d → ℂ} (hM : ∀ i j, M j i = (starRingEnd ℂ) (M i j))
    (N : ℕ) (i j : Fin d) :
    (starRingEnd ℂ) (∑ a ∈ simplexF d N, mterm u M a i j)
      = ∑ b ∈ simplexF d N, mterm u M b j i := by sorry
