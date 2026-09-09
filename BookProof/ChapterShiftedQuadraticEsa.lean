import Mathlib
import BookProof.ChapterShiftedHermiteCore
import BookProof.ChapterStoneBridge

/-!
# The indefinite quadratic Hamiltonian with an unbounded first-order perturbation

`BookProof.ChapterHyperbolicQuadraticEsa` proves that the diagonal quadratic Hamiltonian
`H_c = ∑ᵢ cᵢ(πᵢ² + xᵢ²/4)` is essentially self-adjoint on the Gauss–polynomial core for
**every** real weight vector `c` — no sign condition — and
`BookProof.ChapterHermiteRelativeBound` adds an arbitrary first-order term
`B = ∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)` by a Kato–Rellich relative bound, but only for **strictly positive**
weights: in the indefinite case the symbol of `H_c` vanishes on infinitely many
multi-indices, `H_c` does not dominate the number operator, and no relative bound holds.
That indefinite case was the recorded boundary of that module.

This module removes it, by *completing the square* rather than by a perturbation estimate.
For weights `cᵢ ≠ 0` of **arbitrary sign** and arbitrary real `b, b'` the operator

`H = ∑ᵢ (cᵢ(πᵢ² + xᵢ²/4) + bᵢxᵢ + b'ᵢπᵢ)`,  `πᵢ = −i∂/∂xᵢ`,

is symmetric and essentially self-adjoint on the **phase-space translate** of the Hermite
core built in `BookProof.ChapterShiftedHermiteCore`,

`D_{a,k} = { p(x − a) e^{-‖x−a‖²/4} e^{i⟨k,x⟩} }`,  `aᵢ = −2bᵢ/cᵢ`,  `kᵢ = −b'ᵢ/(2cᵢ)`,

which is again a dense subspace of `L²(ℝᵈ)` (`polyGaussCoreT_dense`).  The classical
equilibrium of the completed square is `x = a` with momentum `k`, and on that recentred,
boosted core the Hamiltonian is again diagonal:

`H ψ_{α,a,k} = (∑ᵢ cᵢ(αᵢ + ½) − ∑ᵢ (b'ᵢ²/(4cᵢ) + bᵢ²/cᵢ)) ψ_{α,a,k}`.

## What is proved

* `oscTPoly`, `oscTPoly_apply`, `shiftedHPoly` — the Hamiltonian in the polynomial
  coordinates of the translated, modulated frame;
* `shiftVec`, `boostVec`, `shiftConst`, `shiftedHPoly_eq_quadPoly` — **completing the
  square**: with the classical equilibrium as translation and boost, the first-order term
  disappears and the symbol becomes `H_c` plus a real constant;
* `shiftedHOp`, `shiftedHOp_hermiteTLp` — the operator on the translated core, and its
  diagonal action on the translated, modulated product Hermite functions;
* `shiftedHOp_symmetric`, `shiftedHOp_essentiallySelfAdjoint` — **the headline**;
* `shiftedHPoly_apply_eq_differential` — the **identification**: pointwise, `H` really is
  `∑ᵢ (cᵢ(−∂ᵢ²f + xᵢ²f/4) + bᵢxᵢf + b'ᵢ(−i∂ᵢf))`, with Mathlib's `deriv` along the
  coordinate lines;
* `shiftedHOp_not_bounded` — the operator is genuinely unbounded;
* `shiftedHOp_stone_flow` — the resulting complete unitary Schrödinger flow, by Stone's
  theorem;
* `wave_indefiniteQuadratic_linear_essentiallySelfAdjoint` — the Minkowski corollary:
  `□ + (t² − ‖x‖²)/4 + ⟨b, (t,x)⟩` (an indefinite quadratic potential *and* a constant
  external field) is essentially self-adjoint on a dense core of `L²(ℝ^{1+n})`.

## Honest boundary

`cᵢ ≠ 0` is used exactly once, to solve for the classical equilibrium; if some `cᵢ = 0`
and the corresponding `bᵢ` or `b'ᵢ` is non-zero the square cannot be completed in that
coordinate (the motion is free, and the operator is a different — still essentially
self-adjoint, but not diagonalizable in this basis — object).  The core is the *translated*
Hermite core `D_{a,k}`, not `polyGaussCore`; the two are unitarily equivalent (they are
Weyl translates of one another) but not equal.  Nothing here claims a general
Faris–Lavine potential.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

