-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.mem_faceK
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

theorem BookProof.CarlemanTwoStep.mem_faceK {d N : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} :
    a ∈ faceK d N i k ↔ (∀ j, a j ≤ N) ∧ N < a i + k := by sorry
