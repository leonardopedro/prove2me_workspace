-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.coef_numFun_iterate
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_coef_Lfun_numPoly
import Theorems.Thm_BookProof_HermiteGraphApprox_numFun_iterate_spec
import Theorems.Thm_BookProof_HermiteGraphApprox_memLp_of_cc
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
theorem solution (a : Fin d →₀ ℕ) (k : ℕ) {g : Vd d → ℂ}
    (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g) (hgc : HasCompactSupport g) {v w : L2d d}
    (hv : (v : Vd d → ℂ) =ᵐ[volume] g) (hw : (w : Vd d → ℂ) =ᵐ[volume] (numFun d)^[k] g) :
    coef a w = ((a.degree : ℂ) + 1) ^ k * coef a v := by

  induction k generalizing w with
  | zero =>
      have h : w = v := Lp.ext (hw.trans hv.symm)
      simp [h]
  | succ k ih =>
      obtain ⟨h1, h2⟩ := numFun_iterate_spec k hg hgc
      have hw' := (memLp_of_cc h1.continuous h2).coeFn_toLp
      rw [Function.iterate_succ_apply'] at hw
      rw [coef_Lfun_numPoly a h1 h2 hw' hw, ih hw', pow_succ]
      ring
