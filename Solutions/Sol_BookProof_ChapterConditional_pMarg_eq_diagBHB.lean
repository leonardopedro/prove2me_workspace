-- Generated from ChapterConditional.lean — solution of BookProof.ChapterConditional.pMarg_eq_diagBHB
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
theorem solution (B : Matrix Y X 𝕜) (x : X) :
    ((Bᴴ * B) x x) = ((pMarg B x : ℝ) : 𝕜) := by

  -- By definition of matrix multiplication and the conjugate transpose, we have (Bᴴ * B) x x = ∑ y,
  -- (Bᴴ) x y * B y x.
  simp [Matrix.mul_apply, Matrix.conjTranspose_apply];
  simp [ mul_comm, pMarg, RCLike.mul_conj ]
