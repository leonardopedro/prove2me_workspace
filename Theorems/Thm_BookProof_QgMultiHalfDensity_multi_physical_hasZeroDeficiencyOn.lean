-- Generated from ChapterQgMultiHalfDensity.lean — theorem BookProof.QgMultiHalfDensity.multi_physical_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesFockContinuum
import Definitions.Def_ChapterQuantumGravityHalfDensity
import Definitions.Def_ChapterScalaronDensitizedTransfer
open BookProof.ChapterLinftyMultiplication
open BookProof.NavierStokesFlow.FockContinuum
open BookProof.QuantumGravityHalfDensity
open BookProof.ScalaronDensitized
open BookProof.QgMultiHalfDensity

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
  {mu : Measure X} {nu : Measure Y} {Phi : X → Y} {Psi : Y → X}
variable {g : Y → ℝ}
variable {X : Type*} [MeasurableSpace X] (mu : Measure X)
variable [SFinite mu]



open MeasureTheory Set
open BookProof.NavierStokesFlow.FockContinuum
open BookProof.QuantumGravityHalfDensity

noncomputable section

theorem BookProof.QgMultiHalfDensity.multi_physical_hasZeroDeficiencyOn {V : ℝ × X → ℝ} (hV : Measurable V) :
    BookProof.NavierStokesFlow.HasZeroDeficiencyOn
      (boundedEnergyCore (BookProof.ScalaronDensitized.physMeasure.prod mu) V)
      (multOp (BookProof.ScalaronDensitized.physMeasure.prod mu) hV) := by sorry
