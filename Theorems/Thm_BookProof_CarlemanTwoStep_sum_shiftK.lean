-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.sum_shiftK
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w1 w2 : Fin d → ℂ} {z : ℂ}



open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}

theorem BookProof.CarlemanTwoStep.sum_shiftK (d N : ℕ) (i : Fin d) (k : ℕ) (F : (Fin d →₀ ℕ) → ℂ)
    (hF : ∀ a : Fin d →₀ ℕ, a i < k → F a = 0) :
    ∑ a ∈ cube d N, F a = ∑ b ∈ innK d N i k, F (b + Finsupp.single i k) := by sorry
