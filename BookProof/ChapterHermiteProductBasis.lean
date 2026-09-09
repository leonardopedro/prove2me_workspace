import Mathlib
import BookProof.ChapterHermiteProductCore

/-!
# The product Hermite basis of `L²(ℝᵈ)` and its ladder relations

`BookProof.ChapterHermiteProductCore` builds the Gauss–polynomial core
`polyGaussCore` of `L²(ℝᵈ)` — the polynomials times `e^{-‖x‖²/4}` — proves it dense, and
shows it is the span of the *product Hermite functions*
`ψ_α(x) = ∏ᵢ He_{αᵢ}(xᵢ) · e^{-‖x‖²/4}` (`polyGaussCore_eq_hermiteSpan`).  What it does
*not* do is make that family an orthonormal basis, or relate it to the ladder (creation /
annihilation) operators.  Both are supplied here; they are what the differential
realization of the Navier–Stokes quadratic symbol
(`BookProof.ChapterNavierStokesDifferentialL2`) needs.

## Contents

* `eval_hermiteFactor`, `pgFun_hermiteMv` — the product Hermite function is the product of
  the one-dimensional Hermite functions of `BookProof.ChapterHermiteFunctions`, coordinate
  by coordinate;
* `inner_pgLp_hermiteMv` — the `L²` inner product of two of them is the product of the
  one-dimensional Hermite inner products (Fubini);
* `hermiteMvNorm`, `hermiteMvLp`, `orthonormal_hermiteMvLp`, `span_hermiteMvLp`,
  `hermiteMvBasis` — the **orthonormal (Hilbert) basis** `ψ_α / ‖ψ_α‖` of `L²(ℝᵈ)` indexed
  by the multi-indices `α : Fin d →₀ ℕ`, whose span is exactly the Gauss–polynomial core;
* `pderiv_hermiteMv` — `∂ᵢ He_α = αᵢ He_{α−eᵢ}` for the product Hermite *polynomials*;
* `annPoly`, `crePoly` and `annPoly_hermiteMvLp`, `crePoly_hermiteMvLp` — the polynomial
  incarnations of the ladder operators
  `aᵢ = xᵢ/2 + ∂ᵢ`, `aᵢ† = xᵢ/2 − ∂ᵢ` acting on the Gauss-weighted functions, and their
  action `aᵢψ_α = √αᵢ ψ_{α−eᵢ}`, `aᵢ†ψ_α = √(αᵢ+1) ψ_{α+eᵢ}` on the orthonormal basis.

The Gaussian factor is what turns the *polynomial* operators `p ↦ ∂ᵢp` and
`p ↦ xᵢp − ∂ᵢp` into the *function* operators `f ↦ (xᵢ/2)f + f'` and `f ↦ (xᵢ/2)f − f'`:
`∂ᵢ(p·e^{-‖x‖²/4}) = (∂ᵢp − (xᵢ/2)p)·e^{-‖x‖²/4}`.  The analytic side of that identity is
proved in `BookProof.ChapterNavierStokesDifferentialL2`; here everything is algebraic.
-/

namespace BookProof.HermiteProductBasis

open MeasureTheory MvPolynomial BookProof.HermiteCore BookProof.HermiteProductCore

noncomputable section

variable {d : ℕ}

/-! ## The product Hermite functions, coordinate by coordinate -/

/-- The `d`-dimensional Gaussian is the product of the one-dimensional ones. -/
theorem gaussD_eq_prod (x : Vd d) : gaussD x = ∏ i, gaussH (x i) := by
  have h : ∏ i, gaussH (x i) = Real.exp (∑ i, (-(x i) ^ 2 / 4)) := by
    rw [Real.exp_sum]; rfl
  rw [gaussD, norm_sq_eq_sum, h]
  congr 1
  rw [neg_div, Finset.sum_div, ← Finset.sum_neg_distrib]
  exact Finset.sum_congr rfl fun i _ => by ring

