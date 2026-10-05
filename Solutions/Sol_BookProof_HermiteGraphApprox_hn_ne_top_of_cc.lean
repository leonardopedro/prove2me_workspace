-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.hn_ne_top_of_cc
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_numFun_iterate_spec
import Theorems.Thm_BookProof_HermiteGraphApprox_memLp_of_cc
import Theorems.Thm_BookProof_HermiteGraphApprox_coef_numFun_iterate
import Theorems.Thm_BookProof_HermiteGraphApprox_enorm_natCast_complex
import Theorems.Thm_BookProof_HermiteLadder_hn_mono
import Theorems.Thm_BookProof_HermiteLadder_hn_zero_eq
import Theorems.Thm_BookProof_HermiteLadder_wt_zero
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
theorem solution {g : Vd d → ℂ} (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g)
    (hgc : HasCompactSupport g) {v : L2d d} (hv : (v : Vd d → ℂ) =ᵐ[volume] g) (n : ℕ) :
    hn n v ≠ ⊤ := by

  obtain ⟨h1, h2⟩ := numFun_iterate_spec n hg hgc
  have hw := (memLp_of_cc h1.continuous h2).coeFn_toLp
  have heq : hn (2 * n) v = hn 0 ((memLp_of_cc h1.continuous h2).toLp _) := by
    unfold hn
    refine tsum_congr fun a => ?_
    rw [coef_numFun_iterate a n hg hgc hv hw, wt_zero, one_mul, enorm_mul, enorm_pow, mul_pow,
      wt, show ((a.degree : ℂ) + 1) = ((a.degree + 1 : ℕ) : ℂ) by push_cast; ring,
      enorm_natCast_complex, ← pow_mul, mul_comm n 2]
  refine ne_top_of_le_ne_top ?_ (hn_mono (show n ≤ 2 * n by omega) v)
  rw [heq, hn_zero_eq]
  exact ENNReal.ofReal_ne_top
