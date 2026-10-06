-- Generated from ChapterConditional.lean — theorem BookProof.ChapterConditional.trace_gram_eq_one
import Mathlib
import Definitions.Def_ChapterConditional
open BookProof.ChapterConditional

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X]
variable {𝕜 : Type*} [RCLike 𝕜]


open scoped BigOperators Matrix
open Finset



theorem BookProof.ChapterConditional.trace_gram_eq_one (B : Matrix Y X 𝕜)
    (hB : ∑ x, ∑ y, ‖B y x‖ ^ 2 = 1) :
    (Bᴴ * B).trace = ((1 : ℝ) : 𝕜) := by sorry