/-- The complexified Hermite polynomial evaluated at a real point is the real one. -/
theorem eval_hermiteCx (n : ℕ) (t : ℝ) :
    Polynomial.eval ((t : ℝ) : ℂ) (hermiteCx n) = (((hermiteR n).eval t : ℝ) : ℂ) := by
  have h := Polynomial.hom_eval₂ (Polynomial.hermite n) (Int.castRingHom ℝ) Complex.ofRealHom t
  have hcomp : (Complex.ofRealHom.comp (Int.castRingHom ℝ)) = Int.castRingHom ℂ := by ext1; simp
  rw [hcomp] at h
  simp only [hermiteCx, hermiteR, Polynomial.eval_map]
  exact h.symm

/-- The `i`-th Hermite factor evaluated at `x` only sees the `i`-th coordinate. -/
theorem eval_hermiteFactor (i : Fin d) (n : ℕ) (x : Vd d) :
    MvPolynomial.eval (fun j => ((x j : ℝ) : ℂ)) (hermiteFactor i n)
      = (((hermiteR n).eval (x i) : ℝ) : ℂ) := by
  have hdef : hermiteFactor i n
      = Polynomial.eval₂ (MvPolynomial.C : ℂ →+* MvPolynomial (Fin d) ℂ) (X i) (hermiteCx n) := by
    rw [hermiteFactor, Polynomial.aeval_def]; rfl
  rw [hdef, Polynomial.hom_eval₂]
  have h : ((MvPolynomial.eval (fun j => ((x j : ℝ) : ℂ))).comp
      (MvPolynomial.C : ℂ →+* MvPolynomial (Fin d) ℂ)) = RingHom.id ℂ := by ext1 c; simp
  rw [h]
  simp only [MvPolynomial.eval_X, Polynomial.eval₂_id]
  exact eval_hermiteCx n (x i)

/-- **The product Hermite function is the product of the one-dimensional Hermite
functions.** -/
theorem pgFun_hermiteMv (a : Fin d →₀ ℕ) (x : Vd d) :
    pgFun (hermiteMv a) x = ((∏ i, hermiteFun (a i) (x i) : ℝ) : ℂ) := by
  rw [pgFun, hermiteMv, map_prod, gaussD_eq_prod]
  push_cast
  rw [← Finset.prod_mul_distrib]
  exact Finset.prod_congr rfl fun i _ => by rw [eval_hermiteFactor]; simp [hermiteFun]

/-- The one-dimensional Hermite inner product, written as an integral of Hermite
functions. -/
theorem integral_hermiteFun_mul (m n : ℕ) :
    ∫ t : ℝ, hermiteFun m t * hermiteFun n t = hermiteInner m n := by
  rw [hermiteInner, gint]
  exact integral_congr_ae (Filter.Eventually.of_forall fun t => hermiteFun_mul m n t)

/-- **Fubini for two product Hermite functions**: their `L²` inner product is the product
of the one-dimensional Hermite inner products. -/
theorem inner_pgLp_hermiteMv (a b : Fin d →₀ ℕ) :
    (inner ℂ (pgLp (hermiteMv a)) (pgLp (hermiteMv b)) : ℂ)
      = ((∏ i, hermiteInner (a i) (b i) : ℝ) : ℂ) := by
  rw [inner_pgLp]
  have key : (∫ x : Vd d, (starRingEnd ℂ) (pgFun (hermiteMv a) x)
        * (pgLp (hermiteMv b) : Vd d → ℂ) x)
      = ∫ x : Vd d, ∏ i, ((hermiteFun (a i) (x i) * hermiteFun (b i) (x i) : ℝ) : ℂ) := by
    refine integral_congr_ae ?_
    filter_upwards [pgLp_coeFn (hermiteMv b)] with x hx
    rw [hx, pgFun_hermiteMv, pgFun_hermiteMv, Complex.conj_ofReal, ← Complex.ofReal_mul,
      ← Finset.prod_mul_distrib, Complex.ofReal_prod]
  rw [key, integral_prod_coord (fun i t => ((hermiteFun (a i) t * hermiteFun (b i) t : ℝ) : ℂ)),
    Complex.ofReal_prod]
  refine Finset.prod_congr rfl fun i _ => ?_
  rw [integral_complex_ofReal, integral_hermiteFun_mul]

