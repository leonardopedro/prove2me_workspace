-- Generated from ChapterQgSymmetricSector.lean — solution of BookProof.QgSymmetricSector.qgFull_hbosonicFock_esa
import Mathlib
import Definitions.Def_ChapterQgSymmetricSector
import Theorems.Thm_BookProof_QgSymmetricSector_qgFullOp_symmetricOn
import Theorems.Thm_BookProof_QgSymmetricSector_qgFullOp_esa
import Theorems.Thm_BookProof_FockStatistics_hbosonicFock_esa
import Theorems.Thm_BookProof_QgTruncationResolvent_secCore_dense
open BookProof.QgSymmetricSector




open scoped TensorProduct
open BookProof.ScalaronOuterFockFL BookProof.QgVielbeinModeInstance
open BookProof.QgContinuumModeInstance BookProof.QgVielbeinScalaronGaugeFL
open BookProof.FarisLavine BookProof.GraphCore BookProof.TensorCore BookProof.FockStatistics
open BookProof.PermSector BookProof.ReducedEsa BookProof.GroupAverage BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore BookProof.ScalaronFiberFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (W : WallPot) (g : ℝ) :
    EssentiallySelfAdjointOn (hbosonicFockDom qgSecSpace (secCore (ι :=
  hbosonicFock_esa (Hs := qgSecSpace) (qgFullOp W g) secCore_dense
      (qgFullOp_symmetricOn W g) (qgFullOp_esa W g)
