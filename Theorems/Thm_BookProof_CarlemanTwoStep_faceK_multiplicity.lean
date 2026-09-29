-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.faceK_multiplicity
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep










open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}











variable {u : (Fin d →₀ ℕ) → ℂ}


















variable {lam : (Fin d →₀ ℕ) → ℝ} {w1 w2 : Fin d → ℂ} {z : ℂ}

theorem BookProof.CarlemanTwoStep.faceK_multiplicity (i : Fin d) (k : ℕ) (a : Fin d →₀ ℕ) (M : ℕ) :
    (((Finset.range M).filter (fun N => a ∈ faceK d N i k)).card) ≤ k := by sorry
