-- Generated from ChapterNsReducedCoreEsa.lean — solution of BookProof.NsReducedCoreEsa.nsRedFullFockHam_esa
import Mathlib
import Definitions.Def_ChapterNsReducedCoreEsa
import Theorems.Thm_BookProof_NsReducedCoreEsa_redHam_esa
import Theorems.Thm_BookProof_DirectSumEsa_dsOp_essentiallySelfAdjointOn
open BookProof.NsReducedCoreEsa




open MvPolynomial
open BookProof.NsFullEuler
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.YangMillsNonAbelianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn nsRedFockCore (nsRedFullFockHam nu k) := dsOp_essentiallySelfAdjointOn _ fun n => redHam_esa nu k n
