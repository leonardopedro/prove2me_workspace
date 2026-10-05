-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.sm_h_esa
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Theorems.Thm_BookProof_SmComparisonEsa_smFlN_esa
import Theorems.Thm_BookProof_SmFarisLavine_sm_h_esa_of_comparison_esa
open BookProof.SmComparisonEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 163)) (smHamiltonian P) := sm_h_esa_of_comparison_esa P (c0 := 1) zero_le_one (smFlN_esa P 1)
