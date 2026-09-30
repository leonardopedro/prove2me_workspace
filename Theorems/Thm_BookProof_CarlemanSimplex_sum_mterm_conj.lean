-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.sum_mterm_conj
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex










open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section

variable {d : ℕ}

















variable {u : (Fin d →₀ ℕ) → ℂ}

theorem BookProof.CarlemanSimplex.sum_mterm_conj {M : Fin d → Fin d → ℂ} (hM : ∀ i j, M j i = (starRingEnd ℂ) (M i j))
    (N : ℕ) (i j : Fin d) :
    (starRingEnd ℂ) (∑ a ∈ simplexF d N, mterm u M a i j)
      = ∑ b ∈ simplexF d N, mterm u M b j i := by sorry
