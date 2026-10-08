-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.realCoeff_C_ofReal
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
open BookProof.SmComparisonEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {d : ℕ} (c : ℝ) :
    RealCoeff (C ((c : ℝ) : ℂ) : MvPolynomial (Fin d) ℂ) := realCoeff_C_real_prime c
