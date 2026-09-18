import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
-- Generated from ChapterHyperbolicQuadraticEsa.lean — solution of BookProof.HyperbolicQuadratic.quadOp_not_bounded
import Mathlib
import Definitions.Def_ChapterHyperbolicQuadraticEsa
import Theorems.Thm_BookProof_HyperbolicQuadratic_quadOp_hermiteMvLp
import Theorems.Thm_BookProof_HyperbolicQuadratic_quadSymbol_single
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvLp_mem_core
open BookProof.HyperbolicQuadratic




open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin d → ℝ) {i : Fin d} (hci : c i ≠ 0) :
    ¬ ∃ C : ℝ, ∀ f : polyGaussCore (d := d), ‖quadOp c f‖ ≤ C * ‖(f : L2d d)‖ := by

  classical
  rintro ⟨C, hC⟩
  obtain ⟨n, hn⟩ := exists_nat_gt ((C + |∑ j, c j * (1/2)|) / |c i|)
  set a : Fin d →₀ ℕ := Finsupp.single i n with ha
  have hnorm : ‖hermiteMvLp (d := d) a‖ = 1 := orthonormal_hermiteMvLp.norm_eq_one a
  have h := hC ⟨hermiteMvLp a, hermiteMvLp_mem_core a⟩
  rw [quadOp_hermiteMvLp c a (hermiteMvLp_mem_core a), norm_smul] at h
  simp only [hnorm, mul_one, Complex.norm_real, Real.norm_eq_abs] at h
  have hci' : 0 < |c i| := abs_pos.mpr hci
  have hlow : |c i| * (n : ℝ) - |∑ j, c j * (1/2)| ≤ |quadSymbol c a| := by
    have htri : |c i * (n : ℝ)|
        ≤ |c i * (n : ℝ) + ∑ j, c j * (1/2)| + |∑ j, c j * (1/2)| := by
      have h1 : |c i * (n : ℝ) + ∑ j, c j * (1/2)| + |-(∑ j, c j * (1/2))|
          ≥ |c i * (n : ℝ) + ∑ j, c j * (1/2) + -(∑ j, c j * (1/2))| := abs_add_le _ _
      simpa using h1
    have habs : |c i * (n : ℝ)| = |c i| * (n : ℝ) := by
      rw [abs_mul, Nat.abs_cast]
    rw [ha, quadSymbol_single]
    linarith [htri, habs.symm.le, habs.le]
  have hbig : C < |c i| * (n : ℝ) - |∑ j, c j * (1/2)| := by
    have hmul : (C + |∑ j, c j * (1/2)|) < |c i| * (n : ℝ) := by
      rw [div_lt_iff₀ hci'] at hn
      linarith [hn]
    linarith
  linarith [h, hlow, hbig]
