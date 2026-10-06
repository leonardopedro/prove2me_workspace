-- Generated from ChapterQgSymmetricSector.lean — solution of BookProof.QgSymmetricSector.qgFullOp_esa
import Mathlib
import Definitions.Def_ChapterQgSymmetricSector
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
    EssentiallySelfAdjointOn (secCore (ι := qgFull_esa_core_fl W g
