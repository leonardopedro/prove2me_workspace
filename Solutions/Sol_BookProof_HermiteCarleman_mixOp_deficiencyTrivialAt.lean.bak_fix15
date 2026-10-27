-- Generated from ChapterHermiteCarlemanEsa.lean — solution of BookProof.HermiteCarleman.mixOp_deficiencyTrivialAt
import Mathlib
import Definitions.Def_ChapterHermiteCarlemanEsa
import Theorems.Thm_BookProof_HermiteCarleman_ladder_eq_zero
import Theorems.Thm_BookProof_HermiteCarleman_mixOp_hermiteCore
import Theorems.Thm_BookProof_HyperbolicQuadratic_hermiteMvLp_total
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
theorem solution (c b b' : Fin d → ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (polyGaussCore (d := d)) (mixOp c b b') z := by

  classical
  intro w hw
  set u : (Fin d →₀ ℕ) → ℂ := fun a => (inner ℂ (hermiteMvLp (d := d) a) w : ℂ) with hu
  have hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ ‖w‖ ^ 2 := fun F =>
    Orthonormal.sum_inner_products_le (𝕜 := ℂ) w (orthonormal_hermiteMvLp (d := d))
  have hrec : LadderRec u (quadSymbol c) (foAmp b b') z := by
    intro a
    have h := hw (hermiteCore a)
    rw [mixOp_hermiteCore c b b' a, inner_add_left, inner_smul_left, Complex.conj_ofReal,
      sum_inner] at h
    rw [hermiteCore_coe] at h
    have hterm : ∀ i : Fin d,
        (inner ℂ (((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
              • hermiteMvLp (d := d) (a + Finsupp.single i 1)
            + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
              • hermiteMvLp (d := d) (a - Finsupp.single i 1))) w : ℂ)
        = (starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ)
            * u (a + Finsupp.single i 1)
          + foAmp b b' i * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ) * u (a - Finsupp.single i 1) := by
      intro i
      rw [inner_add_left, inner_smul_left, inner_smul_left]
      simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal, hu]
    rw [Finset.sum_congr rfl (fun i _ => hterm i)] at h
    exact h
  have hzero : ∀ a, u a = 0 := ladder_eq_zero hz hbes hrec
  exact hermiteMvLp_total w fun a => hzero a
