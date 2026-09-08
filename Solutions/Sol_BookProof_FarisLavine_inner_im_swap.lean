-- Generated from ChapterFarisLavineCore.lean — solution of BookProof.FarisLavine.inner_im_swap
import Mathlib
import Definitions.Def_ChapterFarisLavineCore
open BookProof.FarisLavine













variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (a b : F) : (inner ℂ b a : ℂ).im = -(inner ℂ a b : ℂ).im := by

  rw [← inner_conj_symm (𝕜 := ℂ) a b, Complex.conj_im, neg_neg]
