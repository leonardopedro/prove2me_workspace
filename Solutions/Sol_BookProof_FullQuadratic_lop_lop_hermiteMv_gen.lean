-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.lop_lop_hermiteMv_gen
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_FullQuadratic_add_pvec_eq
import Theorems.Thm_BookProof_FullQuadratic_sub_pvec_eq
import Theorems.Thm_BookProof_FullQuadratic_add_sub_single_eq_shiftm
import Theorems.Thm_BookProof_FullQuadratic_add_single_apply_ne
import Theorems.Thm_BookProof_FullQuadratic_smul_shiftm_diag
import Theorems.Thm_BookProof_ModeQuadratic_lop_hermiteMv
open BookProof.FullQuadratic




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (t t' : ℂ) (i j : Fin d) (a : Fin d →₀ ℕ) :
    lop t i (lop t' j (hermiteMv a))
      = hermiteMv (a + pvec i j)
        + (t * (a i : ℂ)) • hermiteMv (shiftm a j i)
        + (t' * (a j : ℂ)) • hermiteMv (shiftm a i j)
        + (t * t' * (a j : ℂ) * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ))
            • hermiteMv (a - pvec i j)
        + (if i = j then t • hermiteMv a else 0) := by

  rw [lop_hermiteMv t' j a, map_add, map_smul, lop_hermiteMv t i (a + Finsupp.single j 1),
    lop_hermiteMv t i (a - Finsupp.single j 1), add_pvec_eq, sub_pvec_eq]
  by_cases hij : i = j
  · subst hij
    rw [if_pos rfl, add_tsub_cancel_right]
    have hs : a - Finsupp.single i 1 + Finsupp.single i 1 = shiftm a i i := rfl
    rw [hs]
    have hd : ((a + Finsupp.single i 1 : Fin d →₀ ℕ) i : ℕ) = a i + 1 := by simp
    rw [hd]
    rw [smul_shiftm_diag t a i]
    push_cast
    module
  · rw [if_neg hij, add_sub_single_eq_shiftm hij, add_single_apply_ne hij]
    have hs : a - Finsupp.single j 1 + Finsupp.single i 1 = shiftm a i j := rfl
    rw [hs]
    push_cast
    module
