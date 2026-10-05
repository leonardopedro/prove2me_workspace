-- Generated from ChapterNsSymmetricSector.lean — solution of BookProof.NsSymmetricSector.nsSpOp_symmetricOn
import Mathlib
import Definitions.Def_ChapterNsSymmetricSector
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
    SymmetricOn (polyGaussCore (d := 6)) (nsSpOp nu k) := spHam_symmetricOn (coreRepPoly 6) nu k
