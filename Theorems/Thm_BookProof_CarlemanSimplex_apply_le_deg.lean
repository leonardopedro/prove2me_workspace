-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.apply_le_deg
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

theorem BookProof.CarlemanSimplex.apply_le_deg (a : Fin d →₀ ℕ) (i : Fin d) : a i ≤ deg a := by sorry
