-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.sum_cube_splitK
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
import Definitions.Def_ChapterHermiteCarlemanEsa
open BookProof.HermiteCarleman
open BookProof.CarlemanTwoStep



open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}


theorem BookProof.CarlemanTwoStep.sum_cube_splitK (d N : ℕ) (i : Fin d) (k : ℕ) (F : (Fin d →₀ ℕ) → ℂ) :
    ∑ a ∈ cube d N, F a = ∑ a ∈ innK d N i k, F a + ∑ a ∈ faceK d N i k, F a := by sorry
