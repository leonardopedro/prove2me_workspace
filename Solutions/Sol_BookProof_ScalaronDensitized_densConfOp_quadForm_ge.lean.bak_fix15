-- Generated from ChapterScalaronDensitizedTransfer.lean — solution of BookProof.ScalaronDensitized.densConfOp_quadForm_ge
import Mathlib
import Definitions.Def_ChapterScalaronDensitizedTransfer
import Theorems.Thm_BookProof_ScalaronDensitized_densConfV_ge
import Theorems.Thm_BookProof_ScalaronDensitized_multOp_quadForm_ge
open BookProof.ScalaronDensitized




open MeasureTheory Set Filter Topology
open BookProof.Starobinsky BookProof.QuantumGravityDensitized
open BookProof.QuantumGravityHalfDensity
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.FockContinuum
open BookProof.FarisLavine BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable (M alpha : ℝ)
variable {X : Type*} [MeasurableSpace X]

set_option maxHeartbeats 1000000 in
theorem solution (halpha : 0 < alpha) (f : densConfCore M alpha) :
    -(M ^ 4 / (16 * alpha)) * ‖(f : Lp ℂ 2 qgSrcMeasure)‖ ^ 2
      ≤ quadForm ((densConfCore M alpha).subtype.comp (densConfOp M alpha)) f :=
  multOp_quadForm_ge qgSrcMeasure (measurable_densConfV M alpha)
      (fun y => densConfV_ge halpha y) f
