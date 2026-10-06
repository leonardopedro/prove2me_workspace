-- Generated from ChapterSmHamiltonian.lean — solution of BookProof.SmHamiltonian.realCoeff_smMagG
import Mathlib
import Definitions.Def_ChapterSmHamiltonian
import Theorems.Thm_BookProof_SmHamiltonian_RealCoeff_sub'
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_add
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_mul
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_smul
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_sum
import Theorems.Thm_BookProof_YangMillsHermite_realCoeff_X
open BookProof.SmHamiltonian




open MvPolynomial
open BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (co : Fin 163 → Fin D) (a : Fin 8) (i : Fin 3) :
    RealCoeff (smMagG P co a i) := by

  refine RealCoeff.smul (RealCoeff.sum fun j _ => RealCoeff.sum fun k _ => RealCoeff.smul ?_)
  refine RealCoeff.add (RealCoeff.sub' (realCoeff_X _) (realCoeff_X _)) ?_
  exact RealCoeff.smul (RealCoeff.sum fun b _ => RealCoeff.sum fun d _ =>
    RealCoeff.smul ((realCoeff_X _).mul (realCoeff_X _)))
