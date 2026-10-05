-- Generated from ChapterSmOuterFock.lean — solution of BookProof.SmOuterFock.smFockHam_symmetricOn
import Mathlib
import Definitions.Def_ChapterSmOuterFock
import Theorems.Thm_BookProof_SmOuterFock_smSectorHam_symmetricOn
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
theorem solution (P : SmParams) :
    SymmetricOn smFockCore (smFockHam P) := dsOp_symmetricOn _ fun n => smSectorHam_symmetricOn P n
