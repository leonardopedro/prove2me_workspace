-- Generated from ChapterConditional.lean — theorem BookProof.ChapterConditional.pJoint_sum_one
import Mathlib
import Definitions.Def_ChapterConditional
open BookProof.ChapterConditional


open scoped BigOperators Matrix
open Finset


variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X]
variable {𝕜 : Type*} [RCLike 𝕜]


theorem BookProof.ChapterConditional.pJoint_sum_one (B : Matrix Y X 𝕜)
    (hB : ∑ x, ∑ y, ‖B y x‖ ^ 2 = 1) :
    ∑ x, ∑ y, pJoint B x y = 1 := by sorry