namespace BookProof.ShiftedQuadratic

open MeasureTheory MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HyperbolicQuadratic
open BookProof.ShiftedHermiteCore
open BookProof.FarisLavine
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

/-! ## 1. The Hamiltonian in the translated, modulated polynomial coordinates -/

/-- The one-coordinate oscillator `πᵢ² + xᵢ²/4` in the translated, modulated frame. -/
def oscTPoly (a k : Vd d) (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  (momTPoly k i).comp (momTPoly k i) + (1/4 : ℂ) • ((mulXTPoly a i).comp (mulXTPoly a i))

theorem oscTPoly_apply (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    oscTPoly a k i p = oscPoly i p + (2 * ((k i : ℝ) : ℂ)) • momPoly i p
      + (((a i : ℝ) : ℂ) / 2) • (X i * p)
      + ((((k i : ℝ) : ℂ)) ^ 2 + ((a i : ℝ) : ℂ) ^ 2 / 4) • p := by
  simp only [oscTPoly, LinearMap.add_apply, LinearMap.comp_apply, LinearMap.smul_apply,
    momTPoly_apply, mulXTPoly_apply, oscPoly, map_add, map_smul, mulXPoly_apply]
  module

/-- The full Hamiltonian `∑ᵢ (cᵢ(πᵢ² + xᵢ²/4) + bᵢxᵢ + b'ᵢπᵢ)` in the polynomial
coordinates of the translated, modulated frame. -/
def shiftedHPoly (a k : Vd d) (c b b' : Fin d → ℝ) :
    MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  ∑ i, (((c i : ℝ) : ℂ) • oscTPoly a k i + ((b i : ℝ) : ℂ) • mulXTPoly a i
        + ((b' i : ℝ) : ℂ) • momTPoly k i)

theorem shiftedHPoly_apply (a k : Vd d) (c b b' : Fin d → ℝ) (p : MvPolynomial (Fin d) ℂ) :
    shiftedHPoly a k c b b' p
      = ∑ i, (((c i : ℝ) : ℂ) • oscTPoly a k i p + ((b i : ℝ) : ℂ) • mulXTPoly a i p
          + ((b' i : ℝ) : ℂ) • momTPoly k i p) := by
  simp [shiftedHPoly, LinearMap.sum_apply]

/-! ## 2. Completing the square -/

/-- The classical equilibrium position `aᵢ = −2bᵢ/cᵢ`. -/
def shiftVec (c b : Fin d → ℝ) : Vd d := (WithLp.toLp 2 (fun i => -2 * b i / c i) : Vd d)

/-- The classical equilibrium momentum `kᵢ = −b'ᵢ/(2cᵢ)`. -/
def boostVec (c b' : Fin d → ℝ) : Vd d := (WithLp.toLp 2 (fun i => -b' i / (2 * c i)) : Vd d)

@[simp] theorem shiftVec_apply (c b : Fin d → ℝ) (i : Fin d) :
    (shiftVec c b) i = -2 * b i / c i := rfl

@[simp] theorem boostVec_apply (c b' : Fin d → ℝ) (i : Fin d) :
    (boostVec c b') i = -b' i / (2 * c i) := rfl

/-- The constant produced by completing the square,
`−∑ᵢ (b'ᵢ²/(4cᵢ) + bᵢ²/cᵢ)`. -/
def shiftConst (c b b' : Fin d → ℝ) : ℝ :=
  ∑ i, (-(b' i ^ 2) / (4 * c i) - b i ^ 2 / c i)

/-- **Completing the square, one coordinate at a time.** -/
theorem shiftedHPoly_term (c b b' : Fin d → ℝ) (i : Fin d) (hc : c i ≠ 0)
    (p : MvPolynomial (Fin d) ℂ) :
    ((c i : ℝ) : ℂ) • oscTPoly (shiftVec c b) (boostVec c b') i p
        + ((b i : ℝ) : ℂ) • mulXTPoly (shiftVec c b) i p
        + ((b' i : ℝ) : ℂ) • momTPoly (boostVec c b') i p
      = ((c i : ℝ) : ℂ) • oscPoly i p
        + (((-(b' i ^ 2) / (4 * c i) - b i ^ 2 / c i : ℝ)) : ℂ) • p := by
  have hcC : ((c i : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hc
  rw [oscTPoly_apply, mulXTPoly_apply, momTPoly_apply, shiftVec_apply, boostVec_apply]
  push_cast
  match_scalars <;> field_simp <;> ring

/-- **Completing the square.**  With the classical equilibrium as translation and boost,
the first-order term disappears and the Hamiltonian becomes `H_c` plus a real constant. -/
theorem shiftedHPoly_eq_quadPoly (c b b' : Fin d → ℝ) (hc : ∀ i, c i ≠ 0)
    (p : MvPolynomial (Fin d) ℂ) :
    shiftedHPoly (shiftVec c b) (boostVec c b') c b b' p
      = quadPoly c p + ((shiftConst c b b' : ℝ) : ℂ) • p := by
  rw [shiftedHPoly_apply, Finset.sum_congr rfl fun i _ => shiftedHPoly_term c b b' i (hc i) p,
    Finset.sum_add_distrib]
  congr 1
  · rw [quadPoly, LinearMap.sum_apply]
    exact Finset.sum_congr rfl fun i _ => rfl
  · rw [← Finset.sum_smul, shiftConst]
    congr 1
    push_cast
    ring

/-! ## 3. The operator on the translated core, and its diagonal action -/

/-- **The Hamiltonian on the translated, modulated Hermite core of `L²(ℝᵈ)`.** -/
def shiftedHOp (a k : Vd d) (c b b' : Fin d → ℝ) : (polyGaussCoreT a k) →ₗ[ℂ] L2d d :=
  (polyGaussCoreT a k).subtype ∘ₗ coreOpT a k (shiftedHPoly a k c b b')

theorem pgLpT_hermiteTLp (a k : Vd d) (α : Fin d →₀ ℕ) :
    pgLpT a k (((hermiteMvNorm α : ℝ) : ℂ)⁻¹ • hermiteMv α) = hermiteTLp a k α := by
  rw [pgLpT_smul]; rfl

/-- **The diagonal action**: on the recentred, boosted Hermite functions the Hamiltonian
acts by `∑ᵢ cᵢ(αᵢ + ½) + shiftConst`. -/
theorem shiftedHOp_hermiteTLp (c b b' : Fin d → ℝ) (hc : ∀ i, c i ≠ 0) (α : Fin d →₀ ℕ)
    (h : hermiteTLp (shiftVec c b) (boostVec c b') α
      ∈ polyGaussCoreT (shiftVec c b) (boostVec c b')) :
    shiftedHOp (shiftVec c b) (boostVec c b') c b b' ⟨_, h⟩
      = (((quadSymbol c α + shiftConst c b b' : ℝ)) : ℂ)
          • hermiteTLp (shiftVec c b) (boostVec c b') α := by
  set a := shiftVec c b
  set k := boostVec c b'
  have hcoe : (⟨hermiteTLp a k α, h⟩ : polyGaussCoreT a k)
      = coreEquivT a k (((hermiteMvNorm α : ℝ) : ℂ)⁻¹ • hermiteMv α) := by
    apply Subtype.ext
    rw [coreEquivT_coe, pgLpT_hermiteTLp]
  rw [hcoe]
  simp only [shiftedHOp, LinearMap.comp_apply, Submodule.subtype_apply]
  rw [coreOpT_coe, map_smul, shiftedHPoly_eq_quadPoly c b b' hc, quadPoly_hermiteMv,
    smul_add, smul_smul, smul_smul, ← add_smul, pgLpT_smul]
  rw [hermiteTLp, smul_smul]
  congr 1
  push_cast
  ring

/-! ## 4. Symmetry, essential self-adjointness, unboundedness -/

/-- **The Hamiltonian is symmetric** on the translated, modulated Hermite core. -/
theorem shiftedHOp_symmetric (c b b' : Fin d → ℝ) (hc : ∀ i, c i ≠ 0) :
    SymmetricOn (polyGaussCoreT (shiftVec c b) (boostVec c b'))
      (shiftedHOp (shiftVec c b) (boostVec c b') c b b') :=
  symmetricOn_of_diagonal (hermiteTLp (shiftVec c b) (boostVec c b'))
    (orthonormal_hermiteTLp _ _) (fun α => quadSymbol c α + shiftConst c b b')
    (span_hermiteTLp _ _) _ (fun α h => shiftedHOp_hermiteTLp c b b' hc α h)

/-- The deficiency spaces vanish at every non-real point. -/
theorem shiftedHOp_deficiencyTrivialAt (c b b' : Fin d → ℝ) (hc : ∀ i, c i ≠ 0) {z : ℂ}
    (hz : z.im ≠ 0) :
    DeficiencyTrivialAt (polyGaussCoreT (shiftVec c b) (boostVec c b'))
      (shiftedHOp (shiftVec c b) (boostVec c b') c b b') z :=
  deficiencyTrivialAt_of_diagonal (hermiteTLp (shiftVec c b) (boostVec c b'))
    (fun α => quadSymbol c α + shiftConst c b b') (hermiteTLp_total _ _) _
    (hermiteTLp_mem_coreT _ _) (fun α h => shiftedHOp_hermiteTLp c b b' hc α h) hz

/-- **The headline.**  For weights `cᵢ ≠ 0` of arbitrary sign and arbitrary real `b, b'`,
the operator `∑ᵢ (cᵢ(πᵢ² + xᵢ²/4) + bᵢxᵢ + b'ᵢπᵢ)` is essentially self-adjoint on the
translated, modulated Hermite core `D_{a,k}` of `L²(ℝᵈ)`. -/
theorem shiftedHOp_essentiallySelfAdjoint (c b b' : Fin d → ℝ) (hc : ∀ i, c i ≠ 0) :
    EssentiallySelfAdjointOn (polyGaussCoreT (shiftVec c b) (boostVec c b'))
      (shiftedHOp (shiftVec c b) (boostVec c b') c b b') :=
  ⟨shiftedHOp_deficiencyTrivialAt c b b' hc (by simp),
   shiftedHOp_deficiencyTrivialAt c b b' hc (by simp)⟩

/-- The core is dense, so the statement above is a genuine essential self-adjointness
statement. -/
theorem shiftedCore_dense (c b b' : Fin d → ℝ) :
    Dense ((polyGaussCoreT (shiftVec c b) (boostVec c b')
      : Submodule ℂ (L2d d)) : Set (L2d d)) :=
  polyGaussCoreT_dense _ _

/-- **The Hamiltonian generates a complete unitary flow.** -/
theorem shiftedHOp_stone_flow (c b b' : Fin d → ℝ) (hc : ∀ i, c i ≠ 0) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (shiftedHOp (shiftVec c b) (boostVec c b') c b b') T.op ∧
        IsStoneFlow T U :=
  exists_stone_flow_of_esa _ (shiftedCore_dense c b b') (shiftedHOp_symmetric c b b' hc)
    (shiftedHOp_essentiallySelfAdjoint c b b' hc)

/-- The operator is genuinely unbounded as soon as one weight is non-zero. -/
theorem shiftedHOp_not_bounded (c b b' : Fin d → ℝ) (hc : ∀ i, c i ≠ 0) {i : Fin d} :
    ¬ ∃ C : ℝ, ∀ f : polyGaussCoreT (shiftVec c b) (boostVec c b'),
        ‖shiftedHOp (shiftVec c b) (boostVec c b') c b b' f‖ ≤ C * ‖(f : L2d d)‖ := by
  classical
  rintro ⟨C, hC⟩
  set S : ℝ := ∑ j, c j * (1/2) + shiftConst c b b' with hS
  set K : ℝ := |S| with hK
  obtain ⟨n, hn⟩ := exists_nat_gt ((C + K) / |c i|)
  set α : Fin d →₀ ℕ := Finsupp.single i n with hα
  have hnorm : ‖hermiteTLp (d := d) (shiftVec c b) (boostVec c b') α‖ = 1 :=
    (orthonormal_hermiteTLp _ _).norm_eq_one α
  have h := hC ⟨hermiteTLp (shiftVec c b) (boostVec c b') α,
    hermiteTLp_mem_coreT (shiftVec c b) (boostVec c b') α⟩
  rw [shiftedHOp_hermiteTLp c b b' hc α
    (hermiteTLp_mem_coreT (shiftVec c b) (boostVec c b') α), norm_smul] at h
  simp only [hnorm, mul_one, Complex.norm_real, Real.norm_eq_abs] at h
  have hci' : 0 < |c i| := abs_pos.mpr (hc i)
  have hsym : quadSymbol c α + shiftConst c b b' = c i * (n : ℝ) + S := by
    rw [hα, quadSymbol_single, hS]
    ring
  have hlow : |c i| * (n : ℝ) - K ≤ |quadSymbol c α + shiftConst c b b'| := by
    have htri : |c i * (n : ℝ)| ≤ |c i * (n : ℝ) + S| + K := by
      have h1 := abs_add_le (c i * (n : ℝ) + S) (-S)
      rw [hK]
      simpa using h1
    have habs : |c i * (n : ℝ)| = |c i| * (n : ℝ) := by
      rw [abs_mul, Nat.abs_cast]
    rw [hsym]
    linarith [htri, habs.symm.le, habs.le]
  have hbig : C < |c i| * (n : ℝ) - K := by
    have hmul : (C + K) < |c i| * (n : ℝ) := by
      rw [div_lt_iff₀ hci'] at hn
      linarith [hn]
    linarith
  linarith [h, hlow, hbig]

/-! ## 5. The differential identification -/

/-- The coordinate derivative `∂ᵢ` in the translated, modulated frame. -/
def dPolyT (k : Vd d) (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ :=
  dPoly i + (Complex.I * ((k i : ℝ) : ℂ)) • LinearMap.id

@[simp] theorem dPolyT_apply (k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    dPolyT k i p = dPoly i p + (Complex.I * ((k i : ℝ) : ℂ)) • p := rfl

theorem momTPoly_eq_smul (k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momTPoly k i p = (-Complex.I) • dPolyT k i p := by
  rw [momTPoly_apply, dPolyT_apply, momPoly_apply' i p, ← dPoly_apply]
  match_scalars <;> (ring_nf; all_goals (rw [Complex.I_sq]; ring))

/-- The derivative along the `i`-th coordinate line, at every point of the line. -/
theorem deriv_pgFunT_sec_at (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d)
    (t : ℝ) : deriv (fun s : ℝ => pgFunT a k p (sec i x s)) t
      = pgFunT a k (dPolyT k i p) (sec i x t) := by
  have h := deriv_pgFunT_sec a k i p (sec i x t)
  rw [sec_coord] at h
  simp only [sec_sec] at h
  rw [h, dPolyT_apply, pgFunT_apply_add, pgFunT_apply_smul]

/-- The **second** derivative along the `i`-th coordinate line. -/
theorem deriv2_pgFunT_sec (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    deriv (fun t : ℝ => deriv (fun s : ℝ => pgFunT a k p (sec i x s)) t) (x i)
      = pgFunT a k (dPolyT k i (dPolyT k i p)) x := by
  have hfun : (fun t : ℝ => deriv (fun s : ℝ => pgFunT a k p (sec i x s)) t)
      = fun t : ℝ => pgFunT a k (dPolyT k i p) (sec i x t) :=
    funext fun t => deriv_pgFunT_sec_at a k i p x t
  rw [hfun, deriv_pgFunT_sec_at a k i (dPolyT k i p) x (x i), sec_self]

/-- **The square of the momentum is minus the second derivative.** -/
theorem pgFunT_momTPoly_sq (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFunT a k (momTPoly k i (momTPoly k i p)) x
      = -deriv (fun t : ℝ => deriv (fun s : ℝ => pgFunT a k p (sec i x s)) t) (x i) := by
  have h1 : momTPoly k i (momTPoly k i p) = (-1 : ℂ) • dPolyT k i (dPolyT k i p) := by
    conv_lhs => rw [momTPoly_eq_smul k i (momTPoly k i p)]
    rw [momTPoly_eq_smul k i p, map_smul, smul_smul]
    congr 1
    linear_combination Complex.I_mul_I
  rw [h1, pgFunT_apply_smul, deriv2_pgFunT_sec]
  ring

theorem pgFunT_apply_zero (a k : Vd d) (x : Vd d) : pgFunT a k 0 x = 0 := by
  simp [pgFunT, pgFun]

theorem pgFunT_apply_sum {ι : Type*} (a k : Vd d) (s : Finset ι)
    (f : ι → MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFunT a k (∑ v ∈ s, f v) x = ∑ v ∈ s, pgFunT a k (f v) x := by
  classical
  induction s using Finset.induction with
  | empty => simp [pgFunT_apply_zero]
  | insert v s hv ih => rw [Finset.sum_insert hv, Finset.sum_insert hv, pgFunT_apply_add, ih]

theorem oscTPoly_eq (a k : Vd d) (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    oscTPoly a k i p
      = momTPoly k i (momTPoly k i p) + (1/4 : ℂ) • (mulXTPoly a i (mulXTPoly a i p)) := by
  simp [oscTPoly]

/-- **The identification.**  Pointwise, the Hamiltonian on the translated, modulated core
really is the differential operator
`∑ᵢ (cᵢ(−∂ᵢ²f + xᵢ²f/4) + bᵢxᵢf + b'ᵢ(−i∂ᵢf))`, with Mathlib's `deriv` along the coordinate
lines. -/
theorem shiftedHPoly_apply_eq_differential (a k : Vd d) (c b b' : Fin d → ℝ)
    (p : MvPolynomial (Fin d) ℂ) (x : Vd d) :
    pgFunT a k (shiftedHPoly a k c b b' p) x
      = ∑ i, (((c i : ℝ) : ℂ)
            * (-deriv (fun t : ℝ => deriv (fun s : ℝ => pgFunT a k p (sec i x s)) t) (x i)
                + (((x i : ℝ) : ℂ) ^ 2 / 4) * pgFunT a k p x)
          + ((b i : ℝ) : ℂ) * (((x i : ℝ) : ℂ) * pgFunT a k p x)
          + ((b' i : ℝ) : ℂ)
              * (-Complex.I * deriv (fun t : ℝ => pgFunT a k p (sec i x t)) (x i))) := by
  rw [shiftedHPoly_apply, pgFunT_apply_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [pgFunT_apply_add, pgFunT_apply_add, pgFunT_apply_smul, pgFunT_apply_smul,
    pgFunT_apply_smul, oscTPoly_eq, pgFunT_apply_add, pgFunT_apply_smul,
    pgFunT_momTPoly_sq, pgFunT_mulXTPoly, pgFunT_mulXTPoly, pgFunT_momTPoly]
  ring

/-- The same identification for the operator on the core: the `L²` class of `H f` is the
class of the differential expression. -/
theorem shiftedHOp_coe_eq_pgLpT (a k : Vd d) (c b b' : Fin d → ℝ)
    (p : MvPolynomial (Fin d) ℂ) :
    shiftedHOp a k c b b' (coreEquivT a k p) = pgLpT a k (shiftedHPoly a k c b b' p) := by
  simp only [shiftedHOp, LinearMap.comp_apply, Submodule.subtype_apply]
  rw [coreOpT_coe]

/-! ## 6. The Minkowski corollary -/

theorem minkowskiCoeff_ne_zero (n : ℕ) (i : Fin (1 + n)) : minkowskiCoeff n i ≠ 0 := by
  by_cases h : i = 0 <;> simp [minkowskiCoeff, h]

/-- **`□ + V + ⟨b, ·⟩` is essentially self-adjoint on a dense core of `L²(ℝ^{1+n})`.**  Here
`□ = −∂_t² + Δ_x`, `V(t,x) = (t² − ‖x‖²)/4` is the indefinite quadratic potential of
`BookProof.ChapterHyperbolicQuadraticEsa`, and the first-order term
`∑ᵢ (bᵢxᵢ + b'ᵢπᵢ)` is an arbitrary constant external field plus an arbitrary constant
boost — an unbounded perturbation which does not commute with `□ + V`.  The core is the
Hermite core recentred at the classical equilibrium and boosted to the classical
momentum. -/
theorem wave_indefiniteQuadratic_linear_essentiallySelfAdjoint (n : ℕ)
    (b b' : Fin (1 + n) → ℝ) :
    EssentiallySelfAdjointOn
      (polyGaussCoreT (shiftVec (minkowskiCoeff n) b) (boostVec (minkowskiCoeff n) b'))
      (shiftedHOp (shiftVec (minkowskiCoeff n) b) (boostVec (minkowskiCoeff n) b')
        (minkowskiCoeff n) b b') :=
  shiftedHOp_essentiallySelfAdjoint _ b b' (minkowskiCoeff_ne_zero n)

end

end BookProof.ShiftedQuadratic
