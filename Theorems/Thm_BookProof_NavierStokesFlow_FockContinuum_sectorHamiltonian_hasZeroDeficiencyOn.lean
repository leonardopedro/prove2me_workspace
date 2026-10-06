-- Generated from ChapterNavierStokesFockContinuum.lean — theorem BookProof.NavierStokesFlow.FockContinuum.sectorHamiltonian_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.DirectSumEsa
open BookProof.ChapterLinftyMultiplication
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory



open FullEsa


theorem BookProof.NavierStokesFlow.FockContinuum.sectorHamiltonian_hasZeroDeficiencyOn {w : ℝ → ℝ} (hw : Measurable w) (n : ℕ) :
    HasZeroDeficiencyOn
      (boundedEnergyCore (volume : Measure (Fin n → ℝ)) (sectorEnergy w n))
      (multOp (volume : Measure (Fin n → ℝ)) (sectorEnergy_measurable hw n)) := by sorry
