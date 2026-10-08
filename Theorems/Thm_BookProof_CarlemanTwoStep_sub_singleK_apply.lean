-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.sub_singleK_apply
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep



open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}


theorem BookProof.CarlemanTwoStep.sub_singleK_apply {d : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} :
    (a - Finsupp.single i k : Fin d →₀ ℕ) i = a i - k := by sorry
