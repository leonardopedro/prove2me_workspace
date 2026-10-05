-- Generated from ChapterQgSymmetricSector.lean — solution of BookProof.QgSymmetricSector.qgFull_bosonic_core_esa
import Mathlib
import Definitions.Def_ChapterQgSymmetricSector
import Theorems.Thm_BookProof_QgSymmetricSector_qgFullOp_symmetricOn
import Theorems.Thm_BookProof_QgSymmetricSector_qgFullOp_esa
import Theorems.Thm_BookProof_FockStatistics_essentiallySelfAdjointOn_bosonic_core_of_esa
import Theorems.Thm_BookProof_QgTruncationResolvent_secCore_dense
open BookProof.QgSymmetricSector




open scoped TensorProduct
open BookProof.ScalaronOuterFockFL BookProof.QgVielbeinModeInstance
open BookProof.QgContinuumModeInstance
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.FockStatistics
open BookProof.PermSector BookProof.ReducedEsa BookProof.GroupAverage BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore BookProof.ScalaronFiberFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (g : ℝ) (n : ℕ) :
    EssentiallySelfAdjointOn
      (redDom (bosonicProj qgSecSpace n)
        (sectorCore qgSecSpace (secCore (ι :=
  essentiallySelfAdjointOn_bosonic_core_of_esa (Hs := qgSecSpace) (qgFullOp W g)
      secCore_dense (qgFullOp_symmetricOn W g) (qgFullOp_esa W g) (IsGraphCore.refl _) n
