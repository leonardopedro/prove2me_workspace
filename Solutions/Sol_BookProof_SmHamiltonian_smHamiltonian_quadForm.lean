-- Generated from ChapterSmHamiltonian.lean — solution of BookProof.SmHamiltonian.smHamiltonian_quadForm
import Mathlib
import Definitions.Def_ChapterSmHamiltonian
import Theorems.Thm_BookProof_SmHamiltonian_smPi_symmetricOn
import Theorems.Thm_BookProof_SmHamiltonian_smField_symmetricOn
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOpDom_quadForm
open BookProof.SmHamiltonian




open MvPolynomial
open BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (x : polyGaussCore (d := 163)) :
    quadForm (smHamiltonian P) x
      = 1 / 2 * (∑ m, ‖((smPi m x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2)
        + 1 / 2 * ∑ r, ‖((smField P r x : polyGaussCore (d := 163)) : L2d 163)‖ ^ 2 := weylOpDom_quadForm smPi_symmetricOn (smField_symmetricOn P) x
