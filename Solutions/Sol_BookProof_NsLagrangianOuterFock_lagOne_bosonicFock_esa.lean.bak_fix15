-- Generated from ChapterNsLagrangianOuterFockEsa.lean — solution of BookProof.NsLagrangianOuterFock.lagOne_bosonicFock_esa
import Mathlib
import Definitions.Def_ChapterNsLagrangianOuterFockEsa
import Theorems.Thm_BookProof_NsLagrangianOuterFock_lagOneOp_symmetricOn
import Theorems.Thm_BookProof_NsLagrangianOuterFock_lagOneOp_esa
import Theorems.Thm_BookProof_NsLagrangianOuterFock_lagOne_dense
import Theorems.Thm_BookProof_FockStatistics_bosonicFock_esa
open BookProof.NsLagrangianOuterFock




open scoped TensorProduct
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore
open BookProof.FockStatistics BookProof.PermSector BookProof.ReducedEsa
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsNonAbelianEsa
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LagrangianCanonical
open BookProof.NavierStokesFlow.LagrangianKatoRellich
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.IkebeKato

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (bosonicFockDom lagOneSpace (lpFiniteModes Vel))
      (bosonicFockOp lagOneSpace (lpFiniteModes Vel) (lagOneOp nu hnu f)) :=
  bosonicFock_esa (Hs := lagOneSpace) (lagOneOp nu hnu f) lagOne_dense
      (lagOneOp_symmetricOn nu hnu f) (lagOneOp_esa nu hnu f)
