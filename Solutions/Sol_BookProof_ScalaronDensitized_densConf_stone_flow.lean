-- Generated from ChapterScalaronDensitizedTransfer.lean — solution of BookProof.ScalaronDensitized.densConf_stone_flow
import Mathlib
import Definitions.Def_ChapterScalaronDensitizedTransfer
import Theorems.Thm_BookProof_ScalaronDensitized_densConfCore_dense
import Theorems.Thm_BookProof_ScalaronDensitized_densConfOp_symmetricOn
import Theorems.Thm_BookProof_ScalaronDensitized_densConf_esa
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
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
theorem solution :
    ∃ (T : UnboundedSelfAdjoint (Lp ℂ 2 qgSrcMeasure))
      (U : ℝ → (Lp ℂ 2 qgSrcMeasure →L[ℂ] Lp ℂ 2 qgSrcMeasure)),
      IsSelfAdjointExtension
        ((densConfCore M alpha).subtype.comp (densConfOp M alpha)) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ (densConfCore_dense M alpha) (densConfOp_symmetricOn M alpha)
      (densConf_esa M alpha)
