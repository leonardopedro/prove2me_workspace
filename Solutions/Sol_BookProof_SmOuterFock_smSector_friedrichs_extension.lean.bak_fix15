-- Generated from ChapterSmOuterFock.lean — solution of BookProof.SmOuterFock.smSector_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterSmOuterFock
import Theorems.Thm_BookProof_SmOuterFock_smSectorHam_symmetricOn
import Theorems.Thm_BookProof_SmOuterFock_smSectorHam_quadForm_nonneg
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
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
    ∃ (Dom : Submodule ℂ (L2d (n * 163))) (A : Dom →ₗ[ℂ] L2d (n * 163)),
      IsPositiveSelfAdjointExtension (smSectorHam P n) A :=
  friedrichs_extension_exists
      ⟨polyGaussCore, smSectorHam P n, smSectorHam_symmetricOn P n,
        smSectorHam_quadForm_nonneg P n⟩
      polyGaussCore_dense
