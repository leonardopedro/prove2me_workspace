-- Generated from ChapterQgMultiHalfDensity.lean — theorem BookProof.QgMultiHalfDensity.multiHalfDensityUnitary_apply
import Definitions.Def_ChapterNavierStokesFockContinuum
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
import Definitions.Def_ChapterQuantumGravityHalfDensity
import Definitions.Def_ChapterScalaronDensitizedTransfer
open BookProof.QuantumGravityHalfDensity
open BookProof.ScalaronDensitized
open BookProof.QgMultiHalfDensity



open MeasureTheory Set
open BookProof.NavierStokesFlow.FockContinuum
open BookProof.QuantumGravityHalfDensity

noncomputable section

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
  {mu : Measure X} {nu : Measure Y} {Phi : X → Y} {Psi : Y → X}
variable {g : Y → ℝ}
variable {X : Type*} [MeasurableSpace X] (mu : Measure X)
variable [SFinite mu]

theorem BookProof.QgMultiHalfDensity.multiHalfDensityUnitary_apply
    (g : Lp ℂ 2 (BookProof.ScalaronDensitized.physMeasure.prod mu)) :
    (multiHalfDensityUnitary mu g : ℝ × X → ℂ)
      =ᵐ[qgSrcMeasure.prod mu] fun p => (g : ℝ × X → ℂ) (p.1 ^ 2, p.2) := by sorry
