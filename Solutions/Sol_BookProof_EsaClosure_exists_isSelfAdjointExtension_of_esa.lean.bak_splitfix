-- Generated from ChapterEsaClosureCore.lean — solution of BookProof.EsaClosure.exists_isSelfAdjointExtension_of_esa
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Theorems.Thm_BookProof_EsaClosure_coe_mem_clDom
import Theorems.Thm_BookProof_EsaClosure_clExt_extends
import Theorems.Thm_BookProof_EsaClosure_clExt_symmetricOn
import Theorems.Thm_BookProof_EsaClosure_clExt_selfAdjointCriterion
open BookProof.EsaClosure



open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D T) (hesa : EssentiallySelfAdjointOn D T) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsSelfAdjointExtension T A :=
  ℂ] F), IsSelfAdjointExtension T A :=
    ⟨clDom T, clExt T hdense hsym,
      fun v => ⟨coe_mem_clDom T v, clExt_extends T hdense hsym v⟩,
      clExt_symmetricOn T hdense hsym,
      clExt_selfAdj
