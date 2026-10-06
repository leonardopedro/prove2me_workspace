-- Generated from ChapterConditional.lean — theorem BookProof.ChapterConditional.pMarg_eq_sum
import Mathlib
import Definitions.Def_ChapterConditional
open BookProof.ChapterConditional

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X]
variable {𝕜 : Type*} [RCLike 𝕜]


open scoped BigOperators Matrix
open Finset



omit [Fintype X] [DecidableEq X] in
theorem BookProof.ChapterConditional.pMarg_eq_sum (B : Matrix Y X 𝕜) (x : X) :
    pMarg B x = ∑ y, pJoint B x y := by sorry
