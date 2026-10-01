-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.facesK_le
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w1 w2 : Fin d → ℂ} {z : ℂ}



open Finset
open BookProof.HermiteCarleman

noncomputable section


theorem BookProof.CarlemanTwoStep.facesK_le {B : ℝ}
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B) (i : Fin d) (k M : ℕ) :
    ∑ N ∈ Finset.range M, ∑ a ∈ faceK d N i k, ‖u a‖ ^ 2 ≤ (k : ℝ) * B := by sorry
