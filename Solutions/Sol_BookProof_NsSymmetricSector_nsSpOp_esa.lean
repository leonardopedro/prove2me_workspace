-- Generated from ChapterNsSymmetricSector.lean — solution of BookProof.NsSymmetricSector.nsSpOp_esa
import Mathlib
import Definitions.Def_ChapterNsSymmetricSector
import Theorems.Thm_BookProof_NsSymmetricSector_spHam_esa
open BookProof.NsSymmetricSector




open scoped TensorProduct
open BookProof.NsOneBody BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.GraphCore
open BookProof.TensorCore BookProof.FockStatistics BookProof.PermSector BookProof.ReducedEsa
open BookProof.GroupAverage BookProof.TensorPerm
open BookProof.DirectSumEsa BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 6)) (nsSpOp nu k) := spHam_esa nu k
