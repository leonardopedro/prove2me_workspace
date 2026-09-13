-- Generated from ChapterHermiteBandCalculus.lean — solution of BookProof.HermiteBand.crePoly_hpsi
import Mathlib
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.HermiteBand








noncomputable section

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin d) (α : Fin d →₀ ℕ) :
    crePoly i (hpsi α) = ((Real.sqrt ((α i : ℝ) + 1) : ℝ) : ℂ) • hpsi (α + Finsupp.single i 1) := by

  have hne : ((hermiteMvNorm α : ℝ) : ℂ) ≠ 0 := hermiteMvNorm_ne_zero α
  have hne' : ((hermiteMvNorm (α + Finsupp.single i 1) : ℝ) : ℂ) ≠ 0 :=
    hermiteMvNorm_ne_zero _
  rw [hpsi, map_smul, crePoly_hermiteMv, hpsi, smul_smul]
  congr 1
  rw [hermiteMvNorm_add_single]
  have hs : (0 : ℝ) < Real.sqrt ((α i : ℝ) + 1) := Real.sqrt_pos.mpr (by positivity)
  have hsc : ((Real.sqrt ((α i : ℝ) + 1) : ℝ) : ℂ) ≠ 0 := by
    exact_mod_cast ne_of_gt hs
  push_cast
  field_simp
