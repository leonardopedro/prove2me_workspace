-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.ymFockCol_apply
import Mathlib
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization







open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.FriedrichsExtension
open BookProof.HashimotoShiftInvert

noncomputable section

















































































variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]











open Filter Topology
















open BookProof.YangMillsHermite BookProof.HermiteProductCore
open Filter Topology

theorem BookProof.FockSecondQuantization.ymFockCol_apply (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) (k j : ℕ) :
    ymFockCol e fabc k j
      = inner ℂ (coreBasis e j)
          (ymHamiltonian (coreRepBasis e) fabc
            ⟨coreBasis e k, Submodule.subset_span ⟨k, rfl⟩⟩) := by sorry
