-- Generated from ChapterHermiteGalerkinFriedrichs.lean — solution of BookProof.HermiteGalerkin.hermiteGalerkin_selects_friedrichs
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Theorems.Thm_BookProof_HermiteGalerkin_finiteModeDomain_dense
import Theorems.Thm_BookProof_HermiteGalerkin_galerkinCompression_tendsto
import Theorems.Thm_BookProof_HermiteGalerkin_galerkinResolvent_tendsto
import Theorems.Thm_BookProof_HermiteGalerkin_positive_selfadjoint_extension_unique
open BookProof.HermiteGalerkin













open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {D : Submodule ℂ F}












variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]









variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) (hsym : SymmetricOn (finiteModeDomain b) H)
    (hpos : ∀ x : finiteModeDomain b, 0 ≤ quadForm H x)
    (C : ℝ) (hbd : ∀ x : finiteModeDomain b, ‖H x‖ ≤ C * ‖(x : F)‖) :
    ∃ A : F →L[ℂ] F,
      (∀ x : finiteModeDomain b, A (x : F) = H x) ∧
      IsPositiveSelfAdjointExtension H (topRestrict A) ∧
      (∀ (B : (⊤ : Submodule ℂ F) →ₗ[ℂ] F), IsPositiveSelfAdjointExtension H B →
        ∀ x : F, B ⟨x, trivial⟩ = A x) ∧
      (∀ u : F, Tendsto (fun m : ℕ => galerkinCompression A b m u) atTop (nhds (A u))) ∧
      (∀ (z : ℂ), z.im ≠ 0 → ∀ u : F,
        Tendsto (fun m : ℕ => resolvent (galerkinCompression A b m) z u) atTop
          (nhds (resolvent A z u))) := by

  obtain ⟨A, hagree, hext⟩ :=
    friedrichs_of_bounded H (finiteModeDomain_dense b) hsym hpos C hbd
  have hAsa : IsSelfAdjoint A := by
    refine ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mpr ?_
    intro y w
    have := hext.2.1 ⟨y, trivial⟩ ⟨w, trivial⟩
    simpa [topRestrict] using this
  refine ⟨A, hagree, hext, ?_, ?_, ?_⟩
  · intro B hBext x
    exact positive_selfadjoint_extension_unique H (finiteModeDomain_dense b) A hagree B hBext x
  · exact fun u => galerkinCompression_tendsto A b u
  · exact fun z hz u => galerkinResolvent_tendsto hAsa b hz u
