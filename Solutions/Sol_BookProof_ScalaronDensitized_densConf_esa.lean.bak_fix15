-- Generated from ChapterScalaronDensitizedTransfer.lean — solution of BookProof.ScalaronDensitized.densConf_esa
import Mathlib
import Definitions.Def_ChapterScalaronDensitizedTransfer
import Theorems.Thm_BookProof_ScalaronDensitized_densConf_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_FarisLavine_essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn
open BookProof.ScalaronDensitized




open MeasureTheory Set Filter Topology
open BookProof.Starobinsky BookProof.QuantumGravityDensitized
open BookProof.QuantumGravityHalfDensity
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.FockContinuum
open BookProof.FarisLavine BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable (M alpha : ℝ)

set_option maxHeartbeats 1000000 in
theorem solution :
    EssentiallySelfAdjointOn (densConfCore M alpha)
      ((densConfCore M alpha).subtype.comp (densConfOp M alpha)) :=
  (essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn _ _).2
      (densConf_hasZeroDeficiencyOn M alpha)
