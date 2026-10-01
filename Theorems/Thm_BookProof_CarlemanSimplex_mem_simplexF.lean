-- Generated from ChapterCarlemanSimplex.lean — theorem BookProof.CarlemanSimplex.mem_simplexF
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

theorem BookProof.CarlemanSimplex.mem_simplexF {d N : ℕ} {a : Fin d →₀ ℕ} : a ∈ simplexF d N ↔ deg a ≤ N := by sorry
