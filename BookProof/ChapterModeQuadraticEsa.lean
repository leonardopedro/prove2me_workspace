import Mathlib
import BookProof.ChapterCarlemanTwoStep

/-!
# The general mode-diagonal quadratic Hamiltonian on the Gauss–polynomial core

`BookProof.ChapterHermiteCarlemanEsa` proves essential self-adjointness, on the plain
Gauss–polynomial (product Hermite) core of `L²(ℝᵈ)`, of

`∑ᵢ cᵢ(πᵢ² + xᵢ²/4) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

for **arbitrary** real `c, b, b'`.  The quadratic part there is the *harmonic* one: in
each mode it is a multiple of the harmonic oscillator `πᵢ² + xᵢ²/4`, which is diagonal on
the Hermite basis.  The one-mode real quadratic forms make up a three-dimensional space,
spanned by `πᵢ²`, `xᵢ²` and the squeezing (dilation) generator `½(xᵢπᵢ + πᵢxᵢ)`, and
only a one-dimensional subspace of it is diagonal.

This module removes that last restriction: for **arbitrary** real `p, q, s, b, b'` the
operator

`H = ∑ᵢ (pᵢπᵢ² + qᵢxᵢ² + sᵢ·½(xᵢπᵢ + πᵢxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

is essentially self-adjoint on the plain Gauss–polynomial core.  Every real quadratic
Hamiltonian which does not couple distinct modes is of this form — elliptic, hyperbolic
or parabolic in each mode, with any signs, with degenerate modes allowed, and with an
arbitrary constant force and boost on top.  In particular (taking `p = q = b = b' = 0`,
`s = 1`) the generator of dilations `½∑ᵢ(xᵢπᵢ + πᵢxᵢ)` is essentially self-adjoint on the
core.

## What is proved

* `lop`, `lop_hermiteMv`, `lop_lop_hermiteMv` — the two-step ladder algebra.  Both `xᵢ`
  and `πᵢ` are of the form `aᵢ† + t aᵢ` up to a scalar, so a product of two of them moves
  the `i`-th excitation number by `0` or `±2`; the `±2` amplitudes are `√((αᵢ+1)(αᵢ+2))`
  and `√(αᵢ(αᵢ−1))`, of size `O(αᵢ)`.
* `mqQuadPoly`, `mqPoly`, `mqOp` — the Hamiltonian, assembled from Weyl-ordered products
  of the canonical pair, hence symmetric on the core (`mqOp_symmetric`).
* `mqQuadPoly_hermiteMv`, `mqOp_hermiteCore` — the ladder form of the Hamiltonian: a real
  diagonal `∑ᵢ(qᵢ + pᵢ/4)(2αᵢ+1)`, a two-step amplitude `qᵢ − pᵢ/4 + i sᵢ/2`, and the
  one-step amplitude `bᵢ + i b'ᵢ/2` of the first-order part.
* `mqOp_deficiencyTrivialAt`, `mqOp_essentiallySelfAdjoint` — **the headline**, by the
  two-step Carleman criterion `BookProof.CarlemanTwoStep.ladder2_eq_zero`.
* `mqOp_stone_flow` — the resulting complete unitary flow, by Stone's theorem.
* `dilation_essentiallySelfAdjoint`, `dilation_stone_flow` — the corollary for the
  generator of dilations.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.ModeQuadratic

open Finset MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.FarisLavine
open BookProof.HyperbolicQuadratic
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.QuadratureEsa
open BookProof.CarlemanTwoStep
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

/-! ## 1. Two-step multi-index arithmetic -/

theorem add_single_one_one (i : Fin d) (a : Fin d →₀ ℕ) :
    a + Finsupp.single i 1 + Finsupp.single i 1 = a + Finsupp.single i 2 := by
  ext j
  by_cases hj : j = i
  · subst hj; simp
  · simp [hj]

theorem sub_single_one_one (i : Fin d) (a : Fin d →₀ ℕ) :
    a - Finsupp.single i 1 - Finsupp.single i 1 = a - Finsupp.single i 2 := by
  ext j
  by_cases hj : j = i
  · subst hj; simp; omega
  · simp [hj]

