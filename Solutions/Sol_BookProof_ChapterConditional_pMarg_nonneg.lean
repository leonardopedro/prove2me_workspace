-- Generated from ChapterConditional.lean — solution of BookProof.ChapterConditional.pMarg_nonneg
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
theorem solution (B : Matrix Y X 𝕜) (x : X) : 0 ≤ pMarg B x := by

  exact Finset.sum_nonneg fun _ _ => sq_nonneg _
