-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.ladderQ_eq_zero
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

theorem BookProof.CarlemanSimplex.ladderQ_eq_zero {B : ℝ} (hz : z.im ≠ 0)
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B)
    (hM : ∀ i j, M j i = (starRingEnd ℂ) (M i j))
    (hrec : LadderRecQ u lam w W M z) : ∀ a, u a = 0 := by sorry
