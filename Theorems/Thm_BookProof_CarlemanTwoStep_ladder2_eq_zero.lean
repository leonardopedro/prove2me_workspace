-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.ladder2_eq_zero
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterA4
open BookProof.HermiteCarleman

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w1 w2 : Fin d → ℂ} {z : ℂ}



open Finset
open BookProof.HermiteCarleman

noncomputable section


theorem BookProof.CarlemanTwoStep.ladder2_eq_zero {B : ℝ} (hz : z.im ≠ 0)
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B)
    (hrec : LadderRec2 u lam w1 w2 z) : ∀ a, u a = 0 := by sorry
