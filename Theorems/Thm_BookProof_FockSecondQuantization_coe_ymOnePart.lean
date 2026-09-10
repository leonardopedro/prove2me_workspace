-- Generated from ChapterFockSecondQuantization.lean — theorem BookProof.FockSecondQuantization.coe_ymOnePart
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

theorem BookProof.FockSecondQuantization.coe_ymOnePart (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)
    (x : finiteModeDomain (coreBasis e)) :
    ((ymOnePart e fabc x : finiteModeDomain (coreBasis e)) : L2d 99)
      = ymHamiltonian (coreRepBasis e) fabc x := by sorry
