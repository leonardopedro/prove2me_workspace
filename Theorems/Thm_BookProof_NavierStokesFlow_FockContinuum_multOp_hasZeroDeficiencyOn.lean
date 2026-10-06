-- Generated from ChapterNavierStokesFockContinuum.lean — theorem BookProof.NavierStokesFlow.FockContinuum.multOp_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.ChapterLinftyMultiplication
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockContinuum

variable {X : Type*} [MeasurableSpace X]


open MeasureTheory



open FullEsa


theorem BookProof.NavierStokesFlow.FockContinuum.multOp_hasZeroDeficiencyOn (μ : Measure X) {g : X → ℝ} (hg : Measurable g) :
    HasZeroDeficiencyOn (boundedEnergyCore μ g) (multOp μ hg) := by sorry
