-- Generated from ChapterSmFockEsa.lean — solution of BookProof.SmFockEsa.smFockHam_esa
import Mathlib
import Definitions.Def_ChapterSmFockEsa
import Theorems.Thm_BookProof_SmFockEsa_smSectorHam_esa
import Theorems.Thm_BookProof_DirectSumEsa_dsOp_essentiallySelfAdjointOn
open BookProof.SmFockEsa




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmOuterFock
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.TensorCore BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) :
    EssentiallySelfAdjointOn smFockCore (smFockHam P) := dsOp_essentiallySelfAdjointOn _ fun n => smSectorHam_esa P n