/-! ## The orthonormal basis -/

/-- The `L²` norm of the product Hermite function `ψ_α`. -/
def hermiteMvNorm (a : Fin d →₀ ℕ) : ℝ := ∏ i, hermiteNorm (a i)

theorem hermiteMvNorm_pos (a : Fin d →₀ ℕ) : 0 < hermiteMvNorm a :=
  Finset.prod_pos fun i _ => hermiteNorm_pos (a i)

theorem hermiteMvNorm_ne_zero (a : Fin d →₀ ℕ) : ((hermiteMvNorm a : ℝ) : ℂ) ≠ 0 := by
  exact_mod_cast ne_of_gt (hermiteMvNorm_pos a)

/-- **The normalized product Hermite function** `ψ_α / ‖ψ_α‖`. -/
def hermiteMvLp (a : Fin d →₀ ℕ) : L2d d := ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (hermiteMv a)

theorem pgLp_hermiteMv_eq (a : Fin d →₀ ℕ) :
    pgLp (hermiteMv a) = ((hermiteMvNorm a : ℝ) : ℂ) • hermiteMvLp a := by
  rw [hermiteMvLp, smul_smul, mul_inv_cancel₀ (hermiteMvNorm_ne_zero a), one_smul]

theorem inner_hermiteMvLp (a b : Fin d →₀ ℕ) :
    (inner ℂ (hermiteMvLp a) (hermiteMvLp b) : ℂ) = if a = b then 1 else 0 := by
  rw [hermiteMvLp, hermiteMvLp, inner_smul_left, inner_smul_right, inner_pgLp_hermiteMv]
  by_cases hab : a = b
  · subst hab
    have hprod : (∏ i, hermiteInner (a i) (a i)) = hermiteMvNorm a * hermiteMvNorm a := by
      rw [hermiteMvNorm, ← Finset.prod_mul_distrib]
      exact Finset.prod_congr rfl fun i _ => by rw [hermiteNorm_sq, hermiteInner_eq]; simp
    rw [hprod]
    have hne : ((hermiteMvNorm a : ℝ) : ℂ) ≠ 0 := hermiteMvNorm_ne_zero a
    simp only [map_inv₀, Complex.conj_ofReal]
    push_cast
    field_simp
  · have hex : ∃ i, a i ≠ b i := by
      by_contra h
      push_neg at h
      exact hab (Finsupp.ext h)
    obtain ⟨i, hi⟩ := hex
    have h0 : (∏ i, hermiteInner (a i) (b i)) = 0 :=
      Finset.prod_eq_zero (Finset.mem_univ i) (by rw [hermiteInner_eq, if_neg hi])
    rw [h0, if_neg hab]
    simp

theorem orthonormal_hermiteMvLp : Orthonormal ℂ (hermiteMvLp (d := d)) := by
  rw [orthonormal_iff_ite]
  intro a b
  simpa using inner_hermiteMvLp a b

/-- The span of the normalized product Hermite functions is the Gauss–polynomial core. -/
theorem span_hermiteMvLp :
    Submodule.span ℂ (Set.range (hermiteMvLp (d := d))) = polyGaussCore (d := d) := by
  rw [polyGaussCore_eq_hermiteSpan]
  refine le_antisymm ?_ ?_
  · rw [Submodule.span_le]
    rintro _ ⟨a, rfl⟩
    exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨a, rfl⟩)
  · rw [Submodule.span_le]
    rintro _ ⟨a, rfl⟩
    change pgLp (hermiteMv a) ∈ Submodule.span ℂ (Set.range (hermiteMvLp (d := d)))
    rw [pgLp_hermiteMv_eq a]
    exact Submodule.smul_mem _ _ (Submodule.subset_span ⟨a, rfl⟩)

