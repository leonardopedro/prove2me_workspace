-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.shifted_sBd_multiplicity
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex
import Definitions.Def_ChapterA4

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ}
variable {lam : (Fin d →₀ ℕ) → ℝ} {w : Fin d → ℂ} {W M : Fin d → Fin d → ℂ} {z : ℂ}



open Finset

noncomputable section


theorem BookProof.CarlemanSimplex.shifted_sBd_multiplicity (P : Fin d →₀ ℕ) (b : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter
      (fun N => b ∈ (sBd d N (deg P)).image (fun a => a + P))).card) ≤ deg P := by sorry
