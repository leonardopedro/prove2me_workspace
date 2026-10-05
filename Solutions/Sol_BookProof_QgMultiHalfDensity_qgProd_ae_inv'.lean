-- Generated from ChapterQgMultiHalfDensity.lean — solution of BookProof.QgMultiHalfDensity.qgProd_ae_inv'
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
open BookProof.QgMultiHalfDensity




open MeasureTheory Set
open BookProof.NavierStokesFlow.FockContinuum
open BookProof.QuantumGravityHalfDensity

noncomputable section

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
  {mu : Measure X} {nu : Measure Y} {Phi : X → Y} {Psi : Y → X}
variable {g : Y → ℝ}
variable {X : Type*} [MeasurableSpace X] (mu : Measure X)

set_option maxHeartbeats 1000000 in
theorem solution :
    ∀ᵐ p ∂(BookProof.ScalaronDensitized.physMeasure.prod mu),
      qgProdSquare (qgProdSqrt p) = p := by

  have hpos : ∀ᵐ e ∂BookProof.ScalaronDensitized.physMeasure, 0 < e :=
    ae_restrict_mem measurableSet_Ioi
  filter_upwards [Measure.quasiMeasurePreserving_fst.ae hpos] with p hp
  have hsq : Real.sqrt p.1 ^ 2 = p.1 := Real.sq_sqrt hp.le
  simp [qgProdSqrt, qgProdSquare, qgSquare, Prod.map, hsq]
