-- Generated from ChapterHermiteGalerkinFriedrichs.lean — solution of BookProof.HermiteGalerkin.finiteModeRestrict_selects_operator
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Theorems.Thm_BookProof_HermiteGalerkin_finiteModeDomain_dense
import Theorems.Thm_BookProof_HermiteGalerkin_galerkinCompression_tendsto
import Theorems.Thm_BookProof_HermiteGalerkin_galerkinResolvent_tendsto
import Theorems.Thm_BookProof_HermiteGalerkin_hermiteGalerkin_selects_friedrichs
import Theorems.Thm_BookProof_HermiteGalerkin_finiteModeRestrict_hypotheses
open BookProof.HermiteGalerkin













open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]






variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



variable {D : Submodule ℂ F}












variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]









variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]










variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A₀ : F →L[ℂ] F) (hsa : IsSelfAdjoint A₀)
    (hposA : ∀ u : F, 0 ≤ (inner ℂ u (A₀ u) : ℂ).re) (b : HilbertBasis ℕ ℂ F) :
    IsPositiveSelfAdjointExtension (finiteModeRestrict A₀ b) (topRestrict A₀) ∧
      (∀ (B : (⊤ : Submodule ℂ F) →ₗ[ℂ] F),
        IsPositiveSelfAdjointExtension (finiteModeRestrict A₀ b) B →
        ∀ x : F, B ⟨x, trivial⟩ = A₀ x) ∧
      (∀ u : F, Tendsto (fun m : ℕ => galerkinCompression A₀ b m u) atTop (nhds (A₀ u))) ∧
      (∀ z : ℂ, z.im ≠ 0 → ∀ u : F,
        Tendsto (fun m : ℕ => resolvent (galerkinCompression A₀ b m) z u) atTop
          (nhds (resolvent A₀ z u))) := by

  obtain ⟨hsym, hpos, hbd⟩ := finiteModeRestrict_hypotheses A₀ hsa hposA b
  obtain ⟨A, hagree, hext, huniq, -, -⟩ :=
    hermiteGalerkin_selects_friedrichs b (finiteModeRestrict A₀ b) hsym hpos ‖A₀‖ hbd
  -- the constructed extension is `A₀` itself
  have hAA : A = A₀ := by
    ext u
    have := Continuous.ext_on (finiteModeDomain_dense b) A.continuous A₀.continuous
      (fun y hy => by simpa using hagree ⟨y, hy⟩)
    exact congrFun this u
  subst hAA
  exact ⟨hext, huniq, fun u => galerkinCompression_tendsto A b u,
    fun z hz u => galerkinResolvent_tendsto hsa b hz u⟩