/-- **The product Hermite functions form a Hilbert basis of `L²(ℝᵈ)`**, indexed by the
multi-indices. -/
def hermiteMvBasis : HilbertBasis (Fin d →₀ ℕ) ℂ (L2d d) :=
  HilbertBasis.mk orthonormal_hermiteMvLp
    (by
      rw [span_hermiteMvLp]
      have hd := polyGaussCore_dense (d := d)
      rw [Submodule.dense_iff_topologicalClosure_eq_top] at hd
      rw [hd])

@[simp] theorem hermiteMvBasis_apply (a : Fin d →₀ ℕ) :
    hermiteMvBasis a = hermiteMvLp (d := d) a := by
  rw [hermiteMvBasis, HilbertBasis.coe_mk]

theorem hermiteMvLp_mem_core (a : Fin d →₀ ℕ) : hermiteMvLp a ∈ polyGaussCore (d := d) := by
  rw [← span_hermiteMvLp]
  exact Submodule.subset_span ⟨a, rfl⟩

/-! ## The derivative of a product Hermite polynomial -/

theorem pderiv_aeval_self (i : Fin d) (q : Polynomial ℂ) :
    pderiv i (Polynomial.aeval (X i : MvPolynomial (Fin d) ℂ) q)
      = Polynomial.aeval (X i) (Polynomial.derivative q) := by
  induction q using Polynomial.induction_on with
  | C c => simp
  | add p q hp hq => simp [hp, hq]
  | monomial n c ih =>
      simp only [Polynomial.derivative_C_mul, Polynomial.derivative_X_pow, map_mul,
        Polynomial.aeval_C, map_pow, Polynomial.aeval_X]
      rw [Derivation.leibniz]
      simp [mul_comm, mul_assoc, algebraMap_eq]

theorem pderiv_aeval_other {i j : Fin d} (h : j ≠ i) (q : Polynomial ℂ) :
    pderiv j (Polynomial.aeval (X i : MvPolynomial (Fin d) ℂ) q) = 0 := by
  induction q using Polynomial.induction_on with
  | C c => simp
  | add p q hp hq => simp [hp, hq]
  | monomial n c ih =>
      simp only [map_mul, Polynomial.aeval_C, map_pow, Polynomial.aeval_X]
      rw [Derivation.leibniz]
      simp [h, algebraMap_eq]

theorem pderiv_hermiteFactor_self (i : Fin d) (n : ℕ) :
    pderiv i (hermiteFactor i n) = (n : ℂ) • hermiteFactor i (n - 1) := by
  cases n with
  | zero => simp [hermiteFactor, hermiteCx_zero]
  | succ m =>
      rw [hermiteFactor, pderiv_aeval_self]
      have h : Polynomial.derivative (hermiteCx (m + 1)) = ((m : ℂ) + 1) • hermiteCx m := by
        have hm := congrArg (Polynomial.map (Int.castRingHom ℂ)) (derivative_hermiteZ m)
        simpa [hermiteCx, Polynomial.derivative_map, Polynomial.smul_eq_C_mul,
          Polynomial.map_mul] using hm
      rw [h]
      simp [hermiteFactor, map_smul]

theorem pderiv_hermiteFactor_other {i j : Fin d} (h : j ≠ i) (n : ℕ) :
    pderiv j (hermiteFactor i n) = 0 := pderiv_aeval_other h _

