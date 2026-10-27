-- Generated from ChapterSmOuterFock.lean — solution of BookProof.SmOuterFock.smSectorHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterSmOuterFock
import Theorems.Thm_BookProof_SmOuterFock_smSecPi_symmetricOn
import Theorems.Thm_BookProof_SmOuterFock_smSecField_symmetricOn
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_symmetricOn
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
theorem solution (P : SmParams) (n : ℕ) :
    SymmetricOn (polyGaussCore (d := n * 163)) (smSectorHam P n) := weylOpDom_symmetricOn (smSecPi_symmetricOn n) (smSecField_symmetricOn P n)
