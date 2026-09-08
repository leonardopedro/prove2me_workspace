-- Generated from ChapterHermiteGalerkinFriedrichs.lean — solution of BookProof.HermiteGalerkin.ritzInf_extension_le
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Theorems.Thm_BookProof_HermiteGalerkin_ritzSet_bddBelow
open BookProof.HermiteGalerkin













open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {Dom : Submodule ℂ F} (H : D →ₗ[ℂ] F) (A : Dom →ₗ[ℂ] F)
    (hA : IsPositiveSelfAdjointExtension H A) (hne : (ritzSet H D).Nonempty) :
    ritzInf A Dom ≤ ritzInf H D := by

  refine csInf_le_csInf (ritzSet_bddBelow A hA.2.2.1 Dom) hne ?_
  rintro t ⟨x, -, hx1, rfl⟩
  obtain ⟨hmem, hval⟩ := hA.1 x
  refine ⟨⟨(x : F), hmem⟩, (⟨(x : F), hmem⟩ : Dom).2, hx1, ?_⟩
  simp only [quadForm, hval]
