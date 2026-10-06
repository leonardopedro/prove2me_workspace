-- Generated from ChapterConditional.lean — theorem BookProof.ChapterConditional.pMarg_sum_one
import Mathlib
import Definitions.Def_ChapterConditional
open BookProof.ChapterConditional

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X]
variable {𝕜 : Type*} [RCLike 𝕜]


open scoped BigOperators Matrix
open Finset



theorem BookProof.ChapterConditional.pMarg_sum_one (B : Matrix Y X 𝕜)
    (hB : ∑ x, ∑ y, ‖B y x‖ ^ 2 = 1) :
    ∑ x, pMarg B x = 1 := by sorry
