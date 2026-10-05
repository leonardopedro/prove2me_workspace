-- Generated from ChapterYangMillsFockGapChain.lean — solution of BookProof.YangMillsFockGapChain.ym_quadForm_eq
import Mathlib
import Definitions.Def_ChapterYangMillsFockGapChain
open BookProof.YangMillsFockGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation
open BookProof.FarisLavine BookProof.HermiteGalerkin
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.BandEnclosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution (x : finiteModeDomain (coreBasis e)) :
    quadForm (ymHamiltonian (coreRepBasis e) fabc) x
      = quadForm ((finiteModeDomain (coreBasis e)).subtype.comp (ymOnePart e fabc)) x := rfl
