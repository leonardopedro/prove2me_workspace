-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.clRange_orthogonal_eq_bot
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_EsaClosure_coe_mem_clDom
import Theorems.Thm_BookProof_EsaClosure_clExt_apply
import Theorems.Thm_BookProof_EsaClosure_clExt_extends
import Theorems.Thm_BookProof_HashimotoShiftInvert_cshiftMap_apply
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
, clExt_apply, hval]
  abel

theorem solution (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D T) (hesa : EssentiallySelfAdjointOn D T) :
    (cshiftRange (clExt T hden :=
  se hsym) Complex.I)ᗮ = ⊥ := by
    rw [Submodule.eq_bot_iff]
    intro w hw
    refine hesa.2 w fun v => ?_
    have hmemD : (v : F) ∈ clDom T := coe_mem_clDom T v
    have hmem : cshiftMap (clExt T hdense hsym) Complex.I ⟨(v : F), hmemD⟩
        ∈ cshiftRange (clExt T hdense hsym) Complex.I := ⟨_, rfl⟩
    have h0 : (inner ℂ (cshiftMap (clExt T hdense hsym) Complex.I ⟨(v : F), hmemD⟩) w : ℂ) = 0 :=
      hw _ hmem
    rw [cshiftMap_apply, inner_sub_left, inner_smul_left, clExt_apply,
      show clFun T ⟨(v : F), hmemD⟩ = T v from clExt_extends T hdense hsym v] at h0
    have hconj : (starRingEnd ℂ) Complex.I = -Complex.I := by simp
    rw [hconj] a
