-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.flux_boundG
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w1 w2 : Fin d → ℂ} {z : ℂ}



open Finset
open BookProof.HermiteCarleman

noncomputable section


theorem BookProof.CarlemanTwoStep.flux_boundG {w : ℂ} {rc : (Fin d →₀ ℕ) → Fin d → ℝ} (N : ℕ) (i : Fin d) (k : ℕ)
    {Cn : ℝ} (hCn : 0 ≤ Cn) (hC : ∀ a ∈ faceK d N i k, |rc a i| ≤ Cn) :
    |(∑ a ∈ faceK d N i k, rtermG u w rc k i a).im|
      ≤ Cn * (‖w‖ * ((∑ a ∈ faceK d N i k,
          (‖u a‖ ^ 2 + ‖u (a + Finsupp.single i k)‖ ^ 2)) / 2)) := by sorry