/-- **`∂ᵢ He_α = αᵢ · He_{α−eᵢ}`** for the product Hermite polynomials. -/
theorem pderiv_hermiteMv (i : Fin d) (a : Fin d →₀ ℕ) :
    pderiv i (hermiteMv a) = ((a i : ℂ)) • hermiteMv (a - Finsupp.single i 1) := by
  classical
  have hrest : ∀ b : Fin d →₀ ℕ, (∀ j : Fin d, j ≠ i → b j = a j) →
      ∏ j ∈ Finset.univ.erase i, hermiteFactor j (b j)
        = ∏ j ∈ Finset.univ.erase i, hermiteFactor j (a j) :=
    fun b hb => Finset.prod_congr rfl fun j hj => by rw [hb j (Finset.ne_of_mem_erase hj)]
  have hsub : ∀ j : Fin d, j ≠ i → (a - Finsupp.single i 1 : Fin d →₀ ℕ) j = a j := by
    intro j hj; simp [Finsupp.tsub_apply, hj]
  have hsi : (a - Finsupp.single i 1 : Fin d →₀ ℕ) i = a i - 1 := by simp [Finsupp.tsub_apply]
  have hzero : pderiv i (∏ j ∈ Finset.univ.erase i, hermiteFactor j (a j)) = 0 := by
    refine Finset.prod_induction _ (fun p => pderiv i p = 0) ?_ (by simp) ?_
    · intro p q hp hq
      rw [Derivation.leibniz, hp, hq]; simp
    · intro j hj
      exact pderiv_aeval_other (Finset.ne_of_mem_erase hj).symm _
  rw [hermiteMv_erase i a, hermiteMv_erase i (a - Finsupp.single i 1), hrest _ hsub, hsi,
    Derivation.leibniz, hzero, pderiv_hermiteFactor_self]
  simp [mul_comm]

/-! ## The ladder operators, at the level of polynomials -/

