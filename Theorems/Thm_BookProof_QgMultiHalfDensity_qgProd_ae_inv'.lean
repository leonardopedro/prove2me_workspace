-- Generated from ChapterQgMultiHalfDensity.lean — theorem BookProof.QgMultiHalfDensity.qgProd_ae_inv'
import Definitions.Def_ChapterNavierStokesFockContinuum
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
import Definitions.Def_ChapterQuantumGravityHalfDensity
import Definitions.Def_ChapterScalaronDensitizedTransfer
open BookProof.QuantumGravityHalfDensity
open BookProof.ScalaronDensitized
open BookProof.QgMultiHalfDensity

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
  {mu : Measure X} {nu : Measure Y} {Phi : X → Y} {Psi : Y → X}
variable {g : Y → ℝ}
variable {X : Type*} [MeasurableSpace X] (mu : Measure X)



open MeasureTheory Set
open BookProof.NavierStokesFlow.FockContinuum
open BookProof.QuantumGravityHalfDensity

noncomputable section

theorem BookProof.QgMultiHalfDensity.qgProd_ae_inv_prime :
    ∀ᵐ p ∂(BookProof.ScalaronDensitized.physMeasure.prod mu),
      qgProdSquare (qgProdSqrt p) = p := by sorry
