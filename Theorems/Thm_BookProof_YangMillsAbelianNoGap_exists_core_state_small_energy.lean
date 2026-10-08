-- Generated from ChapterYangMillsAbelianNoGap.lean — theorem BookProof.YangMillsAbelianNoGap.exists_core_state_small_energy
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianNoGap
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterGaussCoordCombo
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterSqueezedGaussStates
import Definitions.Def_ChapterYangMillsHermite
open BookProof.ChapterF7
open BookProof.GaussCoordCombo
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite
open BookProof.YangMillsAbelianNoGap



open MvPolynomial MeasureTheory
open BookProof.HermiteProductCore BookProof.GaussCoordCombo BookProof.SqueezedGaussStates
open BookProof.YangMillsHermite BookProof.FarisLavine BookProof.HermiteGalerkin

noncomputable section

variable {d : ℕ}

variable (vf : Fin d → ℝ) (Mf : Fin d → ℕ)

theorem BookProof.YangMillsAbelianNoGap.exists_core_state_small_energy (e : ℕ ≃ (Fin 99 →₀ ℕ)) {ε : ℝ} (hε : 0 < ε) :
    ∃ x : finiteModeDomain (coreBasis e), ((x : L2d 99) ≠ 0) ∧
      quadForm (ymHamiltonian (coreRepBasis e) (fun _ _ _ => (0 : ℝ))) x
        ≤ ε * ‖(x : L2d 99)‖ ^ 2 := by sorry
