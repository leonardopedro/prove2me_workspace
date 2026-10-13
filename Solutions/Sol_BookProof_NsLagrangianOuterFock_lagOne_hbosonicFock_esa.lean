-- Generated from ChapterNsLagrangianOuterFockEsa.lean — solution of BookProof.NsLagrangianOuterFock.lagOne_hbosonicFock_esa
import Mathlib
import Definitions.Def_ChapterNsLagrangianOuterFockEsa
import Theorems.Thm_BookProof_NsLagrangianOuterFock_lagOneOp_symmetricOn
import Theorems.Thm_BookProof_NsLagrangianOuterFock_lagOneOp_esa
import Theorems.Thm_BookProof_NsLagrangianOuterFock_lagOne_dense
import Theorems.Thm_BookProof_FockStatistics_hbosonicFock_esa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesLagrangianCanonical
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterTensorGraphCore
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
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.TensorCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (hnu : 0 < nu) (f : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (hbosonicFockDom lagOneSpace (lpFiniteModes Vel))
      (hbosonicFockOp lagOneSpace (lpFiniteModes Vel) (lagOneOp nu hnu f)) :=
  hbosonicFock_esa (Hs := lagOneSpace) (lagOneOp nu hnu f) lagOne_dense
      (lagOneOp_symmetricOn nu hnu f) (lagOneOp_esa nu hnu f)
