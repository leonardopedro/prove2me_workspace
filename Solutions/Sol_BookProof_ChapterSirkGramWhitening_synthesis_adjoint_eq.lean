-- Generated from ChapterSirkGramWhitening.lean — solution of BookProof.ChapterSirkGramWhitening.synthesis_adjoint_eq
import Mathlib
import Definitions.Def_ChapterSirkGramWhitening
import Theorems.Thm_BookProof_ChapterSirkGramWhitening_inner_synthesis_left
open BookProof.ChapterSirkGramWhitening









noncomputable section


open scoped InnerProductSpace
open Matrix
open BookProof.ChapterH4 BookProof.ChapterSirkWhitening

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} (w : Fin m → E) (x : E) :
    (ContinuousLinearMap.adjoint (synthesis w)) x = (WithLp.toLp 2 fun i => ⟪w i, x⟫_ℂ) := by

  refine ext_inner_left ℂ fun c => ?_
  rw [ContinuousLinearMap.adjoint_inner_right, inner_synthesis_left]
  simp [PiLp.inner_apply, RCLike.inner_apply, mul_comm]
