-- Generated from ChapterQgMultiHalfDensity.lean — solution of BookProof.QgMultiHalfDensity.multiHalfDensityUnitary_symm_apply
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
import Theorems.Thm_BookProof_QgMultiHalfDensity_mpUnitary_symm_apply
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
theorem solution (h : Lp ℂ 2 (qgSrcMeasure.prod mu)) :
    ((multiHalfDensityUnitary mu).symm h : ℝ × X → ℂ)
      =ᵐ[BookProof.ScalaronDensitized.physMeasure.prod mu]
        fun p => (h : ℝ × X → ℂ) (Real.sqrt p.1, p.2) := mpUnitary_symm_apply _ _ _ h
