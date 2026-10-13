-- Generated from ChapterQymTimeIndependentFlow.lean — solution of BookProof.QymTimeIndependent.ymFock_weylGauge_timeIndependent
import Mathlib
import Definitions.Def_ChapterQymTimeIndependentFlow
import Theorems.Thm_BookProof_EsaClosure_isSelfAdjointExtension_of_positive
import Theorems.Thm_BookProof_FiniteSectionSingleTime_timeIndependent_of_selfAdjointExtension
import Theorems.Thm_BookProof_FockSecondQuantization_ym_fock_friedrichs_extension
import Theorems.Thm_BookProof_YangMillsHermite_ymHamiltonian_quadForm
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterQgTimeIndependentFlow
import Definitions.Def_ChapterFiniteSectionSingleTime
import Definitions.Def_ChapterQgCouplingDGammaSum
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
open BookProof.QymTimeIndependent




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.FiniteSectionSingleTime BookProof.YangMillsFriedrichs
open BookProof.FockSecondQuantization BookProof.QgCouplingDGammaSum
open BookProof.YangMillsHermite BookProof.HermiteGalerkin BookProof.HermiteProductCore
open BookProof.NavierStokesFlow
open BookProof.EsaClosure
open BookProof.FockSecondQuantization
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsHermite

noncomputable section

variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution :
    (∀ x : finiteModeDomain (coreBasis e),
        quadForm (ymHamiltonian (coreRepBasis e) fabc) x
          = 1 / 2 * (∑ m, ‖((piOps (coreRepBasis e) m x : finiteModeDomain (coreBasis e)) :
              L2d 99)‖ ^ 2)
            + 1 / 2 * ∑ m, ‖((magOps (coreRepBasis e) fabc m x :
                finiteModeDomain (coreBasis e)) : L2d 99)‖ ^ 2) ∧
      ∃ T : UnboundedSelfAdjoint Fock,
        IsSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) T.op ∧
          (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
          (∀ (t s : ℝ) (x : Fock), ‖prop T t s x‖ = ‖x‖) ∧
          (∀ (t s r : ℝ) (x : Fock), prop T t s (prop T s r x) = prop T t r x) ∧
          (∀ t s u : ℝ, prop T (t + u) (s + u) = prop T t s) ∧
          (∀ y : ℝ → Fock, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) := by

  refine ⟨fun x => ymHamiltonian_quadForm (coreRepBasis e) fabc x, ?_⟩
  obtain ⟨Dom, A, hA⟩ := ym_fock_friedrichs_extension e fabc
  exact timeIndependent_of_selfAdjointExtension finiteOccupation_dense
    (isSelfAdjointExtension_of_positive hA)
