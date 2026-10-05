-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.coef_Lfun_numPoly
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_inner_pgLp_hamPolyL
import Theorems.Thm_BookProof_HermiteGraphApprox_realCoeff_numPoly
import Theorems.Thm_BookProof_HermiteGraphApprox_hamPolyL_numPoly_hermiteMv
import Theorems.Thm_BookProof_HermiteLadder_coef_eq_inner_pgLp
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
theorem solution (a : Fin d →₀ ℕ) {g : Vd d → ℂ}
    (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g) (hgc : HasCompactSupport g) {v w : L2d d}
    (hv : (v : Vd d → ℂ) =ᵐ[volume] g)
    (hw : (w : Vd d → ℂ) =ᵐ[volume] Lfun Finset.univ (polyW (numPoly d)) g) :
    coef a w = ((a.degree : ℂ) + 1) * coef a v := by

  rw [coef_eq_inner_pgLp, coef_eq_inner_pgLp,
    ← inner_pgLp_hamPolyL Finset.univ realCoeff_numPoly (hermiteMv a) hg hgc hv hw,
    hamPolyL_numPoly_hermiteMv, pgLp_smul', inner_smul_left]
  have h : (starRingEnd ℂ) ((a.degree : ℂ) + 1) = (a.degree : ℂ) + 1 := by simp
  rw [h]
  ring
