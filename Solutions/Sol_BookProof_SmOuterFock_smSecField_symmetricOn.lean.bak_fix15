-- Generated from ChapterSmOuterFock.lean — solution of BookProof.SmOuterFock.smSecField_symmetricOn
import Mathlib
import Definitions.Def_ChapterSmOuterFock
import Theorems.Thm_BookProof_SmHamiltonian_realCoeff_smFormPoly
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_symmetricOn_op
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_polySym
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
theorem solution (P : SmParams) (n : ℕ) (r : Fin (n * 49)) :
    SymmetricOn (polyGaussCore (d := n * 163))
      ((polyGaussCore (d := n * 163)).subtype.comp (smSecField P n r)) := (coreRepPoly (n * 163)).symmetricOn_op (mulOp_polySym (realCoeff_smFormPoly P _ _))
