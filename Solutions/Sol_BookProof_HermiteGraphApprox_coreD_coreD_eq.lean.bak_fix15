-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.coreD_coreD_eq
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteLadder_C_half_add_C_half
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    -coreD i (coreD i p) + C (((1 / 4 : ℝ)) : ℂ) * (X i * X i) * p - C (1 / 2 : ℂ) * p
      = crePoly i (annPoly i p) := by

  have hX : pderiv i (X i * p) = p + X i * pderiv i p := by
    rw [Derivation.leibniz, pderiv_X_self]
    simp only [smul_eq_mul]
    ring
  have hC : pderiv i (C (1 / 2 : ℂ) * (X i * p)) = C (1 / 2 : ℂ) * (p + X i * pderiv i p) := by
    rw [pderiv_C_mul, hX]
  have h1 : (C (1 / 2 : ℂ) : MvPolynomial (Fin d) ℂ) + C (1 / 2 : ℂ) = 1 := C_half_add_C_half
  have h2 : (C (1 / 2 : ℂ) : MvPolynomial (Fin d) ℂ) * C (1 / 2 : ℂ) = C (((1 / 4 : ℝ)) : ℂ) := by
    rw [← C_mul]
    congr 1
    push_cast
    norm_num
  simp only [coreD, map_sub, hC, crePoly_apply, annPoly_apply]
  linear_combination (X i * pderiv i p) * h1 - (X i * X i * p) * h2
