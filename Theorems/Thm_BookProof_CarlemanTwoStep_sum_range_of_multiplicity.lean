-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.sum_range_of_multiplicity
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep










open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}











variable {u : (Fin d →₀ ℕ) → ℂ}


















variable {lam : (Fin d →₀ ℕ) → ℝ} {w1 w2 : Fin d → ℂ} {z : ℂ}

theorem BookProof.CarlemanTwoStep.sum_range_of_multiplicity {B : ℝ} (m : ℕ)
    (hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ B)
    (G : ℕ → Finset (Fin d →₀ ℕ))
    (hm : ∀ (a : Fin d →₀ ℕ) (M : ℕ),
      (((Finset.range M).filter (fun N => a ∈ G N)).card) ≤ m)
    (M : ℕ) : ∑ N ∈ Finset.range M, ∑ a ∈ G N, ‖u a‖ ^ 2 ≤ (m : ℝ) * B := by sorry
