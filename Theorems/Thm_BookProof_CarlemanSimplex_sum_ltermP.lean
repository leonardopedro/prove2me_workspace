-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.sum_ltermP
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.sum_ltermP {w : ℂ} {rc lc : (Fin d →₀ ℕ) → ℝ} {P : Fin d →₀ ℕ}
    (hcomp : ∀ a : Fin d →₀ ℕ, lc (a + P) = rc a)
    (hvan : ∀ a : Fin d →₀ ℕ, ¬ P ≤ a → lc a = 0) (N : ℕ) :
    ∑ a ∈ simplexF d N, ltermP u w lc P a
      = (starRingEnd ℂ) (∑ b ∈ sInn d N (deg P), rtermP u w rc P b) := by sorry
