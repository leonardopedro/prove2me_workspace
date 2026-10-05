-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.hamPolyL_numPoly
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_coreD_coreD_eq
import Theorems.Thm_BookProof_HermiteLadder_hamPolyL_apply
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
theorem solution (p : MvPolynomial (Fin d) ℂ) :
    hamPolyL Finset.univ (numPoly d) p = (∑ i, crePoly i (annPoly i p)) + p := by

  have hsum : (∑ _i : Fin d, (C (1 / 2 : ℂ) : MvPolynomial (Fin d) ℂ) * p)
      + C (((1 - (d : ℝ) / 2 : ℝ)) : ℂ) * p = p := by
    rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, ← mul_assoc,
      ← add_mul]
    have hc : ((d : MvPolynomial (Fin d) ℂ)) * C (1 / 2 : ℂ) + C (((1 - (d : ℝ) / 2 : ℝ)) : ℂ)
        = 1 := by
      rw [show ((d : MvPolynomial (Fin d) ℂ)) = C (d : ℂ) from (map_natCast C d).symm, ← C_mul,
        ← C_add]
      rw [show ((d : ℂ) * (1 / 2) + (((1 - (d : ℝ) / 2 : ℝ)) : ℂ)) = 1 by push_cast; ring]
      rfl
    rw [hc, one_mul]
  rw [hamPolyL_apply, kinPolyS, numPoly, add_mul, Finset.sum_mul]
  rw [← Finset.sum_congr rfl fun i _ => coreD_coreD_eq i p]
  simp only [Finset.sum_sub_distrib, Finset.sum_add_distrib, Finset.sum_neg_distrib]
  linear_combination hsum
