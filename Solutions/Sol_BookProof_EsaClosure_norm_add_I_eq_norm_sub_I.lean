-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.norm_add_I_eq_norm_sub_I
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_FarisLavine_inner_apply_self_im
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
eSpace F] {Dom : Submodule ℂ F}

theorem solution {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A) (x : Dom) :
    ‖A x + Complex.I • (x : F)‖ = :=
   ‖A x - Complex.I • (x : F)‖ := by
    have him : (inner ℂ (A x) (x : F) : ℂ).im = 0 := inner_apply_self_im A hsym x
    have hcross : RCLike.re (inner ℂ (A x) (Complex.I • (x : F)) : ℂ) = 0 := by
      rw [inner_smul_right]; simp [him]
    have h1 : ‖A x + Complex.I • (x : F)‖ ^ 2 = ‖A x - Complex.I • (x : F)‖ ^ 2 := by
      rw [@norm_add_sq ℂ, @norm_sub_sq ℂ, hcross]; ring
    nlinarith [h1, norm_nonneg (A x + Complex.I • (x : F)), norm_no
