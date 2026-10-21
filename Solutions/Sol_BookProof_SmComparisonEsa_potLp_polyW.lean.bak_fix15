-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.potLp_polyW
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Theorems.Thm_BookProof_DegSchrodinger_continuous_polyW
import Theorems.Thm_BookProof_DegSchrodinger_expBounded_polyW
import Theorems.Thm_BookProof_DegSchrodinger_pgFun_mul_polyW
import Theorems.Thm_BookProof_QgHermiteFriedrichs_potLp_coeFn
open BookProof.SmComparisonEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {d : ℕ} {q : MvPolynomial (Fin d) ℂ} (hq : RealCoeff q)
    (p : MvPolynomial (Fin d) ℂ) :
    potLp (polyW q) (continuous_polyW q) (expBounded_polyW q) p = pgLp (q * p) := by

  refine MeasureTheory.Lp.ext ?_
  filter_upwards [potLp_coeFn (polyW q) (continuous_polyW q) (expBounded_polyW q) p,
    pgLp_coeFn (q * p)] with x h1 h2
  rw [h1, h2, pgFun_mul_polyW hq]
