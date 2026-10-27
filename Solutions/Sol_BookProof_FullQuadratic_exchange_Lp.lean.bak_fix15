-- Generated from ChapterFullQuadraticEsa.lean — solution of BookProof.FullQuadratic.exchange_Lp
import Mathlib
import Definitions.Def_ChapterFullQuadraticEsa
import Theorems.Thm_BookProof_CarlemanSimplex_rcm_of_zero
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvNorm_add_single
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvNorm_sub_single
open BookProof.FullQuadratic




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.CarlemanSimplex
open BookProof.ModeQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin d) (a : Fin d →₀ ℕ) (c : ℂ) :
    ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • ((c * (a j : ℂ)) • pgLp (hermiteMv (shiftm a i j)))
      = (c * ((rcm a i j : ℝ) : ℂ)) • hermiteMvLp (shiftm a i j) := by

  rcases Nat.eq_zero_or_pos (a j) with h0 | hpos
  · have hrcm : rcm a i j = 0 := rcm_of_zero h0
    rw [hrcm, h0]
    simp
  · have hle : 1 ≤ a j := hpos
    have hnorm : hermiteMvNorm a
        = hermiteMvNorm (a - Finsupp.single j 1) * Real.sqrt ((a j : ℝ)) :=
      hermiteMvNorm_sub_single hle
    have hshift : hermiteMvNorm (shiftm a i j)
        = hermiteMvNorm (a - Finsupp.single j 1)
            * Real.sqrt ((((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℝ) + 1) := by
      rw [shiftm, hermiteMvNorm_add_single]
    have hsj : Real.sqrt ((a j : ℝ)) * Real.sqrt ((a j : ℝ)) = (a j : ℝ) :=
      Real.mul_self_sqrt (by positivity)
    have hsjne : ((Real.sqrt ((a j : ℝ)) : ℝ) : ℂ) ≠ 0 := by
      simp only [ne_eq, Complex.ofReal_eq_zero]
      have : (0 : ℝ) < Real.sqrt ((a j : ℝ)) := Real.sqrt_pos.mpr (by exact_mod_cast hpos)
      linarith
    have hbne : ((hermiteMvNorm (a - Finsupp.single j 1) : ℝ) : ℂ) ≠ 0 :=
      hermiteMvNorm_ne_zero _
    rw [pgLp_hermiteMv_eq, smul_smul, smul_smul, hshift, rcm, hnorm]
    congr 1
    push_cast
    field_simp
    rw [show ((a j : ℂ)) = ((Real.sqrt ((a j : ℝ)) : ℝ) : ℂ) * ((Real.sqrt ((a j : ℝ)) : ℝ) : ℂ)
      by rw [← Complex.ofReal_mul, hsj]; simp]
    ring