theorem add_single_apply_self (i : Fin d) (a : Fin d →₀ ℕ) :
    (a + Finsupp.single i 1 : Fin d →₀ ℕ) i = a i + 1 := by simp

theorem sub_single_apply_self (i : Fin d) (a : Fin d →₀ ℕ) :
    (a - Finsupp.single i 1 : Fin d →₀ ℕ) i = a i - 1 := by simp

/-! ## 2. The two-step ladder algebra -/

/-- The generic one-step operator `aᵢ† + t aᵢ`.  Both `xᵢ = aᵢ† + aᵢ` and
`πᵢ = (i/2)(aᵢ† − aᵢ)` are of this shape. -/
def lop (t : ℂ) (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  crePoly i + t • annPoly i

theorem mulXPoly_eq_lop (i : Fin d) : mulXPoly (d := d) i = lop 1 i := by
  refine LinearMap.ext fun p => ?_
  simp only [lop, LinearMap.add_apply, crePoly_apply, annPoly_apply,
    mulXPoly_apply, one_smul]
  ring

theorem momPoly_eq_lop (i : Fin d) :
    momPoly (d := d) i = (Complex.I / 2) • lop (-1) i := by
  refine LinearMap.ext fun p => ?_
  rw [momPoly_eq_cre_sub_ann]
  simp only [lop, LinearMap.smul_apply, LinearMap.add_apply, neg_smul, one_smul,
    LinearMap.neg_apply]
  rw [sub_eq_add_neg]

theorem lop_hermiteMv (t : ℂ) (i : Fin d) (b : Fin d →₀ ℕ) :
    lop t i (hermiteMv b)
      = hermiteMv (b + Finsupp.single i 1) + (t * (b i : ℂ)) • hermiteMv (b - Finsupp.single i 1)
      := by
  simp only [lop, LinearMap.add_apply, LinearMap.smul_apply, annPoly_apply]
  rw [crePoly_hermiteMv, pderiv_hermiteMv, smul_smul]

/-- **The two-step ladder action.**  Applying two one-step operators moves the `i`-th
excitation number by `0` or `±2`. -/
theorem lop_lop_hermiteMv (t t' : ℂ) (i : Fin d) (a : Fin d →₀ ℕ) :
    lop t i (lop t' i (hermiteMv a))
      = hermiteMv (a + Finsupp.single i 2)
        + (t * ((a i : ℂ) + 1) + t' * (a i : ℂ)) • hermiteMv a
        + (t * t' * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ))) • hermiteMv (a - Finsupp.single i 2) := by
  rw [lop_hermiteMv t' i a, map_add, map_smul, lop_hermiteMv t i (a + Finsupp.single i 1),
    add_single_one_one, add_single_apply_self, add_tsub_cancel_right]
  rcases Nat.eq_zero_or_pos (a i) with h0 | hpos
  · rw [h0]
    simp
  · rw [lop_hermiteMv t i (a - Finsupp.single i 1), sub_single_one_one,
      sub_single_apply_self, sub_add_singleK (by omega : 1 ≤ a i)]
    push_cast [Nat.cast_sub hpos]
    module

/-! ## 3. The Hamiltonian -/

/-- The two-step (squeezing) amplitude `qᵢ − pᵢ/4 + i sᵢ/2` of the mode-diagonal
quadratic Hamiltonian: the coefficient with which it raises the `i`-th excitation number
by two. -/
def mqAmp (p q s : Fin d → ℝ) (i : Fin d) : ℂ :=
  ((q i - p i / 4 : ℝ) : ℂ) + Complex.I * ((s i / 2 : ℝ) : ℂ)

/-- The real diagonal symbol `∑ᵢ (qᵢ + pᵢ/4)(2αᵢ+1)` of the mode-diagonal quadratic
Hamiltonian. -/
def mqSymbol (p q : Fin d → ℝ) (a : Fin d →₀ ℕ) : ℝ :=
  ∑ i, (q i + p i / 4) * (2 * (a i : ℝ) + 1)

/-- The quadratic part `∑ᵢ (pᵢπᵢ² + qᵢxᵢ² + sᵢ·½(xᵢπᵢ + πᵢxᵢ))`, on polynomial
coordinates, assembled from Weyl-ordered products of the canonical pair. -/
def mqQuadPoly (p q s : Fin d → ℝ) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  ∑ i, (((p i : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (momPoly i) (momPoly i)
      + ((q i : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (mulXPoly i)
      + ((s i : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (momPoly i))

/-- The full symbol, quadratic part plus first-order part. -/
def mqPoly (p q s b b' : Fin d → ℝ) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  mqQuadPoly p q s + foPoly b b'

/-- **The general mode-diagonal quadratic Hamiltonian**
`∑ᵢ (pᵢπᵢ² + qᵢxᵢ² + sᵢ·½(xᵢπᵢ + πᵢxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)` on the Gauss–polynomial
core. -/
def mqOp (p q s b b' : Fin d → ℝ) : (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype ∘ₗ coreOp (mqPoly p q s b b')

/-! ### Symmetry -/

theorem polySym_mqQuadPoly (p q s : Fin d → ℝ) :
    BookProof.YangMillsHermite.PolySym (mqQuadPoly p q s) := by
  refine polySym_sum _ _ fun i _ => ?_
  refine ((BookProof.YangMillsHermite.weylProd_polySym (polySym_momPoly i)
      (polySym_momPoly i)).real_smul.add
    (BookProof.YangMillsHermite.weylProd_polySym (polySym_mulXPoly i)
      (polySym_mulXPoly i)).real_smul).add ?_
  exact (BookProof.YangMillsHermite.weylProd_polySym (polySym_mulXPoly i)
    (polySym_momPoly i)).real_smul

theorem polySym_mqPoly (p q s b b' : Fin d → ℝ) :
    BookProof.YangMillsHermite.PolySym (mqPoly p q s b b') :=
  (polySym_mqQuadPoly p q s).add (polySym_foPoly b b')

set_option maxHeartbeats 1600000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
/-- The Hamiltonian is symmetric on the core: it is built from Weyl-ordered products of
the (symmetric) canonical pair. -/
theorem mqOp_symmetric (p q s b b' : Fin d → ℝ) :
    SymmetricOn (polyGaussCore (d := d)) (mqOp p q s b b') :=
  symmetricOn_of_polySym (polySym_mqPoly p q s b b')

/-! ### The ladder form -/

theorem weyl_hermiteMv (t t' : ℂ) (i : Fin d) (a : Fin d →₀ ℕ) :
    BookProof.YangMillsHermite.weylProd (lop t i) (lop t' i) (hermiteMv a)
      = hermiteMv (a + Finsupp.single i 2)
        + (((t + t') * ((a i : ℂ) + 1) + (t + t') * (a i : ℂ)) / 2) • hermiteMv a
        + (t * t' * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ))) • hermiteMv (a - Finsupp.single i 2) := by
  rw [BookProof.YangMillsHermite.weylProd]
  simp only [LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply]
  rw [lop_lop_hermiteMv t t' i a, lop_lop_hermiteMv t' t i a]
  push_cast
  module

theorem momsq_hermiteMv (i : Fin d) (a : Fin d →₀ ℕ) :
    BookProof.YangMillsHermite.weylProd (momPoly i) (momPoly i) (hermiteMv a)
      = (-(1 / 4 : ℂ)) • hermiteMv (a + Finsupp.single i 2)
        + ((2 * (a i : ℂ) + 1) / 4) • hermiteMv a
        + (-(1 / 4 : ℂ) * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ)))
            • hermiteMv (a - Finsupp.single i 2) := by
  have hI : (Complex.I / 2) * (Complex.I / 2) = -(1 / 4 : ℂ) := by
    rw [div_mul_div_comm, Complex.I_mul_I]
    norm_num
  rw [momPoly_eq_lop, BookProof.YangMillsHermite.weylProd]
  simp only [LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply, map_smul,
    smul_smul, hI]
  rw [lop_lop_hermiteMv (-1) (-1) i a]
  push_cast
  module

theorem xsq_hermiteMv (i : Fin d) (a : Fin d →₀ ℕ) :
    BookProof.YangMillsHermite.weylProd (mulXPoly i) (mulXPoly i) (hermiteMv a)
      = (1 : ℂ) • hermiteMv (a + Finsupp.single i 2)
        + (2 * (a i : ℂ) + 1) • hermiteMv a
        + ((a i : ℂ) * (((a i - 1 : ℕ) : ℂ))) • hermiteMv (a - Finsupp.single i 2) := by
  rw [mulXPoly_eq_lop, BookProof.YangMillsHermite.weylProd]
  simp only [LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply]
  rw [lop_lop_hermiteMv 1 1 i a]
  push_cast
  module

theorem weylxp_hermiteMv (i : Fin d) (a : Fin d →₀ ℕ) :
    BookProof.YangMillsHermite.weylProd (mulXPoly i) (momPoly i) (hermiteMv a)
      = (Complex.I / 2) • hermiteMv (a + Finsupp.single i 2)
        + (0 : ℂ) • hermiteMv a
        + (-(Complex.I / 2) * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ)))
            • hermiteMv (a - Finsupp.single i 2) := by
  rw [mulXPoly_eq_lop, momPoly_eq_lop, BookProof.YangMillsHermite.weylProd]
  simp only [LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply, map_smul]
  rw [lop_lop_hermiteMv 1 (-1) i a, lop_lop_hermiteMv (-1) 1 i a]
  push_cast
  module

/-- **The ladder form of the quadratic part.** -/
theorem mqQuadPoly_hermiteMv (p q s : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    mqQuadPoly p q s (hermiteMv a)
      = ((mqSymbol p q a : ℝ) : ℂ) • hermiteMv a
        + ∑ i, (mqAmp p q s i • hermiteMv (a + Finsupp.single i 2)
              + ((starRingEnd ℂ) (mqAmp p q s i) * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ)))
                  • hermiteMv (a - Finsupp.single i 2)) := by
  have hterm : ∀ i : Fin d,
      (((p i : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (momPoly i) (momPoly i)
        + ((q i : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (mulXPoly i)
        + ((s i : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (momPoly i))
          (hermiteMv a)
      = (((( q i + p i / 4) * (2 * (a i : ℝ) + 1) : ℝ)) : ℂ) • hermiteMv a
        + (mqAmp p q s i • hermiteMv (a + Finsupp.single i 2)
            + ((starRingEnd ℂ) (mqAmp p q s i) * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ)))
                • hermiteMv (a - Finsupp.single i 2)) := by
    intro i
    simp only [LinearMap.add_apply, LinearMap.smul_apply]
    rw [momsq_hermiteMv, xsq_hermiteMv, weylxp_hermiteMv, mqAmp]
    simp only [map_add, map_mul, Complex.conj_ofReal, Complex.conj_I]
    push_cast
    module
  rw [mqQuadPoly, LinearMap.sum_apply]
  rw [Finset.sum_congr rfl (fun i _ => hterm i), Finset.sum_add_distrib]
  congr 1
  rw [mqSymbol, ← Finset.sum_smul]
  push_cast
  ring_nf

/-! ### Transport to the core -/

theorem hermiteMvNorm_add_two (i : Fin d) (a : Fin d →₀ ℕ) :
    hermiteMvNorm (a + Finsupp.single i 2)
      = hermiteMvNorm a * Real.sqrt ((a i : ℝ) + 1) * Real.sqrt ((a i : ℝ) + 2) := by
  rw [← add_single_one_one i a, hermiteMvNorm_add_single i (a + Finsupp.single i 1),
    hermiteMvNorm_add_single i a, add_single_apply_self]
  push_cast
  ring_nf

theorem ascend2_Lp (i : Fin d) (a : Fin d →₀ ℕ) :
    ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (hermiteMv (a + Finsupp.single i 2))
      = ((rc2 a i : ℝ) : ℂ) • hermiteMvLp (a + Finsupp.single i 2) := by
  rw [pgLp_hermiteMv_eq, smul_smul, hermiteMvNorm_add_two, rc2,
    Real.sqrt_mul (by positivity)]
  congr 1
  have hne : ((hermiteMvNorm a : ℝ) : ℂ) ≠ 0 := hermiteMvNorm_ne_zero a
  push_cast
  field_simp

theorem descend2_Lp (i : Fin d) (a : Fin d →₀ ℕ) (c : ℂ) :
    ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ •
        ((c * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ))) • pgLp (hermiteMv (a - Finsupp.single i 2)))
      = (c * ((lc2 a i : ℝ) : ℂ)) • hermiteMvLp (a - Finsupp.single i 2) := by
  rcases Nat.lt_or_ge (a i) 2 with hlt | hge
  · have hz : (a i : ℂ) * (((a i - 1 : ℕ) : ℂ)) = 0 := by
      interval_cases hai : (a i)
      · simp
      · simp
    have hlc : lc2 a i = 0 := lc2_vanish i a hlt
    rw [hlc]
    rw [show c * (a i : ℂ) * (((a i - 1 : ℕ) : ℂ)) = c * ((a i : ℂ) * (((a i - 1 : ℕ) : ℂ))) by
      ring, hz]
    simp
  · have hpos1 : 1 ≤ a i := by omega
    have hsub1 : (a - Finsupp.single i 1 : Fin d →₀ ℕ) i = a i - 1 := by simp
    have hpos2 : 1 ≤ (a - Finsupp.single i 1 : Fin d →₀ ℕ) i := by rw [hsub1]; omega
    have hn1 : hermiteMvNorm a
        = hermiteMvNorm (a - Finsupp.single i 1) * Real.sqrt ((a i : ℝ)) :=
      hermiteMvNorm_sub_single hpos1
    have hn2 : hermiteMvNorm (a - Finsupp.single i 1)
        = hermiteMvNorm (a - Finsupp.single i 2) * Real.sqrt (((a i - 1 : ℕ) : ℝ)) := by
      have h := hermiteMvNorm_sub_single (i := i) (a := a - Finsupp.single i 1) hpos2
      rw [sub_single_one_one, hsub1] at h
      exact h
    have hnorm : hermiteMvNorm a
        = hermiteMvNorm (a - Finsupp.single i 2)
            * (Real.sqrt (((a i - 1 : ℕ) : ℝ)) * Real.sqrt ((a i : ℝ))) := by
      rw [hn1, hn2]; ring
    have hlc : lc2 a i = Real.sqrt ((a i : ℝ)) * Real.sqrt (((a i - 1 : ℕ) : ℝ)) := by
      rw [lc2, ← Real.sqrt_mul (by positivity)]
      congr 1
      have : ((a i - 1 : ℕ) : ℝ) = (a i : ℝ) - 1 := by
        push_cast [Nat.cast_sub hpos1]
        ring
      rw [this]
    have hsq1 : Real.sqrt ((a i : ℝ)) * Real.sqrt ((a i : ℝ)) = (a i : ℝ) :=
      Real.mul_self_sqrt (by positivity)
    have hsq2 : Real.sqrt (((a i - 1 : ℕ) : ℝ)) * Real.sqrt (((a i - 1 : ℕ) : ℝ))
        = ((a i - 1 : ℕ) : ℝ) := Real.mul_self_sqrt (by positivity)
    rw [pgLp_hermiteMv_eq, smul_smul, smul_smul, hlc]
    congr 1
    have hne : ((hermiteMvNorm a : ℝ) : ℂ) ≠ 0 := hermiteMvNorm_ne_zero a
    have hnesub : ((hermiteMvNorm (a - Finsupp.single i 2) : ℝ) : ℂ) ≠ 0 :=
      hermiteMvNorm_ne_zero _
    have hs1 : ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ) ≠ 0 := by
      simp only [ne_eq, Complex.ofReal_eq_zero]
      have : (0 : ℝ) < Real.sqrt ((a i : ℝ)) := Real.sqrt_pos.mpr (by exact_mod_cast hpos1)
      linarith
    have hs2 : ((Real.sqrt (((a i - 1 : ℕ) : ℝ)) : ℝ) : ℂ) ≠ 0 := by
      simp only [ne_eq, Complex.ofReal_eq_zero]
      have : (0 : ℝ) < Real.sqrt (((a i - 1 : ℕ) : ℝ)) :=
        Real.sqrt_pos.mpr (by exact_mod_cast (by omega : 0 < a i - 1))
      linarith
    rw [hnorm]
    push_cast
    field_simp
    have hc1 : ((a i : ℂ))
        = ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ) := by
      rw [← Complex.ofReal_mul, hsq1]; simp
    have hc2 : (((a i - 1 : ℕ) : ℂ))
        = ((Real.sqrt (((a i - 1 : ℕ) : ℝ)) : ℝ) : ℂ)
            * ((Real.sqrt (((a i - 1 : ℕ) : ℝ)) : ℝ) : ℂ) := by
      rw [← Complex.ofReal_mul, hsq2]; simp
    rw [hc1, hc2]
    ring

set_option maxHeartbeats 1600000 in
-- the core coercions make the elaboration of this transport expensive
/-- **The ladder form of the Hamiltonian on the product Hermite basis.** -/
theorem mqOp_hermiteCore (p q s b b' : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    mqOp p q s b b' (hermiteCore a)
      = ((mqSymbol p q a : ℝ) : ℂ) • hermiteMvLp a
        + (∑ i, ((mqAmp p q s i * ((rc2 a i : ℝ) : ℂ))
                    • hermiteMvLp (a + Finsupp.single i 2)
                + ((starRingEnd ℂ) (mqAmp p q s i) * ((lc2 a i : ℝ) : ℂ))
                    • hermiteMvLp (a - Finsupp.single i 2)))
        + ∑ i, ((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
                  • hermiteMvLp (a + Finsupp.single i 1)
                + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
                  • hermiteMvLp (a - Finsupp.single i 1)) := by
  have hcoe : (mqOp p q s b b' (hermiteCore a) : L2d d)
      = ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgMap (mqPoly p q s b b' (hermiteMv a)) := by
    have h := coreOp_coe (mqPoly p q s b b') (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • hermiteMv a)
    rw [← HermiteProductBasis.pgMap_apply, map_smul (mqPoly p q s b b'),
      map_smul (pgMap (d := d))] at h
    exact h
  rw [hcoe, mqPoly, LinearMap.add_apply, mqQuadPoly_hermiteMv, map_add, map_add, map_sum,
    smul_add, smul_add, Finset.smul_sum]
  congr 1
  · congr 1
    · rw [map_smul, smul_comm, HermiteProductBasis.pgMap_apply, pgLp_hermiteMv_eq, smul_smul,
        smul_smul, mul_assoc, inv_mul_cancel₀ (hermiteMvNorm_ne_zero a), mul_one]
    · refine Finset.sum_congr rfl fun i _ => ?_
      rw [map_add, smul_add, map_smul, map_smul]
      congr 1
      · rw [smul_comm, HermiteProductBasis.pgMap_apply, ascend2_Lp, smul_smul]
      · rw [HermiteProductBasis.pgMap_apply]
        exact descend2_Lp i a ((starRingEnd ℂ) (mqAmp p q s i))
  · have hfo : ((foOp b b' (hermiteCore a) : L2d d))
        = ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgMap (foPoly b b' (hermiteMv a)) := by
      have h := coreOp_coe (foPoly b b') (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • hermiteMv a)
      rw [← HermiteProductBasis.pgMap_apply, map_smul (foPoly b b'),
        map_smul (pgMap (d := d))] at h
      exact h
    rw [← hfo, foOp_hermiteCore]

/-! ## 4. Essential self-adjointness -/

set_option maxHeartbeats 1600000 in
-- the core coercions make the elaboration of the deficiency computation expensive
/-- **The deficiency spaces vanish at every non-real point.** -/
theorem mqOp_deficiencyTrivialAt (p q s b b' : Fin d → ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (polyGaussCore (d := d)) (mqOp p q s b b') z := by
  classical
  intro w hw
  set u : (Fin d →₀ ℕ) → ℂ := fun a => (inner ℂ (hermiteMvLp (d := d) a) w : ℂ) with hu
  have hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ ‖w‖ ^ 2 := fun F =>
    Orthonormal.sum_inner_products_le (𝕜 := ℂ) w (orthonormal_hermiteMvLp (d := d))
  have hrec : LadderRec2 u (mqSymbol p q) (foAmp b b') (mqAmp p q s) z := by
    intro a
    have h := hw (hermiteCore a)
    rw [mqOp_hermiteCore p q s b b' a, inner_add_left, inner_add_left, inner_smul_left,
      Complex.conj_ofReal, sum_inner, sum_inner] at h
    rw [hermiteCore_coe] at h
    have hq : ∀ i : Fin d,
        (inner ℂ (((mqAmp p q s i * ((rc2 a i : ℝ) : ℂ))
              • hermiteMvLp (d := d) (a + Finsupp.single i 2)
            + ((starRingEnd ℂ) (mqAmp p q s i) * ((lc2 a i : ℝ) : ℂ))
              • hermiteMvLp (d := d) (a - Finsupp.single i 2))) w : ℂ)
        = (starRingEnd ℂ) (mqAmp p q s i) * ((rc2 a i : ℝ) : ℂ)
            * u (a + Finsupp.single i 2)
          + mqAmp p q s i * ((lc2 a i : ℝ) : ℂ) * u (a - Finsupp.single i 2) := by
      intro i
      rw [inner_add_left, inner_smul_left, inner_smul_left]
      simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal, hu]
    have hf : ∀ i : Fin d,
        (inner ℂ (((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
              • hermiteMvLp (d := d) (a + Finsupp.single i 1)
            + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
              • hermiteMvLp (d := d) (a - Finsupp.single i 1))) w : ℂ)
        = (starRingEnd ℂ) (foAmp b b' i) * ((rc1 a i : ℝ) : ℂ) * u (a + Finsupp.single i 1)
          + foAmp b b' i * ((lc1 a i : ℝ) : ℂ) * u (a - Finsupp.single i 1) := by
      intro i
      rw [inner_add_left, inner_smul_left, inner_smul_left]
      simp only [map_mul, Complex.conj_conj, Complex.conj_ofReal, hu, rc1, lc1]
    rw [Finset.sum_congr rfl (fun i _ => hq i), Finset.sum_congr rfl (fun i _ => hf i)] at h
    linear_combination h
  have hzero : ∀ a, u a = 0 := ladder2_eq_zero hz hbes hrec
  exact hermiteMvLp_total w fun a => hzero a

/-- **HEADLINE.**  For *arbitrary* real `p, q, s, b, b'`, the general mode-diagonal
quadratic Hamiltonian

`H = ∑ᵢ (pᵢπᵢ² + qᵢxᵢ² + sᵢ·½(xᵢπᵢ + πᵢxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

is essentially self-adjoint on the Gauss–polynomial (product Hermite) core of `L²(ℝᵈ)`.
No ellipticity, no sign condition, no classical equilibrium, and no change of core. -/
theorem mqOp_essentiallySelfAdjoint (p q s b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (mqOp p q s b b') :=
  ⟨mqOp_deficiencyTrivialAt p q s b b' (by simp),
    mqOp_deficiencyTrivialAt p q s b b' (by simp)⟩

/-- **The complete unitary flow** generated by the closure of the Hamiltonian. -/
theorem mqOp_stone_flow (p q s b b' : Fin d → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (mqOp p q s b b') T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense (mqOp_symmetric p q s b b')
    (mqOp_essentiallySelfAdjoint p q s b b')

/-- **The generator of dilations** `½∑ᵢ(xᵢπᵢ + πᵢxᵢ)` — the purely hyperbolic, purely
off-diagonal member of the family — is essentially self-adjoint on the plain
Gauss–polynomial core. -/
theorem dilation_essentiallySelfAdjoint :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (mqOp 0 0 1 0 0) :=
  mqOp_essentiallySelfAdjoint 0 0 1 0 0

/-- The unitary dilation flow generated by `½∑ᵢ(xᵢπᵢ + πᵢxᵢ)`. -/
theorem dilation_stone_flow :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (mqOp (d := d) 0 0 1 0 0) T.op ∧ IsStoneFlow T U :=
  mqOp_stone_flow 0 0 1 0 0

end

end BookProof.ModeQuadratic
