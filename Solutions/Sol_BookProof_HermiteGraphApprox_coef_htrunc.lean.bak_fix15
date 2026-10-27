-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.coef_htrunc
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
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
theorem solution (v : L2d d) (F : Finset (Fin d →₀ ℕ)) (b : Fin d →₀ ℕ) :
    coef b (htrunc v F) = if b ∈ F then coef b v else 0 := by

  classical
  rw [htrunc, coef, inner_sum]
  simp only [inner_smul_right, inner_hermiteMvLp, mul_ite, mul_one, mul_zero]
  rw [Finset.sum_ite_eq]
