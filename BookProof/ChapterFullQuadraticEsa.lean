import Mathlib
import BookProof.ChapterCarlemanSimplex
import BookProof.ChapterModeQuadraticEsa

/-!
# The general real quadratic Hamiltonian on the Gauss–polynomial core

`BookProof.ChapterModeQuadraticEsa` proves essential self-adjointness, on the plain
Gauss–polynomial (product Hermite) core of `L²(ℝᵈ)`, of the general **mode-diagonal**
quadratic Hamiltonian

`∑ᵢ (pᵢπᵢ² + qᵢxᵢ² + sᵢ·½(xᵢπᵢ + πᵢxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

for arbitrary real `p, q, s, b, b'`.  What that leaves open is the coupling of **distinct**
modes: `xᵢxⱼ`, `πᵢπⱼ` and `xᵢπⱼ` with `i ≠ j`.

This module removes that restriction.  For arbitrary real matrices `P, Q, S` and arbitrary
real vectors `b, b'` the Weyl-ordered operator

`H = ∑_{i,j} (Pᵢⱼ πᵢπⱼ + Qᵢⱼ xᵢxⱼ + Sᵢⱼ·½(xᵢπⱼ + πⱼxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

— i.e. *every* real quadratic-plus-linear Hamiltonian in `d` degrees of freedom, with no
ellipticity, no definiteness, no non-degeneracy and no classical equilibrium — is
essentially self-adjoint on the plain Gauss–polynomial core, and hence generates a
complete unitary flow.

## The mechanism

In the ladder variables `xᵢ = aᵢ† + aᵢ`, `πᵢ = (i/2)(aᵢ† − aᵢ)` a product of two of them
is a sum of four hops of the multi-index `α`:

* `α ↦ α + eᵢ + eⱼ` (pair creation), amplitude `√((αᵢ+1)(αⱼ+1))`;
* `α ↦ α − eᵢ − eⱼ` (pair annihilation), amplitude `√(αᵢαⱼ)`;
* `α ↦ α + eᵢ − eⱼ` (mode exchange), amplitude `√(αⱼ(αᵢ+1))`;

plus, when `i = j`, a constant diagonal.  The first two change the total degree `|α|` by
`±2`, the third preserves it.  `BookProof.ChapterCarlemanSimplex` runs the Carleman flux
argument on the simplex shells `{|α| ≤ N}`, which is exactly adapted to this grading: the
mode-exchange hops carry no flux at all (their contribution over a shell is real, because
their amplitude matrix is Hermitian), and the degree-changing hops leak only through a
two-thick boundary shell.

## What is proved

* `lop_lop_hermiteMv_gen`, `weyl_hermiteMv_gen` — the two-index ladder algebra, uniform in
  `i` and `j` (the diagonal `i = j` differs only by an extra constant).
* `fqQuadPoly`, `fqPoly`, `fqOp` — the Hamiltonian, assembled from Weyl-ordered products
  of the canonical pair, hence symmetric on the core (`fqOp_symmetric`).
* `fqQuadPoly_hermiteMv`, `fqOp_hermiteCore` — its ladder form: a real constant diagonal,
  the pair amplitude `Qᵢⱼ − Pᵢⱼ/4 + i Sᵢⱼ/2`, the Hermitian exchange matrix
  `fqExch`, and the one-step amplitude `bᵢ + i b'ᵢ/2` of the first-order part.
* `fqOp_deficiencyTrivialAt`, `fqOp_essentiallySelfAdjoint` — **the headline**, by the
  simplex Carleman criterion `BookProof.CarlemanSimplex.ladderQ_eq_zero`.
* `fqOp_stone_flow` — the resulting complete unitary flow, by Stone's theorem.
* `crossTerm_essentiallySelfAdjoint`, `crossTerm_stone_flow` — the corollary for the
  purely off-diagonal cross term `½(xᵢπⱼ + πⱼxᵢ) + ½(xⱼπᵢ + πᵢxⱼ)`.
* `rotMat`, `fqQuadPoly_rotMat`, `angularMomentum_essentiallySelfAdjoint`,
  `angularMomentum_stone_flow` — an *antisymmetric* exchange matrix realizes the
  angular-momentum generator `xₖπ_l − x_lπₖ`, the compact counterpart of the dilation
  generator; it too is essentially self-adjoint on the core, with a complete flow.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.FullQuadratic

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

/-! ## 1. Two-index multi-index arithmetic -/

theorem pvec_comm (i j : Fin d) : pvec (d := d) i j = pvec j i := by
  rw [pvec, pvec, add_comm]

theorem add_pvec_eq (a : Fin d →₀ ℕ) (i j : Fin d) :
    a + Finsupp.single j 1 + Finsupp.single i 1 = a + pvec i j := by
  rw [pvec]
  abel

