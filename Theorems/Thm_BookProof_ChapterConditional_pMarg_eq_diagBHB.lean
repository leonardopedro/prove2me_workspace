-- Generated from ChapterConditional.lean — theorem BookProof.ChapterConditional.pMarg_eq_diagBHB
import Mathlib
import Definitions.Def_ChapterConditional
open BookProof.ChapterConditional


open scoped BigOperators Matrix
open Finset


variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X]
variable {𝕜 : Type*} [RCLike 𝕜]


theorem BookProof.ChapterConditional.pMarg_eq_diagBHB (B : Matrix Y X 𝕜) (x : X) :
    ((Bᴴ * B) x x) = ((pMarg B x : ℝ) : 𝕜) := by sorry
