-- Generated from ChapterConditional.lean — solution of BookProof.ChapterConditional.pJoint_eq_cond_mul_marg
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
theorem solution (B : Matrix Y X 𝕜) (x : X) (y : Y)
    (hx : 0 < pMarg B x) :
    pJoint B x y = pCond B x y * pMarg B x := by

  simp_all [ pCond, div_mul_cancel₀ _ hx.ne' ]