theorem sub_pvec_eq (a : Fin d →₀ ℕ) (i j : Fin d) :
    a - Finsupp.single j 1 - Finsupp.single i 1 = a - pvec i j := by
  ext k
  simp only [pvec, Finsupp.tsub_apply, Finsupp.add_apply]
  omega

theorem shiftm_self_eq {a : Fin d →₀ ℕ} {i : Fin d} (h : 1 ≤ a i) : shiftm a i i = a := by
  have hle : Finsupp.single i 1 ≤ a := by
    rw [Finsupp.le_def]
    intro k
    by_cases hk : k = i
    · subst hk; simpa using h
    · simp [Ne.symm hk]
  rw [shiftm, tsub_add_cancel_of_le' hle]

theorem add_sub_single_eq_shiftm {a : Fin d →₀ ℕ} {i j : Fin d} (hij : i ≠ j) :
    a + Finsupp.single j 1 - Finsupp.single i 1 = shiftm a j i := by
  ext k
  simp only [shiftm, Finsupp.tsub_apply, Finsupp.add_apply, Finsupp.single_apply]
  by_cases hki : i = k <;> by_cases hkj : j = k <;> simp_all

theorem sub_single_apply_ne {a : Fin d →₀ ℕ} {i j : Fin d} (hij : i ≠ j) :
    ((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) = a i := by
  simp [Finsupp.tsub_apply, hij]

theorem add_single_apply_ne {a : Fin d →₀ ℕ} {i j : Fin d} (hij : i ≠ j) :
    ((a + Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) = a i := by
  simp [hij]

/-- The two ways of reading the pair-annihilation amplitude agree. -/
theorem swap_prod (a : Fin d →₀ ℕ) (i j : Fin d) :
    (a j) * ((a - Finsupp.single j 1 : Fin d →₀ ℕ) i)
      = (a i) * ((a - Finsupp.single i 1 : Fin d →₀ ℕ) j) := by
  by_cases hij : i = j
  · subst hij; ring
  · rw [sub_single_apply_ne hij, sub_single_apply_ne (Ne.symm hij)]
    ring

theorem swap_prodC (a : Fin d →₀ ℕ) (i j : Fin d) :
    ((a j : ℂ)) * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ)
      = ((a i : ℂ)) * (((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℂ) := by
  have h := swap_prod a i j
  exact_mod_cast congrArg (fun n : ℕ => (n : ℂ)) h

theorem smul_shiftm_diag (c : ℂ) (a : Fin d →₀ ℕ) (i : Fin d) :
    (c * (a i : ℂ)) • hermiteMv (shiftm a i i) = (c * (a i : ℂ)) • hermiteMv a := by
  rcases Nat.eq_zero_or_pos (a i) with h | h
  · rw [h]
    simp
  · rw [shiftm_self_eq h]

/-! ## 2. The two-index ladder algebra -/

/-- **The two-index ladder action.**  A product of two one-step operators is a sum of the
pair-creation hop, the two mode-exchange hops, the pair-annihilation hop, and — only when
`i = j` — a constant diagonal. -/
theorem lop_lop_hermiteMv_gen (t t' : ℂ) (i j : Fin d) (a : Fin d →₀ ℕ) :
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

theorem weylProd_smul_apply (c c' : ℂ) (A B : Module.End ℂ (MvPolynomial (Fin d) ℂ))
    (p : MvPolynomial (Fin d) ℂ) :
    BookProof.YangMillsHermite.weylProd (c • A) (c' • B) p
      = (c * c') • BookProof.YangMillsHermite.weylProd A B p := by
  simp only [BookProof.YangMillsHermite.weylProd, LinearMap.smul_apply, LinearMap.add_apply,
    LinearMap.comp_apply, map_smul, smul_smul]
  rw [mul_comm c' c]
  module

/-- **The Weyl-ordered two-index ladder action.** -/
theorem weyl_hermiteMv_gen (t t' : ℂ) (i j : Fin d) (a : Fin d →₀ ℕ) :
    BookProof.YangMillsHermite.weylProd (lop t i) (lop t' j) (hermiteMv a)
      = hermiteMv (a + pvec i j)
        + (t * (a i : ℂ)) • hermiteMv (shiftm a j i)
        + (t' * (a j : ℂ)) • hermiteMv (shiftm a i j)
        + (t * t' * (a j : ℂ) * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ))
            • hermiteMv (a - pvec i j)
        + (if i = j then ((t + t') / 2) • hermiteMv a else 0) := by
  rw [BookProof.YangMillsHermite.weylProd]
  simp only [LinearMap.smul_apply, LinearMap.add_apply, LinearMap.comp_apply]
  have hco : t' * t * (a i : ℂ) * (((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℂ)
      = t * t' * (a j : ℂ) * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ) := by
    have hsw := swap_prodC a i j
    calc t' * t * (a i : ℂ) * (((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℂ)
        = (t' * t) * ((a i : ℂ) * (((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℂ)) := by
          ring
      _ = (t * t') * ((a j : ℂ) * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ)) := by
          rw [← hsw]; ring
      _ = t * t' * (a j : ℂ) * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ) := by ring
  rw [lop_lop_hermiteMv_gen t t' i j a, lop_lop_hermiteMv_gen t' t j i a,
    ← pvec_comm j i, hco]
  by_cases hij : i = j
  · subst hij
    simp only [↓reduceIte]
    push_cast
    module
  · rw [if_neg hij, if_neg (Ne.symm hij), if_neg hij]
    push_cast
    module

/-! ## 3. The Hamiltonian -/

/-- The pair-creation amplitude `Qᵢⱼ − Pᵢⱼ/4 + i Sᵢⱼ/2`. -/
def fqAmp (P Q S : Fin d → Fin d → ℝ) (i j : Fin d) : ℂ :=
  ((Q i j - P i j / 4 : ℝ) : ℂ) + Complex.I * ((S i j / 2 : ℝ) : ℂ)

/-- The half of the mode-exchange amplitude coming from the ordered pair `(i, j)`. -/
def fqMl (P Q S : Fin d → Fin d → ℝ) (i j : Fin d) : ℂ :=
  ((Q i j + P i j / 4 : ℝ) : ℂ) - Complex.I * ((S i j / 2 : ℝ) : ℂ)

/-- **The mode-exchange amplitude matrix**, which is Hermitian. -/
def fqExch (P Q S : Fin d → Fin d → ℝ) (i j : Fin d) : ℂ :=
  fqMl P Q S i j + (starRingEnd ℂ) (fqMl P Q S j i)

theorem fqExch_hermitian (P Q S : Fin d → Fin d → ℝ) (i j : Fin d) :
    (starRingEnd ℂ) (fqExch P Q S i j) = fqExch P Q S j i := by
  rw [fqExch, fqExch, map_add, Complex.conj_conj]
  ring

/-- The constant diagonal `∑ᵢ (Qᵢᵢ + Pᵢᵢ/4)` of the Weyl-ordered Hamiltonian. -/
def fqSymbol (P Q : Fin d → Fin d → ℝ) : ℝ := ∑ i, (Q i i + P i i / 4)

/-- The quadratic part `∑_{i,j} (Pᵢⱼπᵢπⱼ + Qᵢⱼxᵢxⱼ + Sᵢⱼ·½(xᵢπⱼ + πⱼxᵢ))`, on polynomial
coordinates, assembled from Weyl-ordered products of the canonical pair. -/
def fqQuadPoly (P Q S : Fin d → Fin d → ℝ) :
    MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  ∑ i, ∑ j, (((P i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (momPoly i) (momPoly j)
      + ((Q i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (mulXPoly j)
      + ((S i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (momPoly j))

/-- The full symbol: quadratic part plus first-order part. -/
def fqPoly (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  fqQuadPoly P Q S + foPoly b b'

/-- **The general real quadratic Hamiltonian** on the Gauss–polynomial core. -/
def fqOp (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    (polyGaussCore (d := d)) →ₗ[ℂ] L2d d :=
  (polyGaussCore (d := d)).subtype ∘ₗ coreOp (fqPoly P Q S b b')

/-! ### Symmetry -/

theorem polySym_fqQuadPoly (P Q S : Fin d → Fin d → ℝ) :
    BookProof.YangMillsHermite.PolySym (fqQuadPoly P Q S) := by
  refine polySym_sum _ _ fun i _ => ?_
  refine polySym_sum _ _ fun j _ => ?_
  refine ((BookProof.YangMillsHermite.weylProd_polySym (polySym_momPoly i)
      (polySym_momPoly j)).real_smul.add
    (BookProof.YangMillsHermite.weylProd_polySym (polySym_mulXPoly i)
      (polySym_mulXPoly j)).real_smul).add ?_
  exact (BookProof.YangMillsHermite.weylProd_polySym (polySym_mulXPoly i)
    (polySym_momPoly j)).real_smul

theorem polySym_fqPoly (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    BookProof.YangMillsHermite.PolySym (fqPoly P Q S b b') :=
  (polySym_fqQuadPoly P Q S).add (polySym_foPoly b b')

set_option maxHeartbeats 1600000 in
-- the `L²` coercions of the Gauss–polynomial core make this defeq check expensive
/-- The Hamiltonian is symmetric on the core: it is built from Weyl-ordered products of
the (symmetric) canonical pair. -/
theorem fqOp_symmetric (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    SymmetricOn (polyGaussCore (d := d)) (fqOp P Q S b b') :=
  symmetricOn_of_polySym (polySym_fqPoly P Q S b b')

/-! ### The ladder form on polynomials -/

theorem momsq_gen (i j : Fin d) (a : Fin d →₀ ℕ) :
    BookProof.YangMillsHermite.weylProd (momPoly i) (momPoly j) (hermiteMv a)
      = (-(1 / 4 : ℂ)) •
          BookProof.YangMillsHermite.weylProd (lop (-1) i) (lop (-1) j) (hermiteMv a) := by
  have hI : (Complex.I / 2) * (Complex.I / 2) = -(1 / 4 : ℂ) := by
    rw [div_mul_div_comm, Complex.I_mul_I]
    norm_num
  rw [momPoly_eq_lop, momPoly_eq_lop, weylProd_smul_apply, hI]

theorem xsq_gen (i j : Fin d) (a : Fin d →₀ ℕ) :
    BookProof.YangMillsHermite.weylProd (mulXPoly i) (mulXPoly j) (hermiteMv a)
      = BookProof.YangMillsHermite.weylProd (lop 1 i) (lop 1 j) (hermiteMv a) := by
  rw [mulXPoly_eq_lop, mulXPoly_eq_lop]

theorem weylxp_gen (i j : Fin d) (a : Fin d →₀ ℕ) :
    BookProof.YangMillsHermite.weylProd (mulXPoly i) (momPoly j) (hermiteMv a)
      = (Complex.I / 2) •
          BookProof.YangMillsHermite.weylProd (lop 1 i) (lop (-1) j) (hermiteMv a) := by
  rw [mulXPoly_eq_lop, momPoly_eq_lop]
  have h := weylProd_smul_apply (d := d) 1 (Complex.I / 2) (lop 1 i) (lop (-1) j) (hermiteMv a)
  rw [one_smul] at h
  rw [h, one_mul]

/-- The contribution of the ordered pair `(i, j)` to the ladder form. -/
theorem fqTerm_hermiteMv (P Q S : Fin d → Fin d → ℝ) (i j : Fin d) (a : Fin d →₀ ℕ) :
    (((P i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (momPoly i) (momPoly j)
      + ((Q i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (mulXPoly j)
      + ((S i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (momPoly j))
        (hermiteMv a)
      = fqAmp P Q S i j • hermiteMv (a + pvec i j)
        + ((starRingEnd ℂ) (fqMl P Q S i j) * (a i : ℂ)) • hermiteMv (shiftm a j i)
        + (fqMl P Q S i j * (a j : ℂ)) • hermiteMv (shiftm a i j)
        + ((starRingEnd ℂ) (fqAmp P Q S i j) * (a j : ℂ)
            * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ)) • hermiteMv (a - pvec i j)
        + (if i = j then (((Q i i + P i i / 4 : ℝ) : ℂ)) • hermiteMv a else 0) := by
  simp only [LinearMap.add_apply, LinearMap.smul_apply]
  rw [momsq_gen, xsq_gen, weylxp_gen,
    weyl_hermiteMv_gen (-1) (-1) i j a, weyl_hermiteMv_gen 1 1 i j a,
    weyl_hermiteMv_gen 1 (-1) i j a, fqAmp, fqMl]
  simp only [map_add, map_sub, map_mul, Complex.conj_ofReal, Complex.conj_I]
  by_cases hij : i = j
  · subst hij
    simp only [↓reduceIte]
    push_cast
    module
  · simp only [if_neg hij, add_zero]
    push_cast
    module

set_option maxHeartbeats 1600000 in
-- expanding the quadratic symbol over all mode pairs makes this rewrite chain expensive
/-- **The ladder form of the quadratic part.** -/
theorem fqQuadPoly_hermiteMv (P Q S : Fin d → Fin d → ℝ) (a : Fin d →₀ ℕ) :
    fqQuadPoly P Q S (hermiteMv a)
      = ((fqSymbol P Q : ℝ) : ℂ) • hermiteMv a
        + ∑ i, ∑ j, (fqAmp P Q S i j • hermiteMv (a + pvec i j)
            + ((starRingEnd ℂ) (fqAmp P Q S i j) * (a j : ℂ)
                * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ))
                  • hermiteMv (a - pvec i j)
            + (fqExch P Q S i j * (a j : ℂ)) • hermiteMv (shiftm a i j)) := by
  classical
  rw [fqQuadPoly, LinearMap.sum_apply]
  have hterm : ∀ i : Fin d, (∑ j, (((P i j : ℝ) : ℂ)
        • BookProof.YangMillsHermite.weylProd (momPoly i) (momPoly j)
      + ((Q i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (mulXPoly j)
      + ((S i j : ℝ) : ℂ) • BookProof.YangMillsHermite.weylProd (mulXPoly i) (momPoly j)))
        (hermiteMv a)
      = ∑ j, (fqAmp P Q S i j • hermiteMv (a + pvec i j)
        + ((starRingEnd ℂ) (fqMl P Q S i j) * (a i : ℂ)) • hermiteMv (shiftm a j i)
        + (fqMl P Q S i j * (a j : ℂ)) • hermiteMv (shiftm a i j)
        + ((starRingEnd ℂ) (fqAmp P Q S i j) * (a j : ℂ)
            * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ)) • hermiteMv (a - pvec i j)
        + (if i = j then (((Q i i + P i i / 4 : ℝ) : ℂ)) • hermiteMv a else 0)) := by
    intro i
    rw [LinearMap.sum_apply]
    exact Finset.sum_congr rfl fun j _ => fqTerm_hermiteMv P Q S i j a
  rw [Finset.sum_congr rfl fun i _ => hterm i]
  -- split the double sum into its five families
  simp only [Finset.sum_add_distrib]
  -- the diagonal family
  have hdiag : ∑ i : Fin d, ∑ j : Fin d,
      (if i = j then (((Q i i + P i i / 4 : ℝ) : ℂ)) • hermiteMv a else 0)
      = ((fqSymbol P Q : ℝ) : ℂ) • hermiteMv a := by
    have h1 : ∀ i : Fin d, ∑ j : Fin d,
        (if i = j then (((Q i i + P i i / 4 : ℝ) : ℂ)) • hermiteMv a else 0)
        = (((Q i i + P i i / 4 : ℝ) : ℂ)) • hermiteMv a := by
      intro i
      rw [Finset.sum_ite_eq Finset.univ i (fun _ => (((Q i i + P i i / 4 : ℝ) : ℂ))
        • hermiteMv a)]
      simp
    rw [Finset.sum_congr rfl fun i _ => h1 i, ← Finset.sum_smul, fqSymbol]
    push_cast
    ring_nf
  -- the exchange families combine after swapping the two indices
  have hswap : ∑ i : Fin d, ∑ j : Fin d,
      ((starRingEnd ℂ) (fqMl P Q S i j) * (a i : ℂ)) • hermiteMv (shiftm a j i)
      = ∑ i : Fin d, ∑ j : Fin d,
        ((starRingEnd ℂ) (fqMl P Q S j i) * (a j : ℂ)) • hermiteMv (shiftm a i j) :=
    Finset.sum_comm
  have hcomb : ∀ i j : Fin d,
      ((starRingEnd ℂ) (fqMl P Q S j i) * (a j : ℂ)) • hermiteMv (shiftm a i j)
        + (fqMl P Q S i j * (a j : ℂ)) • hermiteMv (shiftm a i j)
        = (fqExch P Q S i j * (a j : ℂ)) • hermiteMv (shiftm a i j) := by
    intro i j
    rw [fqExch]
    module
  have hfinal : ∑ i : Fin d, ∑ j : Fin d,
        ((starRingEnd ℂ) (fqMl P Q S j i) * (a j : ℂ)) • hermiteMv (shiftm a i j)
      + ∑ i : Fin d, ∑ j : Fin d, (fqMl P Q S i j * (a j : ℂ)) • hermiteMv (shiftm a i j)
      = ∑ i : Fin d, ∑ j : Fin d, (fqExch P Q S i j * (a j : ℂ)) • hermiteMv (shiftm a i j) := by
    rw [← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun j _ => hcomb i j
  rw [hdiag, hswap, ← hfinal]
  abel

/-! ### Transport to the orthonormal basis -/

theorem hermiteMvNorm_add_pvec (i j : Fin d) (a : Fin d →₀ ℕ) :
    hermiteMvNorm (a + pvec i j) = hermiteMvNorm a * rcp a i j := by
  rw [← add_pvec_eq, hermiteMvNorm_add_single i (a + Finsupp.single j 1),
    hermiteMvNorm_add_single j a, rcp]
  ring

theorem ascendP_Lp (i j : Fin d) (a : Fin d →₀ ℕ) :
    ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (hermiteMv (a + pvec i j))
      = ((rcp a i j : ℝ) : ℂ) • hermiteMvLp (a + pvec i j) := by
  rw [pgLp_hermiteMv_eq, smul_smul, hermiteMvNorm_add_pvec]
  congr 1
  have hne : ((hermiteMvNorm a : ℝ) : ℂ) ≠ 0 := hermiteMvNorm_ne_zero a
  push_cast
  field_simp

/-- The exchange hop, transported to the orthonormal basis. -/
theorem exchange_Lp (i j : Fin d) (a : Fin d →₀ ℕ) (c : ℂ) :
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

/-- The pair-annihilation hop, transported to the orthonormal basis. -/
theorem descendP_Lp (i j : Fin d) (a : Fin d →₀ ℕ) (c : ℂ) :
    ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ •
        ((c * (a j : ℂ) * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ))
          • pgLp (hermiteMv (a - pvec i j)))
      = (c * ((lcp a i j : ℝ) : ℂ)) • hermiteMvLp (a - pvec i j) := by
  have hco : c * (a j : ℂ) * (((a - Finsupp.single j 1 : Fin d →₀ ℕ) i : ℕ) : ℂ)
      = c * (a i : ℂ) * (((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℂ) := by
    rw [mul_assoc, mul_assoc, swap_prodC]
  rw [hco]
  rcases Nat.eq_zero_or_pos (a i) with h0 | hposi
  · have hlcp : lcp a i j = 0 := by rw [lcp, h0]; simp
    rw [hlcp, h0]
    simp
  · rcases Nat.eq_zero_or_pos ((a - Finsupp.single i 1 : Fin d →₀ ℕ) j) with h0 | hposj
    · have hlcp : lcp a i j = 0 := by rw [lcp, h0]; simp
      rw [hlcp, h0]
      simp
    · have hn1 : hermiteMvNorm a
          = hermiteMvNorm (a - Finsupp.single i 1) * Real.sqrt ((a i : ℝ)) :=
        hermiteMvNorm_sub_single hposi
      have hn2 : hermiteMvNorm (a - Finsupp.single i 1)
          = hermiteMvNorm (a - Finsupp.single i 1 - Finsupp.single j 1)
              * Real.sqrt ((((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℝ)) :=
        hermiteMvNorm_sub_single hposj
      have hsub : a - Finsupp.single i 1 - Finsupp.single j 1 = a - pvec i j := by
        rw [sub_pvec_eq a j i, pvec_comm]
      have hsi : Real.sqrt ((a i : ℝ)) * Real.sqrt ((a i : ℝ)) = (a i : ℝ) :=
        Real.mul_self_sqrt (by positivity)
      have hsj : Real.sqrt ((((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℝ))
            * Real.sqrt ((((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℝ))
          = (((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℝ) :=
        Real.mul_self_sqrt (by positivity)
      have hsine : ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ) ≠ 0 := by
        simp only [ne_eq, Complex.ofReal_eq_zero]
        have : (0 : ℝ) < Real.sqrt ((a i : ℝ)) := Real.sqrt_pos.mpr (by exact_mod_cast hposi)
        linarith
      have hsjne : ((Real.sqrt ((((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℝ)) : ℝ) : ℂ)
          ≠ 0 := by
        simp only [ne_eq, Complex.ofReal_eq_zero]
        have : (0 : ℝ) < Real.sqrt ((((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) : ℝ)) :=
          Real.sqrt_pos.mpr (by exact_mod_cast hposj)
        linarith
      have hbne : ((hermiteMvNorm (a - pvec i j) : ℝ) : ℂ) ≠ 0 := hermiteMvNorm_ne_zero _
      rw [hsub] at hn2
      rw [pgLp_hermiteMv_eq, smul_smul, smul_smul, lcp, hn1, hn2]
      congr 1
      set m : ℕ := a i with hm
      set n : ℕ := ((a - Finsupp.single i 1 : Fin d →₀ ℕ) j : ℕ) with hn
      have hc1 : ((m : ℂ)) = ((Real.sqrt ((m : ℝ)) : ℝ) : ℂ) * ((Real.sqrt ((m : ℝ)) : ℝ) : ℂ) := by
        rw [← Complex.ofReal_mul, hsi]
        simp
      have hc2 : ((n : ℂ)) = ((Real.sqrt ((n : ℝ)) : ℝ) : ℂ) * ((Real.sqrt ((n : ℝ)) : ℝ) : ℂ) := by
        rw [← Complex.ofReal_mul, hsj]
        simp
      push_cast
      field_simp
      rw [hc1, hc2]
      ring

set_option maxHeartbeats 1600000 in
-- the core coercions make the elaboration of this transport expensive
/-- **The ladder form of the Hamiltonian on the product Hermite basis.** -/
theorem fqOp_hermiteCore (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) (a : Fin d →₀ ℕ) :
    fqOp P Q S b b' (hermiteCore a)
      = ((fqSymbol P Q : ℝ) : ℂ) • hermiteMvLp a
        + (∑ i, ∑ j, ((fqAmp P Q S i j * ((rcp a i j : ℝ) : ℂ))
                    • hermiteMvLp (a + pvec i j)
                + ((starRingEnd ℂ) (fqAmp P Q S i j) * ((lcp a i j : ℝ) : ℂ))
                    • hermiteMvLp (a - pvec i j)
                + (fqExch P Q S i j * ((rcm a i j : ℝ) : ℂ))
                    • hermiteMvLp (shiftm a i j)))
        + ∑ i, ((foAmp b b' i * ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ))
                  • hermiteMvLp (a + Finsupp.single i 1)
                + ((starRingEnd ℂ) (foAmp b b' i) * ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ))
                  • hermiteMvLp (a - Finsupp.single i 1)) := by
  have hcoe : (fqOp P Q S b b' (hermiteCore a) : L2d d)
      = ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgMap (fqPoly P Q S b b' (hermiteMv a)) := by
    have h := coreOp_coe (fqPoly P Q S b b') (((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • hermiteMv a)
    rw [← HermiteProductBasis.pgMap_apply, map_smul (fqPoly P Q S b b'),
      map_smul (pgMap (d := d))] at h
    exact h
  rw [hcoe, fqPoly, LinearMap.add_apply, fqQuadPoly_hermiteMv, map_add, map_add, map_sum,
    smul_add, smul_add, Finset.smul_sum]
  congr 1
  · congr 1
    · rw [map_smul, smul_comm, HermiteProductBasis.pgMap_apply, pgLp_hermiteMv_eq, smul_smul,
        smul_smul, mul_assoc, inv_mul_cancel₀ (hermiteMvNorm_ne_zero a), mul_one]
    · refine Finset.sum_congr rfl fun i _ => ?_
      rw [map_sum, Finset.smul_sum]
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [map_add, map_add, smul_add, smul_add, map_smul, map_smul, map_smul]
      congr 1
      · congr 1
        · rw [smul_comm, HermiteProductBasis.pgMap_apply, ascendP_Lp, smul_smul]
        · rw [HermiteProductBasis.pgMap_apply]
          exact descendP_Lp i j a ((starRingEnd ℂ) (fqAmp P Q S i j))
      · rw [HermiteProductBasis.pgMap_apply]
        exact exchange_Lp i j a (fqExch P Q S i j)
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
theorem fqOp_deficiencyTrivialAt (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ)
    {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (polyGaussCore (d := d)) (fqOp P Q S b b') z := by
  classical
  intro w hw
  set u : (Fin d →₀ ℕ) → ℂ := fun a => (inner ℂ (hermiteMvLp (d := d) a) w : ℂ) with hu
  have hbes : ∀ F : Finset (Fin d →₀ ℕ), ∑ a ∈ F, ‖u a‖ ^ 2 ≤ ‖w‖ ^ 2 := fun F =>
    Orthonormal.sum_inner_products_le (𝕜 := ℂ) w (orthonormal_hermiteMvLp (d := d))
  have hM : ∀ i j : Fin d, (fun i j => (starRingEnd ℂ) (fqExch P Q S i j)) j i
      = (starRingEnd ℂ) ((fun i j => (starRingEnd ℂ) (fqExch P Q S i j)) i j) := by
    intro i j
    simp only [Complex.conj_conj]
    exact fqExch_hermitian P Q S j i
  have hrec : LadderRecQ u (fun _ => fqSymbol P Q) (foAmp b b') (fqAmp P Q S)
      (fun i j => (starRingEnd ℂ) (fqExch P Q S i j)) z := by
    intro a
    have h := hw (hermiteCore a)
    rw [fqOp_hermiteCore P Q S b b' a, inner_add_left, inner_add_left, inner_smul_left,
      Complex.conj_ofReal, sum_inner, sum_inner] at h
    rw [hermiteCore_coe] at h
    have hq : ∀ i : Fin d,
        (inner ℂ (∑ j, ((fqAmp P Q S i j * ((rcp a i j : ℝ) : ℂ))
                    • hermiteMvLp (d := d) (a + pvec i j)
                + ((starRingEnd ℂ) (fqAmp P Q S i j) * ((lcp a i j : ℝ) : ℂ))
                    • hermiteMvLp (d := d) (a - pvec i j)
                + (fqExch P Q S i j * ((rcm a i j : ℝ) : ℂ))
                    • hermiteMvLp (d := d) (shiftm a i j))) w : ℂ)
        = ∑ j, ((starRingEnd ℂ) (fqAmp P Q S i j) * ((rcp a i j : ℝ) : ℂ)
              * u (a + pvec i j)
            + fqAmp P Q S i j * ((lcp a i j : ℝ) : ℂ) * u (a - pvec i j)
            + (starRingEnd ℂ) (fqExch P Q S i j) * ((rcm a i j : ℝ) : ℂ)
              * u (shiftm a i j)) := by
      intro i
      rw [sum_inner]
      refine Finset.sum_congr rfl fun j _ => ?_
      rw [inner_add_left, inner_add_left, inner_smul_left, inner_smul_left, inner_smul_left]
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
    have hsplit : ∀ i : Fin d,
        ∑ j, ((starRingEnd ℂ) (fqAmp P Q S i j) * ((rcp a i j : ℝ) : ℂ) * u (a + pvec i j)
            + fqAmp P Q S i j * ((lcp a i j : ℝ) : ℂ) * u (a - pvec i j)
            + (starRingEnd ℂ) (fqExch P Q S i j) * ((rcm a i j : ℝ) : ℂ) * u (shiftm a i j))
        = ∑ j, ((starRingEnd ℂ) (fqAmp P Q S i j) * ((rcp a i j : ℝ) : ℂ) * u (a + pvec i j)
              + fqAmp P Q S i j * ((lcp a i j : ℝ) : ℂ) * u (a - pvec i j))
          + ∑ j, ((starRingEnd ℂ) (fqExch P Q S i j) * ((rcm a i j : ℝ) : ℂ)
              * u (shiftm a i j)) := by
      intro i
      rw [← Finset.sum_add_distrib]
    rw [Finset.sum_congr rfl (fun i _ => hsplit i), Finset.sum_add_distrib] at h
    linear_combination h
  have hzero : ∀ a, u a = 0 := ladderQ_eq_zero hz hbes hM hrec
  exact hermiteMvLp_total w fun a => hzero a

/-- **HEADLINE.**  For *arbitrary* real matrices `P, Q, S` and *arbitrary* real vectors
`b, b'`, the general real quadratic Hamiltonian

`H = ∑_{i,j} (Pᵢⱼπᵢπⱼ + Qᵢⱼxᵢxⱼ + Sᵢⱼ·½(xᵢπⱼ + πⱼxᵢ)) + ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)`

is essentially self-adjoint on the Gauss–polynomial (product Hermite) core of `L²(ℝᵈ)`.
Distinct modes may be coupled arbitrarily; there is no ellipticity, no sign condition, no
non-degeneracy, no classical equilibrium and no change of core. -/
theorem fqOp_essentiallySelfAdjoint (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (fqOp P Q S b b') :=
  ⟨fqOp_deficiencyTrivialAt P Q S b b' (by simp),
    fqOp_deficiencyTrivialAt P Q S b b' (by simp)⟩

/-- **The complete unitary flow** generated by the closure of the Hamiltonian. -/
theorem fqOp_stone_flow (P Q S : Fin d → Fin d → ℝ) (b b' : Fin d → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (fqOp P Q S b b') T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense (fqOp_symmetric P Q S b b')
    (fqOp_essentiallySelfAdjoint P Q S b b')

/-- **The purely off-diagonal cross term.**  For `i ≠ j` the Weyl-ordered mixed generator
`½(xᵢπⱼ + πⱼxᵢ) + ½(xⱼπᵢ + πᵢxⱼ)` — the quadratic Hamiltonian which couples two distinct
modes and nothing else — is essentially self-adjoint on the plain Gauss–polynomial
core. -/
theorem crossTerm_essentiallySelfAdjoint (S : Fin d → Fin d → ℝ) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (fqOp 0 0 S 0 0) :=
  fqOp_essentiallySelfAdjoint 0 0 S 0 0

/-- The unitary flow generated by a purely off-diagonal cross term. -/
theorem crossTerm_stone_flow (S : Fin d → Fin d → ℝ) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (fqOp (d := d) 0 0 S 0 0) T.op ∧ IsStoneFlow T U :=
  fqOp_stone_flow 0 0 S 0 0

/-! ## 5. The angular-momentum generators

An **antisymmetric** exchange matrix `S` picks out the rotation generators: since `xᵢ`
and `πⱼ` commute for `i ≠ j` and the diagonal of `S` vanishes,
`∑_{i,j} Sᵢⱼ·½(xᵢπⱼ + πⱼxᵢ) = ∑_{i<j} Sᵢⱼ (xᵢπⱼ − xⱼπᵢ)`.  The elementary antisymmetric
matrix therefore realizes the angular-momentum generator `xₖπ_l − x_lπₖ`, the compact
counterpart of the dilation generator of `BookProof.ModeQuadratic`. -/

/-- The elementary antisymmetric matrix `E_{kl} − E_{lk}`. -/
def rotMat (k l : Fin d) : Fin d → Fin d → ℝ := fun i j =>
  (if i = k then (if j = l then (1 : ℝ) else 0) else 0)
    - (if i = l then (if j = k then (1 : ℝ) else 0) else 0)

/-- With the elementary antisymmetric exchange matrix the quadratic part is exactly the
**angular-momentum generator** `xₖπ_l − x_lπₖ` (Weyl-ordered). -/
theorem fqQuadPoly_rotMat (k l : Fin d) :
    fqQuadPoly (d := d) 0 0 (rotMat k l)
      = BookProof.YangMillsHermite.weylProd (mulXPoly k) (momPoly l)
        - BookProof.YangMillsHermite.weylProd (mulXPoly l) (momPoly k) := by
  classical
  simp only [fqQuadPoly, Pi.zero_apply, Complex.ofReal_zero, zero_smul, zero_add, rotMat,
    Complex.ofReal_sub, sub_smul, Finset.sum_sub_distrib]
  simp

/-- **The angular-momentum generator is essentially self-adjoint** on the plain
Gauss–polynomial core, for every pair of coordinate directions. -/
theorem angularMomentum_essentiallySelfAdjoint (k l : Fin d) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (fqOp 0 0 (rotMat k l) 0 0) :=
  fqOp_essentiallySelfAdjoint 0 0 (rotMat k l) 0 0

/-- The complete unitary rotation flow generated by an angular-momentum generator. -/
theorem angularMomentum_stone_flow (k l : Fin d) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (fqOp (d := d) 0 0 (rotMat k l) 0 0) T.op ∧ IsStoneFlow T U :=
  fqOp_stone_flow 0 0 (rotMat k l) 0 0

end

end BookProof.FullQuadratic
