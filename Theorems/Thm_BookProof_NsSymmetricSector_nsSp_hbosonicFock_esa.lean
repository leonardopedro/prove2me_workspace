-- Generated from ChapterNsSymmetricSector.lean — theorem BookProof.NsSymmetricSector.nsSp_hbosonicFock_esa
import Definitions.Def_ChapterNsOneBodyDGamma
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Mathlib
import Definitions.Def_ChapterNsSymmetricSector
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterScalarDGammaEsa
open BookProof.HermiteProductCore
open BookProof.TensorCore



open scoped TensorProduct
open BookProof.NsOneBody BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.GraphCore
open BookProof.TensorCore BookProof.PermSector BookProof.ReducedEsa
open BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore

noncomputable section

theorem BookProof.NsSymmetricSector.nsSp_hbosonicFock_esa (nu : ℝ) (k : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (hbosonicFockDom (L2dSpace 6) (polyGaussCore (d := 6)))
      (hbosonicFockOp (L2dSpace 6) (polyGaussCore (d := 6)) (nsSpOp nu k)) := by sorry
