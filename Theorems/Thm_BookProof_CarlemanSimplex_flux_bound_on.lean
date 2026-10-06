-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.flux_bound_on
import Definitions.Def_ChapterHermiteCarlemanEsa
import Definitions.Def_ChapterCarlemanTwoStep
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
open BookProof.CarlemanSimplex

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}



open Finset
open BookProof.HermiteCarleman BookProof.CarlemanTwoStep

noncomputable section


theorem BookProof.CarlemanSimplex.flux_bound_on {w : ℂ} {rc : (Fin d →₀ ℕ) → ℝ} (F : Finset (Fin d →₀ ℕ))
    (P : Fin d →₀ ℕ) {Cn : ℝ} (hC : ∀ a ∈ F, |rc a| ≤ Cn) :
    |(∑ a ∈ F, rtermP u w rc P a).im|
      ≤ Cn * (‖w‖ * ((∑ a ∈ F, (‖u a‖ ^ 2 + ‖u (a + P)‖ ^ 2)) / 2)) := by sorry
