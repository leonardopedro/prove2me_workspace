-- Generated from ChapterNsLagrangianOuterFockEsa.lean — solution of BookProof.NsLagrangianOuterFock.lagKoopman_dGamma_esa_of_comparison_esa
import Mathlib
import Definitions.Def_ChapterNsLagrangianOuterFockEsa
import Theorems.Thm_BookProof_EsaOneParticle_dGamma_essentiallySelfAdjointOn_of_esa
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagKoopmanOp_symmetricOn
import Theorems.Thm_BookProof_NsLagrangianDetFL_lagKoopman_esa_of_comparison_esa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
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
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore

noncomputable section

variable {K : Type*} [Fintype K] (S : LagNsData K)

set_option maxHeartbeats 1000000 in
theorem solution
    (hN : EssentiallySelfAdjointOn (polyGaussCore (d := lagDim K)) (lagComparison S)) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore (L2dSpace (lagDim K))
        (polyGaussCore (d := lagDim K)) (polyGaussCore (d := lagDim K)) n))
      (dGammaCoreOp (L2dSpace (lagDim K)) (polyGaussCore (d := lagDim K))
        (lagKoopmanOp S) (polyGaussCore (d := lagDim K))) :=
  EsaOneParticle.dGamma_essentiallySelfAdjointOn_of_esa (Hs := L2dSpace (lagDim K))
      (lagKoopmanOp S) polyGaussCore_dense (lagKoopmanOp_symmetricOn S)
      (lagKoopman_esa_of_comparison_esa S hN)
