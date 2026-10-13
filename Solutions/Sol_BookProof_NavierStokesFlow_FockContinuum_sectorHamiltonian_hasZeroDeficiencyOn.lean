-- Generated from ChapterNavierStokesFockContinuum.lean — solution of BookProof.NavierStokesFlow.FockContinuum.sectorHamiltonian_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
import Theorems.Thm_BookProof_NavierStokesFlow_FockContinuum_multOp_hasZeroDeficiencyOn
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum



open MeasureTheory



open FullEsa
open BookProof.DirectSumEsa
open BookProof.ChapterLinftyMultiplication

variable {X : Type*} [MeasurableSpace X]

variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in

theorem solution {w : ℝ → ℝ} (hw : Measurable w) (n : ℕ) :
    HasZeroDeficiencyOn
      (boundedEnergyCore (volume : Measure (Fin n → ℝ)) (sectorEnergy w n))
      (multOp (volume : Measure (Fin n → ℝ)) (sectorEnergy_measurable hw n)) :=
  multOp_hasZeroDeficiencyOn _ _
