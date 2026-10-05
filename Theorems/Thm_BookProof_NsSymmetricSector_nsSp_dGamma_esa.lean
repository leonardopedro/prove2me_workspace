-- Generated from ChapterNsSymmetricSector.lean — theorem BookProof.NsSymmetricSector.nsSp_dGamma_esa
import Definitions.Def_ChapterNsOneBodyDGamma
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib
import Definitions.Def_ChapterNsSymmetricSector
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.NsSymmetricSector



open scoped TensorProduct
open BookProof.NsOneBody BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.GraphCore
open BookProof.TensorCore BookProof.FockStatistics BookProof.PermSector BookProof.ReducedEsa
open BookProof.GroupAverage BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa

noncomputable section

theorem BookProof.NsSymmetricSector.nsSp_dGamma_esa (nu : ℝ) (k : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn
      (dsCore (fun n : ℕ => fockSectorCore (L2dSpace 6) (polyGaussCore (d := 6))
        (polyGaussCore (d := 6)) n))
      (dGammaCoreOp (L2dSpace 6) (polyGaussCore (d := 6)) (nsSpOp nu k)
        (polyGaussCore (d := 6))) := by sorry
