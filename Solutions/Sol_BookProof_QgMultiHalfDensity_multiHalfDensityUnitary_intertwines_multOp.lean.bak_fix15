-- Generated from ChapterQgMultiHalfDensity.lean — solution of BookProof.QgMultiHalfDensity.multiHalfDensityUnitary_intertwines_multOp
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
import Theorems.Thm_BookProof_QgMultiHalfDensity_mpUnitary_intertwines_multOp
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

set_option maxHeartbeats 1000000 in
theorem solution {V : ℝ × X → ℝ} (hV : Measurable V)
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
            Lp ℂ 2 (BookProof.ScalaronDensitized.physMeasure.prod mu)) := mpUnitary_intertwines_multOp _ _ _ hV x
