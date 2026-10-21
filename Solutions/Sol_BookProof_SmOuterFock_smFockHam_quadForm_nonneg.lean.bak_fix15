-- Generated from ChapterSmOuterFock.lean — solution of BookProof.SmOuterFock.smFockHam_quadForm_nonneg
import Mathlib
import Definitions.Def_ChapterSmOuterFock
import Theorems.Thm_BookProof_SmOuterFock_smSectorHam_quadForm_nonneg
import Theorems.Thm_BookProof_QgOuterFock_dsOp_quadForm_nonneg
open BookProof.SmOuterFock




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (x : smFockCore) :
    0 ≤ quadForm (smFockHam P) x := dsOp_quadForm_nonneg _ (fun n u => smSectorHam_quadForm_nonneg P n u) x
