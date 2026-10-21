-- Generated from ChapterScalaronDensitizedTransfer.lean — solution of BookProof.ScalaronDensitized.physConf_hasZeroDeficiencyOn_transfer
import Mathlib
import Definitions.Def_ChapterScalaronDensitizedTransfer
import Theorems.Thm_BookProof_ScalaronDensitized_halfDensityUnitary_mem_densConfCore
import Theorems.Thm_BookProof_ScalaronDensitized_halfDensityUnitary_densConfCore_surjective
import Theorems.Thm_BookProof_ScalaronDensitized_halfDensityUnitary_intertwines
import Theorems.Thm_BookProof_ScalaronDensitized_densConf_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_QuantumGravityHalfDensity_qg_halfDensity_transfer
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
    HasZeroDeficiencyOn (physConfCore M alpha) (physConfOp M alpha) :=
  qg_halfDensity_transfer (halfDensityUnitary_mem_densConfCore M alpha)
      (halfDensityUnitary_densConfCore_surjective M alpha)
      (halfDensityUnitary_intertwines M alpha) (densConf_hasZeroDeficiencyOn M alpha)
