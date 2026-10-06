-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.mixOp_hermiteCore
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Theorems.Thm_BookProof_HermiteProductBasis_hermiteMvLp_mem_core
import Theorems.Thm_BookProof_HyperbolicQuadratic_quadOp_hermiteMvLp
import Theorems.Thm_BookProof_QuadratureEsa_foOp_hermiteCore
import Theorems.Thm_BookProof_QuadratureEsa_hermiteCore_eq
open BookProof.HermiteCarleman




open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

variable {d : ℕ}
variable {u : (Fin d →₀ ℕ) → ℂ} {lam : (Fin d →₀ ℕ) → ℝ} {amp : Fin d → ℂ} {z : ℂ}

set_option maxHeartbeats 1000000 in
theorem solution (c b b' : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    mixOp c b b' (hermiteCore a)
      = ((quadSymbol c a : ℝ) : ℂ) • hermiteMvLp a
        + ∑ i, ((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
                  • hermiteMvLp (a + Finsupp.single i 1)
                + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
                  • hermiteMvLp (a - Finsupp.single i 1)) := by

  have hmem : hermiteMvLp (d := d) a ∈ polyGaussCore (d := d) := hermiteMvLp_mem_core a
  rw [mixOp, LinearMap.add_apply, foOp_hermiteCore, ← hermiteCore_eq a hmem,
    quadOp_hermiteMvLp c a hmem]
