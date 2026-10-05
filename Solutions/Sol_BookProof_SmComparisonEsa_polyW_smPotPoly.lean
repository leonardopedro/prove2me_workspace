-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.polyW_smPotPoly
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Theorems.Thm_BookProof_SmComparisonEsa_realCoeff_smPhi
import Theorems.Thm_BookProof_DegSchrodinger_polyW_ofReal
open BookProof.SmComparisonEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (c0 : ℝ) (x : Vd 163) :
    polyW (smPotPoly P c0) x
      = (∑ r : Fin 49, (polyW (smPhi P r) x) ^ 2)
        + (∑ m : Fin 40, (x (smCoord m)) ^ 2) + c0 := by

  have hphi : ∀ r : Fin 49, MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (smPhi P r)
      = ((polyW (smPhi P r) x : ℝ) : ℂ) :=
    fun r => (polyW_ofReal (realCoeff_smPhi P r) x).symm
  have key : MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (smPotPoly P c0)
      = (∑ r : Fin 49, ((polyW (smPhi P r) x : ℝ) : ℂ) ^ 2)
        + (∑ m : Fin 40, ((x (smCoord m) : ℝ) : ℂ) ^ 2) + ((c0 : ℝ) : ℂ) := by
    simp only [smPotPoly, map_add, map_sum, map_mul, MvPolynomial.eval_C, smQPoly,
      MvPolynomial.eval_X, hphi, sq]
  have hcast : (∑ r : Fin 49, ((polyW (smPhi P r) x : ℝ) : ℂ) ^ 2)
        + (∑ m : Fin 40, ((x (smCoord m) : ℝ) : ℂ) ^ 2) + ((c0 : ℝ) : ℂ)
      = (((∑ r : Fin 49, (polyW (smPhi P r) x) ^ 2)
          + (∑ m : Fin 40, (x (smCoord m)) ^ 2) + c0 : ℝ) : ℂ) := by
    push_cast
    ring
  rw [polyW, key, hcast, Complex.ofReal_re]
