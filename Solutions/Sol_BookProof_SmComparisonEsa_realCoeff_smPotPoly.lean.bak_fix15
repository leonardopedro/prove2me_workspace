-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.realCoeff_smPotPoly
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Theorems.Thm_BookProof_SmComparisonEsa_realCoeff_smPhi
import Theorems.Thm_BookProof_SmComparisonEsa_realCoeff_C_ofReal
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_add
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_mul
import Theorems.Thm_BookProof_YangMillsHermite_RealCoeff_sum
open BookProof.SmComparisonEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (c0 : ℝ) : RealCoeff (smPotPoly P c0) :=
  ((RealCoeff.sum fun r _ => (realCoeff_smPhi P r).mul (realCoeff_smPhi P r)).add
        realCoeff_smQPoly).add (realCoeff_C_ofReal c0)
