-- Generated from ChapterSmHamiltonian.lean — solution of BookProof.SmHamiltonian.sm_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterSmHamiltonian
import Theorems.Thm_BookProof_SmHamiltonian_smHamiltonian_symmetricOn
import Theorems.Thm_BookProof_SmHamiltonian_smHamiltonian_quadForm_nonneg
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
open BookProof.SmHamiltonian




open MvPolynomial
open BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) :
    ∃ (Dom : Submodule ℂ (L2d 163)) (A : Dom →ₗ[ℂ] L2d 163),
      IsPositiveSelfAdjointExtension (smHamiltonian P) A :=
  friedrichs_extension_exists
      ⟨polyGaussCore, smHamiltonian P, smHamiltonian_symmetricOn P,
        smHamiltonian_quadForm_nonneg P⟩
      polyGaussCore_dense
