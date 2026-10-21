-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.smFlN_esa_one_le
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Theorems.Thm_BookProof_SmComparisonEsa_realCoeff_smPotPoly
import Theorems.Thm_BookProof_SmComparisonEsa_one_le_polyW_smPotPoly
import Theorems.Thm_BookProof_SmComparisonEsa_smFlN_eq_hamCoreS
import Theorems.Thm_BookProof_DegSchrodinger_continuous_polyW
import Theorems.Thm_BookProof_DegSchrodinger_expBounded_polyW
import Theorems.Thm_BookProof_HermiteGraphApprox_hamCoreS_esa
open BookProof.SmComparisonEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) {c0 : ℝ} (hc0 : 1 ≤ c0) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 163)) (smFlN P c0) := by

  rw [smFlN_eq_hamCoreS P c0]
  exact hamCoreS_esa (smPotPoly P c0) (realCoeff_smPotPoly P c0)
    (one_le_polyW_smPotPoly P hc0) smS
