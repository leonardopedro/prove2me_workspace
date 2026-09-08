-- Generated from ChapterHermiteProductBasis.lean — solution of BookProof.HermiteProductBasis.annPoly_hermiteMvLp
import Mathlib
import Definitions.Def_ChapterHermiteProductBasis
import Theorems.Thm_BookProof_HermiteProductBasis_pderiv_hermiteMv
import Theorems.Thm_BookProof_HermiteProductBasis_annPoly_apply
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvNorm_sub_single
import Theorems.Thm_BookProof_HermiteProductBasis_pgMap_apply
open BookProof.HermiteProductBasis








open MeasureTheory MvPolynomial BookProof.HermiteCore BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (annPoly i (hermiteMv a))
      = ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ) • hermiteMvLp (a - Finsupp.single i 1) := by

  rw [annPoly_apply, pderiv_hermiteMv, ← pgMap_apply, map_smul, pgMap_apply,
    pgLp_hermiteMv_eq (a - Finsupp.single i 1), smul_smul, smul_smul]
  rcases Nat.eq_zero_or_pos (a i) with h0 | hpos
  · rw [h0]
    simp
  · congr 1
    have hnorm := hermiteMvNorm_sub_single (i := i) (a := a) hpos
    have hsub_pos := hermiteMvNorm_pos (a - Finsupp.single i 1)
    have hai : (0 : ℝ) < (a i : ℝ) := by exact_mod_cast hpos
    have hsqrt_pos : 0 < Real.sqrt ((a i : ℝ)) := Real.sqrt_pos.mpr hai
    have hsqrt : Real.sqrt ((a i : ℝ)) * Real.sqrt ((a i : ℝ)) = (a i : ℝ) :=
      Real.mul_self_sqrt hai.le
    have hreal : (hermiteMvNorm a)⁻¹ * ((a i : ℝ) * hermiteMvNorm (a - Finsupp.single i 1))
        = Real.sqrt ((a i : ℝ)) := by
      rw [hnorm]
      field_simp
      nlinarith [hsqrt, hsub_pos, hsqrt_pos]
    have := congrArg (fun r : ℝ => ((r : ℝ) : ℂ)) hreal
    push_cast at this ⊢
    linear_combination this
