-- Generated from ChapterHermiteProductBasis.lean — solution of BookProof.HermiteProductBasis.hermiteMvNorm_sub_single
import Mathlib
import Definitions.Def_ChapterHermiteProductBasis
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvNorm_add_single
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteProductBasis








open MeasureTheory MvPolynomial BookProof.HermiteCore BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {i : Fin d} {a : Fin d →₀ ℕ} (h : 1 ≤ a i) :
    hermiteMvNorm a = hermiteMvNorm (a - Finsupp.single i 1) * Real.sqrt ((a i : ℝ)) := by

  classical
  have hb : a = (a - Finsupp.single i 1) + Finsupp.single i 1 := by
    ext j
    by_cases hj : j = i
    · subst hj; simp; omega
    · simp [hj]
  have hbi : ((a - Finsupp.single i 1 : Fin d →₀ ℕ) i : ℝ) + 1 = (a i : ℝ) := by
    rw [show (a - Finsupp.single i 1 : Fin d →₀ ℕ) i = a i - 1 by simp [Finsupp.tsub_apply]]
    have : ((a i - 1 : ℕ) : ℝ) = (a i : ℝ) - 1 := by
      push_cast [Nat.cast_sub h]
      ring
    rw [this]
    ring
  calc hermiteMvNorm a
      = hermiteMvNorm ((a - Finsupp.single i 1) + Finsupp.single i 1) := by rw [← hb]
    _ = hermiteMvNorm (a - Finsupp.single i 1)
          * Real.sqrt (((a - Finsupp.single i 1 : Fin d →₀ ℕ) i : ℝ) + 1) :=
        hermiteMvNorm_add_single i _
    _ = hermiteMvNorm (a - Finsupp.single i 1) * Real.sqrt ((a i : ℝ)) := by rw [hbi]
