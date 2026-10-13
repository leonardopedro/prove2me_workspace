-- Generated from ChapterNsSymmetricSector.lean — solution of BookProof.NsSymmetricSector.spHam_esa
import Mathlib
import Definitions.Def_ChapterNsSymmetricSector
import Theorems.Thm_BookProof_NsSymmetricSector_spHam_eq_weylPoly
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_weylPoly_esa
import Definitions.Def_ChapterNsOneBodyDGamma
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterGraphCoreTransfer
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterFockStatisticsCompletion
import Definitions.Def_ChapterPermutationSectorEsa
import Definitions.Def_ChapterReducingSubspaceEsa
import Definitions.Def_ChapterGroupAverageEsa
import Definitions.Def_ChapterTensorPermutation
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
open BookProof.NsSymmetricSector




open scoped TensorProduct
open BookProof.NsOneBody BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.GraphCore
open BookProof.TensorCore BookProof.FockStatistics BookProof.PermSector BookProof.ReducedEsa
open BookProof.GroupAverage BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 6)) (spHam (coreRepPoly 6) nu k) := by

  rw [spHam_eq_weylPoly]
  exact weylPoly_esa Function.injective_id fun r => realCoeff_spFormPoly nu k r
