-- Generated from ChapterConditional.lean — solution of BookProof.ChapterConditional.pMarg_eq_sum
import Mathlib
import Definitions.Def_ChapterConditional
open BookProof.ChapterConditional



open scoped BigOperators Matrix
open Finset


variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X]
variable {𝕜 : Type*} [RCLike 𝕜]

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X]
variable {𝕜 : Type*} [RCLike 𝕜]

set_option maxHeartbeats 1000000 in
omit [Fintype X] [DecidableEq X] in
theorem solution (B : Matrix Y X 𝕜) (x : X) :
    pMarg B x = ∑ y, pJoint B x y := by

  rfl
