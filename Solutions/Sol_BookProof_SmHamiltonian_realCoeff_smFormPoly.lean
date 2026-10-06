-- Generated from ChapterSmHamiltonian.lean — solution of BookProof.SmHamiltonian.realCoeff_smFormPoly
import Mathlib
import Definitions.Def_ChapterSmHamiltonian
import Theorems.Thm_BookProof_SmHamiltonian_realCoeff_smMagG
import Theorems.Thm_BookProof_SmHamiltonian_realCoeff_smMagW
import Theorems.Thm_BookProof_SmHamiltonian_realCoeff_smMagB
import Theorems.Thm_BookProof_SmHamiltonian_realCoeff_smCovD
import Theorems.Thm_BookProof_SmHamiltonian_realCoeff_smWall
open BookProof.SmHamiltonian




open MvPolynomial
open BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (co : Fin 163 → Fin D) (r : SmForm) :
    RealCoeff (smFormPoly P co r) := by

  rcases r with ⟨a, i⟩ | ⟨k, i⟩ | i | ⟨a, i⟩ | u
  · exact realCoeff_smMagG P co a i
  · exact realCoeff_smMagW P co k i
  · exact realCoeff_smMagB co i
  · exact realCoeff_smCovD P co a i
  · exact realCoeff_smWall P co
