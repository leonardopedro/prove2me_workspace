-- Generated from ChapterConditional.lean — theorem BookProof.ChapterConditional.pCond_sum_one
import Mathlib
import Definitions.Def_ChapterConditional
open BookProof.ChapterConditional

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X]
variable {𝕜 : Type*} [RCLike 𝕜]


open scoped BigOperators Matrix
open Finset



theorem BookProof.ChapterConditional.pCond_sum_one (B : Matrix Y X 𝕜) (x : X) (hx : 0 < pMarg B x) :
    ∑ y, pCond B x y = 1 := by sorry
