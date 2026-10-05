-- Generated from ChapterNsLagrangianOuterFockEsa.lean — solution of BookProof.NsLagrangianOuterFock.lagKoopman_bosonicFock_esa_of_comparison_esa
import Mathlib
import Definitions.Def_ChapterNsLagrangianOuterFockEsa
import Theorems.Thm_BookProof_FockStatistics_bosonicFock_esa
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagKoopmanOp_symmetricOn
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagKoopman_esa_of_comparison_esa
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

variable {K : Type*} [Fintype K] (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution
    (hN : EssentiallySelfAdjointOn (polyGaussCore (d := lagDim K)) (lagComparison S)) :
    EssentiallySelfAdjointOn (bosonicFockDom (L2dSpace (lagDim K)) (polyGaussCore (d := lagDim K)))
      (bosonicFockOp (L2dSpace (lagDim K)) (polyGaussCore (d := lagDim K)) (lagKoopmanOp S)) :=
  bosonicFock_esa (Hs := L2dSpace (lagDim K)) (lagKoopmanOp S) polyGaussCore_dense
      (lagKoopmanOp_symmetricOn S) (lagKoopman_esa_of_comparison_esa S hN)
