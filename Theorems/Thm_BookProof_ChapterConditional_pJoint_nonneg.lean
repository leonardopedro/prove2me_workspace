-- Generated from ChapterConditional.lean — theorem BookProof.ChapterConditional.pJoint_nonneg
import Mathlib
import Definitions.Def_ChapterConditional
open BookProof.ChapterConditional

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X]
variable {𝕜 : Type*} [RCLike 𝕜]


open scoped BigOperators Matrix
open Finset



omit [Fintype X] [Fintype Y] [DecidableEq X] in
theorem BookProof.ChapterConditional.pJoint_nonneg (B : Matrix Y X 𝕜) (x : X) (y : Y) : 0 ≤ pJoint B x y := by sorry
