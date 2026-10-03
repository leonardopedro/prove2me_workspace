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

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (a : Fin d →₀ ℕ) :
    ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (annPoly i (hermiteMv a))
      = ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ) • hermiteMvLp (a - Finsupp.single i 1) := by

  rw [annPoly_apply, pderiv_hermiteMv, ← pgMap_apply, map_smul, pgMap_apply,
    pgLp_hermiteMv_eq (a - Finsupp.single
