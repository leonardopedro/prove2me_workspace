-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.flux_identity2
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterHermiteCarlemanEsa
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w1 w2 : Fin d → ℂ} {z : ℂ}



open Finset
open BookProof.HermiteCarleman

noncomputable section


theorem BookProof.CarlemanTwoStep.flux_identity2 (hrec : LadderRec2 u lam w1 w2 z) (N : ℕ) :
    z.im * (∑ a ∈ cube d N, ‖u a‖ ^ 2)
      = (∑ i, (∑ a ∈ faceK d N i 1, rtermG u (w1 i) rc1 1 i a).im)
        + ∑ i, (∑ a ∈ faceK d N i 2, rtermG u (w2 i) rc2 2 i a).im := by sorry
