-- Generated from ChapterQgMultiHalfDensity.lean — theorem BookProof.QgMultiHalfDensity.multiHalfDensityUnitary_intertwines_multOp
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
import Definitions.Def_ChapterLinftyMultiplication
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

theorem BookProof.QgMultiHalfDensity.multiHalfDensityUnitary_intertwines_multOp {V : ℝ × X → ℝ} (hV : Measurable V)
    (x : boundedEnergyCore (BookProof.ScalaronDensitized.physMeasure.prod mu) V) :
    ((multOp (qgSrcMeasure.prod mu)
        (hV.comp (measurePreserving_qgProdSquare mu).measurable)
        ⟨multiHalfDensityUnitary mu
            (x : Lp ℂ 2 (BookProof.ScalaronDensitized.physMeasure.prod mu)),
          mpUnitary_mem_boundedEnergyCore _ _ _ x⟩ :
        boundedEnergyCore (qgSrcMeasure.prod mu) fun p => V (qgProdSquare p)) :
        Lp ℂ 2 (qgSrcMeasure.prod mu))
      = multiHalfDensityUnitary mu
          ((multOp (BookProof.ScalaronDensitized.physMeasure.prod mu) hV x :
            boundedEnergyCore (BookProof.ScalaronDensitized.physMeasure.prod mu) V) :
            Lp ℂ 2 (BookProof.ScalaronDensitized.physMeasure.prod mu)) := by sorry
