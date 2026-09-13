-- Generated from ChapterHermiteGalerkinFriedrichs.lean — solution of BookProof.HermiteGalerkin.finiteModeRestrict_hypotheses
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
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
    SymmetricOn (finiteModeDomain b) (finiteModeRestrict A₀ b) ∧
      (∀ x : finiteModeDomain b, 0 ≤ quadForm (finiteModeRestrict A₀ b) x) ∧
      (∀ x : finiteModeDomain b, ‖finiteModeRestrict A₀ b x‖ ≤ ‖A₀‖ * ‖(x : F)‖) := by

  refine ⟨fun x y => ?_, fun x => hposA _, fun x => A₀.le_opNorm _⟩
  exact (ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hsa) (x : F) (y : F)
