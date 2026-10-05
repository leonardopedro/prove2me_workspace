-- Generated from ChapterYangMillsNonAbelianEsa.lean — solution of BookProof.YangMillsNonAbelianEsa.polyW_weylPotPoly
import Mathlib
import Definitions.Def_ChapterYangMillsNonAbelianEsa
import Theorems.Thm_BookProof_DegSchrodinger_polyW_ofReal
open BookProof.YangMillsNonAbelianEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.TensorCore BookProof.DirectSumEsa BookProof.SecondQuantizationCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {d : ℕ}
variable {d k r : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {Φ : Fin r → MvPolynomial (Fin d) ℂ} (hΦ : ∀ j, RealCoeff (Φ j))
    (x : Vd d) : polyW (weylPotPoly Φ) x = (∑ j : Fin r, (polyW (Φ j) x) ^ 2) + 1 := by

  have hphi : ∀ j : Fin r, MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (Φ j)
      = ((polyW (Φ j) x : ℝ) : ℂ) :=
    fun j => (polyW_ofReal (hΦ j) x).symm
  have key : MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (weylPotPoly Φ)
      = (∑ j : Fin r, ((polyW (Φ j) x : ℝ) : ℂ) ^ 2) + ((1 : ℝ) : ℂ) := by
    simp only [weylPotPoly, map_add, map_sum, map_mul, MvPolynomial.eval_C, hphi, sq]
  have hcast : (∑ j : Fin r, ((polyW (Φ j) x : ℝ) : ℂ) ^ 2) + ((1 : ℝ) : ℂ)
      = (((∑ j : Fin r, (polyW (Φ j) x) ^ 2) + 1 : ℝ) : ℂ) := by
    push_cast
    ring
  rw [polyW, key, hcast, Complex.ofReal_re]
