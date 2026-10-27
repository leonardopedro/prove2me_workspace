-- Generated from ChapterScalaronDensitizedTransfer.lean — solution of BookProof.ScalaronDensitized.physConf_stone_flow
import Mathlib
import Definitions.Def_ChapterScalaronDensitizedTransfer
import Theorems.Thm_BookProof_ScalaronDensitized_physConfCore_dense
import Theorems.Thm_BookProof_ScalaronDensitized_physConfOp_symmetricOn
import Theorems.Thm_BookProof_ScalaronDensitized_physConf_esa
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
    ∃ (T : UnboundedSelfAdjoint (Lp ℂ 2 physMeasure))
      (U : ℝ → (Lp ℂ 2 physMeasure →L[ℂ] Lp ℂ 2 physMeasure)),
      IsSelfAdjointExtension
        ((physConfCore M alpha).subtype.comp (physConfOp M alpha)) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ (physConfCore_dense M alpha) (physConfOp_symmetricOn M alpha)
      (physConf_esa M alpha)
