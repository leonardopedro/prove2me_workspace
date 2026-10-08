-- Generated from ChapterCarlemanTwoStep.lean — theorem BookProof.CarlemanTwoStep.sub_add_singleK
import Definitions.Def_ChapterHermiteCarlemanEsa
import Mathlib
import Definitions.Def_ChapterCarlemanTwoStep
open BookProof.CarlemanTwoStep



open Finset
open BookProof.HermiteCarleman

noncomputable section

variable {d : ℕ}


theorem BookProof.CarlemanTwoStep.sub_add_singleK {d : ℕ} {i : Fin d} {k : ℕ} {a : Fin d →₀ ℕ} (h : k ≤ a i) :
    (a - Finsupp.single i k) + Finsupp.single i k = a := by sorry
