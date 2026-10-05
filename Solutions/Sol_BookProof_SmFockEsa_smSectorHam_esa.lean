-- Generated from ChapterSmFockEsa.lean — solution of BookProof.SmFockEsa.smSectorHam_esa
import Mathlib
import Definitions.Def_ChapterSmFockEsa
import Theorems.Thm_BookProof_SmFockEsa_smSecMomIdx_injective
import Theorems.Thm_BookProof_SmFockEsa_smSectorHam_eq_weylPoly
import Theorems.Thm_BookProof_YangMillsNonAbelianEsa_weylPoly_esa
open BookProof.SmFockEsa




open MvPolynomial
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmOuterFock
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.TensorCore BookProof.SecondQuantizationCore
open BookProof.YangMillsNonAbelianEsa

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (n : ℕ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := n * 163)) (smSectorHam P n) := by

  rw [smSectorHam_eq_weylPoly]
  exact weylPoly_esa (smSecMomIdx_injective n) fun r => realCoeff_smFormPoly P _ _