/-- The polynomial incarnation of the annihilation operator: multiplying by the Gaussian,
`p ↦ ∂ᵢp` is the function operator `f ↦ (xᵢ/2)f + ∂ᵢf`. -/
def annPoly (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ where
  toFun p := pderiv i p
  map_add' p q := by simp
  map_smul' c p := by simp

/-- The polynomial incarnation of the creation operator: multiplying by the Gaussian,
`p ↦ xᵢp − ∂ᵢp` is the function operator `f ↦ (xᵢ/2)f − ∂ᵢf`. -/
def crePoly (i : Fin d) : MvPolynomial (Fin d) ℂ →ₗ[ℂ] MvPolynomial (Fin d) ℂ where
  toFun p := X i * p - pderiv i p
  map_add' p q := by simp [mul_add]; ring
  map_smul' c p := by simp [smul_sub]

@[simp] theorem annPoly_apply (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    annPoly i p = pderiv i p := rfl

@[simp] theorem crePoly_apply (i : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    crePoly i p = X i * p - pderiv i p := rfl

/-- `a†` raises the multi-index: `xᵢHe_α − ∂ᵢHe_α = He_{α+eᵢ}`. -/
theorem crePoly_hermiteMv (i : Fin d) (a : Fin d →₀ ℕ) :
    crePoly i (hermiteMv a) = hermiteMv (a + Finsupp.single i 1) := by
  rw [crePoly_apply, hermiteMv_X_mul, pderiv_hermiteMv]
  abel

/-! ### The normalizing constants -/

theorem hermiteNorm_succ (n : ℕ) :
    hermiteNorm (n + 1) = hermiteNorm n * Real.sqrt ((n : ℝ) + 1) := by
  have hfac : ((n + 1).factorial : ℝ) * Real.sqrt (2 * Real.pi)
      = ((n : ℝ) + 1) * ((n.factorial : ℝ) * Real.sqrt (2 * Real.pi)) := by
    rw [Nat.factorial_succ]
    push_cast
    ring
  rw [hermiteNorm, hermiteNorm, hfac, Real.sqrt_mul (by positivity), mul_comm]

theorem hermiteMvNorm_add_single (i : Fin d) (a : Fin d →₀ ℕ) :
    hermiteMvNorm (a + Finsupp.single i 1) = hermiteMvNorm a * Real.sqrt ((a i : ℝ) + 1) := by
  classical
  have hsplit : ∀ b : Fin d →₀ ℕ, hermiteMvNorm b
      = hermiteNorm (b i) * ∏ j ∈ Finset.univ.erase i, hermiteNorm (b j) := by
    intro b
    rw [hermiteMvNorm, ← Finset.mul_prod_erase _ _ (Finset.mem_univ i)]
  have hrest : ∏ j ∈ Finset.univ.erase i, hermiteNorm ((a + Finsupp.single i 1 : Fin d →₀ ℕ) j)
      = ∏ j ∈ Finset.univ.erase i, hermiteNorm (a j) :=
    Finset.prod_congr rfl fun j hj => by
      rw [show (a + Finsupp.single i 1 : Fin d →₀ ℕ) j = a j by
        simp [Finset.ne_of_mem_erase hj]]
  have hai : (a + Finsupp.single i 1 : Fin d →₀ ℕ) i = a i + 1 := by simp
  rw [hsplit (a + Finsupp.single i 1), hrest, hai, hermiteNorm_succ, hsplit a]
  ring

theorem hermiteMvNorm_sub_single {i : Fin d} {a : Fin d →₀ ℕ} (h : 1 ≤ a i) :
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

/-! ### The ladder action on the orthonormal basis -/

theorem pgMap_apply (p : MvPolynomial (Fin d) ℂ) : pgMap p = pgLp p := rfl

/-- **`a†ᵢ ψ_α = √(αᵢ+1) ψ_{α+eᵢ}`.** -/
theorem crePoly_hermiteMvLp (i : Fin d) (a : Fin d →₀ ℕ) :
    ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (crePoly i (hermiteMv a))
      = ((Real.sqrt ((a i : ℝ) + 1) : ℝ) : ℂ) • hermiteMvLp (a + Finsupp.single i 1) := by
  rw [crePoly_hermiteMv, pgLp_hermiteMv_eq (a + Finsupp.single i 1), smul_smul,
    hermiteMvNorm_add_single]
  congr 1
  have hne : ((hermiteMvNorm a : ℝ) : ℂ) ≠ 0 := hermiteMvNorm_ne_zero a
  push_cast
  field_simp

/-- **`aᵢ ψ_α = √αᵢ ψ_{α−eᵢ}`.** -/
theorem annPoly_hermiteMvLp (i : Fin d) (a : Fin d →₀ ℕ) :
    ((hermiteMvNorm a : ℝ) : ℂ)⁻¹ • pgLp (annPoly i (hermiteMv a))
      = ((Real.sqrt ((a i : ℝ)) : ℝ) : ℂ) • hermiteMvLp (a - Finsupp.single i 1) := by
  rw [annPoly_apply, pderiv_hermiteMv, ← pgMap_apply, map_smul, pgMap_apply,
    pgLp_hermiteMv_eq (a - Finsupp.single i 1), smul_smul, smul_smul]
  rcases Nat.eq_zero_or_pos (a i) with h0 | hpos
  · rw [h0]
    simp
  · congr 1
    have hnorm := hermiteMvNorm_sub_single (i := i) (a := a) hpos
    have hsub_pos := hermiteMvNorm_pos (a - Finsupp.single i 1)
    have hai : (0 : ℝ) < (a i : ℝ) := by exact_mod_cast hpos
    have hsqrt_pos : 0 < Real.sqrt ((a i : ℝ)) := Real.sqrt_pos.mpr hai
    have hsqrt : Real.sqrt ((a i : ℝ)) * Real.sqrt ((a i : ℝ)) = (a i : ℝ) :=
      Real.mul_self_sqrt hai.le
    have hreal : (hermiteMvNorm a)⁻¹ * ((a i : ℝ) * hermiteMvNorm (a - Finsupp.single i 1))
        = Real.sqrt ((a i : ℝ)) := by
      rw [hnorm]
      field_simp
      nlinarith [hsqrt, hsub_pos, hsqrt_pos]
    have := congrArg (fun r : ℝ => ((r : ℝ) : ℂ)) hreal
    push_cast at this ⊢
    linear_combination this

end

end BookProof.HermiteProductBasis
