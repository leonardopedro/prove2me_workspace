import Mathlib
import BookProof.ChapterQgOuterFockEsa
import BookProof.ChapterHermiteQuadraticEsa

/-!
# Gaussian-integral bounds on the Gauss–polynomial core

This module is the analytic toolbox behind the Faris–Lavine inequalities for the
quantum-gravity Hamiltonian.  Everything is computed on the Gauss–polynomial core of
`L²(ℝᴰ)` — the vectors `pgLp p = p·e^{−‖x‖²/4}` with `p` a polynomial — where inner
products are Gaussian integrals of polynomials (`gaussInt`) and the harmonic comparison
operator `N = −Δ + ‖x‖²/4` acts as the polynomial map `harmP p = kinPoly p + harmPoly·p`.

The estimates are stated so that **every constant is explicit and none of them depends on
the dimension `D`** except through the coefficients of the operator being estimated; this
is what later lets the same constants serve every particle-number sector of the outer Fock
space.

## What is proved

* `gaussInt_re`, `gaussInt_re_mono`, `norm_pgLp_sq` — the Gaussian integral of a real part,
  its monotonicity, and the `L²` norm of a core vector as a Gaussian integral;
* `coreD_comm`, `coreD_mul`, `coreD_sq_mul`, `coreD_X_comm` — the twisted derivative
  `coreD j = ∂_j − x_j/2` (the annihilation half of the canonical pair on the core):
  it commutes with itself in different directions, obeys the Leibniz rule and satisfies
  the canonical commutation relation `[coreD j, x_j] = 1`;
* `quadForm_harm_eq`, `quadForm_harm_nonneg`, `norm_sq_le_quadForm_harm` — the quadratic
  form of the comparison operator, `⟪u, Nu⟫ = Σ_j ‖coreD j u‖²  + (D/2)‖u‖²`-style
  identities, its positivity, and `‖u‖² ≤ ⟪u, Nu⟫`;
* `shiftNorm` and the family `norm_pgLp_le_shiftNorm`, `norm_harmP_le_shiftNorm`,
  `dim_mul_norm_le_shiftNorm`, `sqrt_dim_mul_norm_le_shiftNorm`,
  `norm_harmPoly_mul_le_shiftNorm`, `norm_kinPoly_le_shiftNorm` — everything that the
  shifted comparison operator `N + 1` controls, in the graph norm `‖(N+1)u‖`;
* `norm_weighted_kin_sq`, `norm_weighted_kin_le` — **the kinetic estimate**: a weighted
  second-order operator `Σ_j c_j ∂_j²` is bounded by `‖(N+1)u‖` with a constant
  proportional to `sup_j |c_j|`, with no dependence on `D`;
* `norm_mul_le_of_pointwise`, `sum_norm_sq_mul_le_of_pointwise` — **the potential
  estimate**: multiplication by a polynomial dominated pointwise by `λ‖x‖²` is bounded by
  `‖(N+1)u‖` with a constant proportional to `λ`.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.GaussCoreQuadBounds

open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine
open BookProof.HermiteQuadraticEsa
open BookProof.QgOuterFock

noncomputable section

variable {D : ℕ}

/-! ## 1. Gaussian integrals: real parts, positivity, monotonicity -/

/-- The real part of a Gaussian integral is the Gaussian integral of the real part. -/
theorem gaussInt_re (r : MvPolynomial (Fin D) ℂ) :
    (gaussInt r).re
      = ∫ x : Vd D, (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) r).re * gaussWD x := by
  rw [gaussInt, ← Complex.reCLM_apply,
    ← ContinuousLinearMap.integral_comp_comm _ (integrable_gwFun r)]
  refine MeasureTheory.integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp [Complex.mul_re]

/-- Monotonicity of the Gaussian integral on real parts. -/
theorem gaussInt_re_mono {r s : MvPolynomial (Fin D) ℂ}
    (h : ∀ x : Vd D, (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) r).re
      ≤ (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) s).re) :
    (gaussInt r).re ≤ (gaussInt s).re := by
  have hint : ∀ t : MvPolynomial (Fin D) ℂ, MeasureTheory.Integrable
      (fun x : Vd D => (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) t).re * gaussWD x) := by
    intro t
    refine ((integrable_gwFun t).re).congr (Filter.Eventually.of_forall fun x => ?_)
    simp
  rw [gaussInt_re, gaussInt_re]
  refine MeasureTheory.integral_mono (hint r) (hint s) fun x => ?_
  have hw : (0 : ℝ) ≤ gaussWD x := le_of_lt (Real.exp_pos _)
  exact mul_le_mul_of_nonneg_right (h x) hw

/-- The squared `L²` norm of a core vector, as a Gaussian integral. -/
theorem norm_pgLp_sq (q : MvPolynomial (Fin D) ℂ) :
    ‖pgLp q‖ ^ 2 = (gaussInt (cpoly q * q)).re := by
  rw [← inner_pgLp_pgLp q q]
  exact (inner_self_eq_norm_sq (𝕜 := ℂ) (pgLp q)).symm

/-! ## 2. The twisted derivative: commutation and the Leibniz rule -/

theorem coreD_comm (j k : Fin D) (p : MvPolynomial (Fin D) ℂ) :
    coreD j (coreD k p) = coreD k (coreD j p) := by
  simp only [coreD, map_sub, pderiv_mul, pderiv_C, pderiv_X, mul_sub]
  rw [BookProof.QuantumGravity3DGauge.pderiv_comm_poly j k p]
  simp only [Pi.single_apply]
  by_cases hjk : j = k
  · subst hjk; ring
  · rw [if_neg hjk, if_neg (Ne.symm hjk)]
    ring

theorem coreD_mul (j : Fin D) (f p : MvPolynomial (Fin D) ℂ) :
    coreD j (f * p) = pderiv j f * p + f * coreD j p := by
  simp only [coreD, pderiv_mul, mul_sub]
  ring

theorem coreD_sq_mul (j : Fin D) (f p : MvPolynomial (Fin D) ℂ) :
    coreD j (coreD j (f * p))
      = pderiv j (pderiv j f) * p + (2 : ℂ) • (pderiv j f * coreD j p)
        + f * coreD j (coreD j p) := by
  rw [coreD_mul, coreD_add, coreD_mul, coreD_mul, two_smul]
  ring

/-- The canonical commutation relation on the core: `[coreD j, X j] = 1`. -/
theorem coreD_X_comm (j : Fin D) (p : MvPolynomial (Fin D) ℂ) :
    coreD j (X j * p) - X j * coreD j p = p := by
  rw [coreD_mul, pderiv_X_self]
  ring

/-! ## 3. The harmonic comparison operator on the core -/

/-- The polynomial realization of the comparison operator `N = −Δ + ‖x‖²/4`. -/
def harmP (p : MvPolynomial (Fin D) ℂ) : MvPolynomial (Fin D) ℂ := kinPoly p + harmPoly * p

/-- The quadratic form of `N` on the core, in polynomial coordinates: the sum over the
coordinates of the squared norms of `coreD j p` and of `X j p / 2`. -/
theorem quadForm_harm_eq (p : MvPolynomial (Fin D) ℂ) :
    quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩
      = ∑ j : Fin D, (‖pgLp (coreD j p)‖ ^ 2 + ‖pgLp (X j * p)‖ ^ 2 / 4) := by
  have hharm : cpoly p * (harmPoly * p)
      = ∑ j : Fin D, ((1 / 4 : ℂ)) • (cpoly (X j * p) * (X j * p)) := by
    rw [harmPoly, Finset.sum_mul, Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [cpoly_mul, cpoly_X, MvPolynomial.smul_eq_C_mul]
    ring
  have hkey : gaussInt (cpoly p * (kinPoly p + harmPoly * p))
      = (∑ j : Fin D, gaussInt (cpoly (coreD j p) * coreD j p))
        + ∑ j : Fin D, (1 / 4 : ℂ) * gaussInt (cpoly (X j * p) * (X j * p)) := by
    rw [mul_add, gaussInt_add, gaussInt_kinPoly, hharm, gaussInt_sum]
    congr 1
    exact Finset.sum_congr rfl fun j _ => gaussInt_smul _ _
  rw [quadForm, harmCore_pgLp, inner_pgLp_pgLp, hkey]
  rw [Complex.add_re, Complex.re_sum, Complex.re_sum, ← Finset.sum_add_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [norm_pgLp_sq, norm_pgLp_sq]
  simp [Complex.mul_re]
  ring

theorem quadForm_harm_nonneg (p : MvPolynomial (Fin D) ℂ) :
    0 ≤ quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩ :=
  harmonicCore_quadForm_nonneg _

/-- **The uncertainty bound**: the harmonic Hamiltonian is bounded below by `d/2`. -/
theorem norm_sq_le_quadForm_harm (p : MvPolynomial (Fin D) ℂ) :
    ((D : ℝ) / 2) * ‖pgLp p‖ ^ 2 ≤ quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩ := by
  have hstep : ∀ j : Fin D, ‖pgLp p‖ ^ 2 / 2
      ≤ ‖pgLp (coreD j p)‖ ^ 2 + ‖pgLp (X j * p)‖ ^ 2 / 4 := by
    intro j
    have hid : cpoly p * p
        = cpoly p * coreD j (X j * p) - cpoly (X j * p) * coreD j p := by
      have h := coreD_X_comm j p
      have hc : cpoly (X j * p) = X j * cpoly p := by rw [cpoly_mul, cpoly_X]
      rw [hc]
      calc cpoly p * p = cpoly p * (coreD j (X j * p) - X j * coreD j p) := by rw [h]
        _ = cpoly p * coreD j (X j * p) - X j * cpoly p * coreD j p := by ring
    have h1 : gaussInt (cpoly p * coreD j (X j * p))
        = -(inner ℂ (pgLp (coreD j p)) (pgLp (X j * p)) : ℂ) := by
      rw [inner_pgLp_pgLp, gaussInt_coreD j p (X j * p), neg_neg]
    have h2 : gaussInt (cpoly (X j * p) * coreD j p)
        = (inner ℂ (pgLp (X j * p)) (pgLp (coreD j p)) : ℂ) := (inner_pgLp_pgLp _ _).symm
    have hns : ‖pgLp p‖ ^ 2
        = -2 * (inner ℂ (pgLp (coreD j p)) (pgLp (X j * p)) : ℂ).re := by
      rw [norm_pgLp_sq, hid, gaussInt_sub, h1, h2]
      have hswap : (inner ℂ (pgLp (X j * p)) (pgLp (coreD j p)) : ℂ).re
          = (inner ℂ (pgLp (coreD j p)) (pgLp (X j * p)) : ℂ).re := by
        rw [← inner_conj_symm (𝕜 := ℂ) (pgLp (coreD j p)) (pgLp (X j * p)), Complex.conj_re]
      rw [Complex.sub_re, Complex.neg_re, hswap]
      ring
    have hcs : |(inner ℂ (pgLp (coreD j p)) (pgLp (X j * p)) : ℂ).re|
        ≤ ‖pgLp (coreD j p)‖ * ‖pgLp (X j * p)‖ :=
      le_trans (Complex.abs_re_le_norm _) (by
        simpa using norm_inner_le_norm (𝕜 := ℂ) (pgLp (coreD j p)) (pgLp (X j * p)))
    have habs := abs_le.mp hcs
    nlinarith [sq_nonneg (‖pgLp (coreD j p)‖ - ‖pgLp (X j * p)‖ / 2),
      norm_nonneg (pgLp (coreD j p)), norm_nonneg (pgLp (X j * p))]
  rw [quadForm_harm_eq]
  have hsum : ∑ _j : Fin D, ‖pgLp p‖ ^ 2 / 2
      ≤ ∑ j : Fin D, (‖pgLp (coreD j p)‖ ^ 2 + ‖pgLp (X j * p)‖ ^ 2 / 4) :=
    Finset.sum_le_sum fun j _ => hstep j
  have hconst : ∑ _j : Fin D, ‖pgLp p‖ ^ 2 / 2 = ((D : ℝ) / 2) * ‖pgLp p‖ ^ 2 := by
    rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
    ring
  rw [← hconst]
  exact hsum

/-! ### The shifted comparison operator `N + 1` dominates everything -/

/-- The norm of the shifted comparison operator applied to a core vector. -/
def shiftNorm (p : MvPolynomial (Fin D) ℂ) : ℝ := ‖pgLp (harmP p) + pgLp p‖

/-- The real part of the inner product is symmetric. -/
theorem re_inner_symm (a b : L2d D) :
    (inner ℂ a b : ℂ).re = (inner ℂ b a : ℂ).re := by
  rw [← inner_conj_symm (𝕜 := ℂ) a b, Complex.conj_re]

/-- The inner product of a core vector with its image under the comparison operator is the
quadratic form. -/
theorem inner_harmP_re (p : MvPolynomial (Fin D) ℂ) :
    (inner ℂ (pgLp (harmP p)) (pgLp p) : ℂ).re
      = quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩ := by
  have h : quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩
      = (inner ℂ (pgLp p) (pgLp (harmP p)) : ℂ).re := by
    rw [quadForm, harmCore_pgLp]
    rfl
  rw [h, re_inner_symm]

theorem shiftNorm_sq (p : MvPolynomial (Fin D) ℂ) :
    shiftNorm p ^ 2 = ‖pgLp (harmP p)‖ ^ 2
      + 2 * quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩ + ‖pgLp p‖ ^ 2 := by
  rw [shiftNorm, norm_add_sq (𝕜 := ℂ)]
  simp only [RCLike.re_to_complex]
  rw [inner_harmP_re]

theorem shiftNorm_nonneg (p : MvPolynomial (Fin D) ℂ) : 0 ≤ shiftNorm p := norm_nonneg _

theorem norm_pgLp_le_shiftNorm (p : MvPolynomial (Fin D) ℂ) : ‖pgLp p‖ ≤ shiftNorm p := by
  have hsq := shiftNorm_sq p
  have hq := quadForm_harm_nonneg p
  nlinarith [norm_nonneg (pgLp p), shiftNorm_nonneg p, sq_nonneg (‖pgLp (harmP p)‖),
    norm_nonneg (pgLp (harmP p))]

theorem norm_harmP_le_shiftNorm (p : MvPolynomial (Fin D) ℂ) :
    ‖pgLp (harmP p)‖ ≤ shiftNorm p := by
  have hsq := shiftNorm_sq p
  have hq := quadForm_harm_nonneg p
  nlinarith [norm_nonneg (pgLp p), shiftNorm_nonneg p, norm_nonneg (pgLp (harmP p))]

/-- The shifted comparison operator is bounded below by `d/2 + 1`. -/
theorem dim_mul_norm_le_shiftNorm (p : MvPolynomial (Fin D) ℂ) :
    ((D : ℝ) / 2 + 1) * ‖pgLp p‖ ≤ shiftNorm p := by
  have hlow := norm_sq_le_quadForm_harm p
  have hcs : (inner ℂ (pgLp p) (pgLp (harmP p) + pgLp p) : ℂ).re
      ≤ ‖pgLp p‖ * shiftNorm p := by
    refine le_trans (Complex.re_le_norm _) ?_
    simpa [shiftNorm] using norm_inner_le_norm (𝕜 := ℂ) (pgLp p) (pgLp (harmP p) + pgLp p)
  have hexp : (inner ℂ (pgLp p) (pgLp (harmP p) + pgLp p) : ℂ).re
      = quadForm harmCore ⟨pgLp p, pgLp_mem_core p⟩ + ‖pgLp p‖ ^ 2 := by
    rw [inner_add_right, Complex.add_re, re_inner_symm (pgLp p) (pgLp (harmP p)),
      inner_harmP_re]
    congr 1
    exact inner_self_eq_norm_sq (𝕜 := ℂ) (pgLp p)
  rcases eq_or_lt_of_le (norm_nonneg (pgLp p)) with h0 | h0
  · rw [← h0]
    simpa using shiftNorm_nonneg p
  · have hkey : ((D : ℝ) / 2 + 1) * ‖pgLp p‖ ^ 2 ≤ ‖pgLp p‖ * shiftNorm p := by
      rw [hexp] at hcs
      nlinarith
    exact le_of_mul_le_mul_right (by nlinarith : ((D : ℝ) / 2 + 1) * ‖pgLp p‖ * ‖pgLp p‖
      ≤ shiftNorm p * ‖pgLp p‖) h0

theorem sqrt_dim_mul_norm_le_shiftNorm (p : MvPolynomial (Fin D) ℂ) :
    Real.sqrt ((D : ℝ) / 2) * ‖pgLp p‖ ≤ shiftNorm p := by
  have hsqrt : Real.sqrt ((D : ℝ) / 2) ≤ (D : ℝ) / 2 + 1 := by
    have h1 : ((D : ℝ) / 2 + 1) = Real.sqrt (((D : ℝ) / 2 + 1) ^ 2) :=
      (Real.sqrt_sq (by positivity)).symm
    rw [h1]
    exact Real.sqrt_le_sqrt (by nlinarith [Nat.cast_nonneg (α := ℝ) D])
  refine le_trans (mul_le_mul_of_nonneg_right hsqrt (norm_nonneg _)) ?_
  exact dim_mul_norm_le_shiftNorm p

theorem norm_harmPoly_mul_le_shiftNorm (p : MvPolynomial (Fin D) ℂ) :
    ‖pgLp (harmPoly * p)‖ ≤ 2 * shiftNorm p := by
  have h := norm_harmPoly_mul_le p
  have h1 : ‖pgLp (kinPoly p + harmPoly * p)‖ ≤ shiftNorm p := norm_harmP_le_shiftNorm p
  have h2 := sqrt_dim_mul_norm_le_shiftNorm p
  linarith

theorem norm_kinPoly_le_shiftNorm (p : MvPolynomial (Fin D) ℂ) :
    ‖pgLp (kinPoly p)‖ ≤ 3 * shiftNorm p := by
  have hadd : pgLp (kinPoly p + harmPoly * p) = pgLp (kinPoly p) + pgLp (harmPoly * p) := by
    rw [← pgMap_apply, ← pgMap_apply, ← pgMap_apply, map_add]
  have heq : pgLp (kinPoly p) = pgLp (harmP p) - pgLp (harmPoly * p) := by
    rw [harmP, hadd]
    abel
  have h1 : ‖pgLp (harmP p)‖ ≤ shiftNorm p := norm_harmP_le_shiftNorm p
  have h2 : ‖pgLp (harmPoly * p)‖ ≤ 2 * shiftNorm p := norm_harmPoly_mul_le_shiftNorm p
  calc ‖pgLp (kinPoly p)‖ = ‖pgLp (harmP p) - pgLp (harmPoly * p)‖ := by rw [heq]
    _ ≤ ‖pgLp (harmP p)‖ + ‖pgLp (harmPoly * p)‖ := norm_sub_le _ _
    _ ≤ 3 * shiftNorm p := by linarith

/-! ## 4. The weighted Laplacian is dominated by the Laplacian -/

/-- The Gaussian integral of `|q|²` is the squared norm. -/
theorem gaussInt_self (q : MvPolynomial (Fin D) ℂ) :
    gaussInt (cpoly q * q) = ((‖pgLp q‖ ^ 2 : ℝ) : ℂ) := by
  rw [← inner_pgLp_pgLp q q, inner_self_eq_norm_sq_to_K (𝕜 := ℂ) (pgLp q)]
  norm_cast

theorem cpoly_real_smul (c : ℝ) (q : MvPolynomial (Fin D) ℂ) :
    cpoly (((c : ℝ) : ℂ) • q) = ((c : ℝ) : ℂ) • cpoly q := by
  rw [MvPolynomial.smul_eq_C_mul, MvPolynomial.smul_eq_C_mul, cpoly_mul, cpoly_C,
    Complex.conj_ofReal]

/-- The mixed second-derivative pairing: moving both twisted derivatives across gives the
squared norm of the mixed second derivative, in particular a nonnegative real number. -/
theorem gaussInt_coreD_sq_pair (j k : Fin D) (p : MvPolynomial (Fin D) ℂ) :
    gaussInt (cpoly (coreD j (coreD j p)) * coreD k (coreD k p))
      = ((‖pgLp (coreD k (coreD j p))‖ ^ 2 : ℝ) : ℂ) := by
  have hcomm : coreD j (coreD k (coreD k p)) = coreD k (coreD k (coreD j p)) := by
    rw [coreD_comm j k (coreD k p), coreD_comm j k p]
  have h1 : gaussInt (cpoly (coreD j (coreD j p)) * coreD k (coreD k p))
      = -gaussInt (cpoly (coreD j p) * coreD j (coreD k (coreD k p))) :=
    gaussInt_coreD j (coreD j p) (coreD k (coreD k p))
  have h2 : gaussInt (cpoly (coreD k (coreD j p)) * coreD k (coreD j p))
      = -gaussInt (cpoly (coreD j p) * coreD k (coreD k (coreD j p))) :=
    gaussInt_coreD k (coreD j p) (coreD k (coreD j p))
  rw [h1, hcomm, ← h2, gaussInt_self]

/-- The squared norm of a weighted sum of second derivatives, as a double sum. -/
theorem norm_weighted_kin_sq (c : Fin D → ℝ) (p : MvPolynomial (Fin D) ℂ) :
    ‖pgLp (∑ j : Fin D, ((c j : ℝ) : ℂ) • coreD j (coreD j p))‖ ^ 2
      = ∑ j : Fin D, ∑ k : Fin D, c j * c k * ‖pgLp (coreD k (coreD j p))‖ ^ 2 := by
  have hexp : cpoly (∑ j : Fin D, ((c j : ℝ) : ℂ) • coreD j (coreD j p))
        * (∑ k : Fin D, ((c k : ℝ) : ℂ) • coreD k (coreD k p))
      = ∑ j : Fin D, ∑ k : Fin D, (((c j * c k : ℝ) : ℂ))
          • (cpoly (coreD j (coreD j p)) * coreD k (coreD k p)) := by
    rw [cpoly_sum, Finset.sum_mul]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [cpoly_real_smul, Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    simp only [MvPolynomial.smul_eq_C_mul, Complex.ofReal_mul, map_mul]
    ring
  rw [norm_pgLp_sq, hexp, gaussInt_sum]
  rw [Complex.re_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [gaussInt_sum, Complex.re_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [gaussInt_smul, gaussInt_coreD_sq_pair, ← Complex.ofReal_mul, Complex.ofReal_re]

/-- **The signed kinetic term is dominated by the unsigned one**: because
`⟪∂ⱼ²p, ∂ₖ²p⟫ = ‖∂ⱼ∂ₖ p‖² ≥ 0`, the weights can be pulled out in absolute value. -/
theorem norm_weighted_kin_le {kappa : Fin D → ℝ} {km : ℝ} (hkm : 0 ≤ km)
    (hk : ∀ j, |kappa j| ≤ km) (p : MvPolynomial (Fin D) ℂ) :
    ‖pgLp (∑ j : Fin D, ((kappa j : ℝ) : ℂ) • coreD j (coreD j p))‖
      ≤ km * ‖pgLp (kinPoly p)‖ := by
  have hkin : ‖pgLp (kinPoly p)‖ ^ 2
      = ∑ j : Fin D, ∑ k : Fin D, ‖pgLp (coreD k (coreD j p))‖ ^ 2 := by
    have h := norm_weighted_kin_sq (fun _ => (1 : ℝ)) p
    have hsum : (∑ j : Fin D, (((1 : ℝ) : ℂ)) • coreD j (coreD j p)) = -kinPoly p := by
      rw [kinPoly, neg_neg]
      exact Finset.sum_congr rfl fun j _ => by simp
    rw [hsum] at h
    have hneg : pgLp (-kinPoly p) = -pgLp (kinPoly p) := by
      rw [← pgMap_apply, ← pgMap_apply, map_neg]
    rw [hneg, norm_neg] at h
    simpa using h
  have hbound : ‖pgLp (∑ j : Fin D, ((kappa j : ℝ) : ℂ) • coreD j (coreD j p))‖ ^ 2
      ≤ (km * ‖pgLp (kinPoly p)‖) ^ 2 := by
    rw [norm_weighted_kin_sq, mul_pow, hkin, Finset.mul_sum]
    refine Finset.sum_le_sum fun j _ => ?_
    rw [Finset.mul_sum]
    refine Finset.sum_le_sum fun k _ => ?_
    have hjk : kappa j * kappa k ≤ km ^ 2 := by
      have h1 := abs_le.mp (hk j)
      have h2 := abs_le.mp (hk k)
      nlinarith
    exact mul_le_mul_of_nonneg_right hjk (sq_nonneg _)
  have hrhs : 0 ≤ km * ‖pgLp (kinPoly p)‖ := mul_nonneg hkm (norm_nonneg _)
  nlinarith [norm_nonneg (pgLp (∑ j : Fin D, ((kappa j : ℝ) : ℂ) • coreD j (coreD j p)))]

/-! ## 5. Multiplication operators dominated pointwise -/

/-- Pointwise, `cpoly q * q` evaluates to the squared modulus of `q`. -/
theorem eval_cpoly_self_re (q : MvPolynomial (Fin D) ℂ) (x : Vd D) :
    (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (cpoly q * q)).re
      = ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q‖ ^ 2 := by
  rw [map_mul, ← conj_polyEval]
  set z := MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q with hz
  rw [Complex.mul_re]
  simp [Complex.norm_eq_sqrt_sq_add_sq]
  nlinarith [Real.sq_sqrt (show (0:ℝ) ≤ z.re ^ 2 + z.im ^ 2 by positivity)]

/-- A real polynomial dominated pointwise by another gives a dominated multiplication
operator. -/
theorem norm_mul_le_of_pointwise {f g : MvPolynomial (Fin D) ℂ} {lam : ℝ} (hlam : 0 ≤ lam)
    (h : ∀ x : Vd D, ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) f‖
      ≤ lam * ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) g‖)
    (p : MvPolynomial (Fin D) ℂ) :
    ‖pgLp (f * p)‖ ≤ lam * ‖pgLp (g * p)‖ := by
  have hsq : ‖pgLp (f * p)‖ ^ 2 ≤ (lam * ‖pgLp (g * p)‖) ^ 2 := by
    have hmono : (gaussInt (cpoly (f * p) * (f * p))).re
        ≤ (gaussInt ((((lam ^ 2 : ℝ)) : ℂ) • (cpoly (g * p) * (g * p)))).re := by
      refine gaussInt_re_mono fun x => ?_
      have hval : (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ))
            (MvPolynomial.C (((lam ^ 2 : ℝ) : ℂ)) * (cpoly (g * p) * (g * p)))).re
          = lam ^ 2 * ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (g * p)‖ ^ 2 := by
        rw [MvPolynomial.eval_mul, MvPolynomial.eval_C, Complex.re_ofReal_mul,
          eval_cpoly_self_re]
      rw [eval_cpoly_self_re, MvPolynomial.smul_eq_C_mul, hval]
      have hf := h x
      have hp : (0 : ℝ) ≤ ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖ := norm_nonneg _
      have hg : (0 : ℝ) ≤ ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) g‖ := norm_nonneg _
      have hff : (0 : ℝ) ≤ ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) f‖ := norm_nonneg _
      rw [map_mul, map_mul, norm_mul, norm_mul, mul_pow, mul_pow]
      have : ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) f‖ ^ 2
          ≤ lam ^ 2 * ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) g‖ ^ 2 := by
        nlinarith
      nlinarith [sq_nonneg (‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖)]
    rw [gaussInt_smul, Complex.re_ofReal_mul] at hmono
    rw [norm_pgLp_sq, mul_pow, norm_pgLp_sq]
    exact hmono
  have hrhs : 0 ≤ lam * ‖pgLp (g * p)‖ := mul_nonneg hlam (norm_nonneg _)
  nlinarith [norm_nonneg (pgLp (f * p))]

/-- A family of real polynomials dominated pointwise *in the sum of squares* gives a
dominated family of multiplication operators, in the sum of squares. -/
theorem sum_norm_sq_mul_le_of_pointwise {R : Type*} [Fintype R]
    {f : R → MvPolynomial (Fin D) ℂ} {g : R → MvPolynomial (Fin D) ℂ} {lam : ℝ}
    (h : ∀ x : Vd D, ∑ r : R, ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (f r)‖ ^ 2
      ≤ lam * ∑ r : R, ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (g r)‖ ^ 2)
    (p : MvPolynomial (Fin D) ℂ) :
    ∑ r : R, ‖pgLp (f r * p)‖ ^ 2 ≤ lam * ∑ r : R, ‖pgLp (g r * p)‖ ^ 2 := by
  have hL : ∑ r : R, ‖pgLp (f r * p)‖ ^ 2
      = (gaussInt (∑ r : R, cpoly (f r * p) * (f r * p))).re := by
    rw [gaussInt_sum, Complex.re_sum]
    exact Finset.sum_congr rfl fun r _ => norm_pgLp_sq _
  have hR : lam * ∑ r : R, ‖pgLp (g r * p)‖ ^ 2
      = (gaussInt (((lam : ℝ) : ℂ) • ∑ r : R, cpoly (g r * p) * (g r * p))).re := by
    rw [gaussInt_smul, Complex.re_ofReal_mul, gaussInt_sum, Complex.re_sum]
    congr 1
    exact Finset.sum_congr rfl fun r _ => norm_pgLp_sq _
  rw [hL, hR]
  refine gaussInt_re_mono fun x => ?_
  rw [MvPolynomial.smul_eq_C_mul, map_mul, MvPolynomial.eval_C, Complex.re_ofReal_mul,
    map_sum, map_sum, Complex.re_sum, Complex.re_sum]
  have hcongr : ∀ (u : R → MvPolynomial (Fin D) ℂ),
      ∑ r : R, (MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (cpoly (u r * p) * (u r * p))).re
        = (∑ r : R, ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (u r)‖ ^ 2)
            * ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖ ^ 2 := by
    intro u
    rw [Finset.sum_mul]
    refine Finset.sum_congr rfl fun r _ => ?_
    rw [eval_cpoly_self_re, map_mul, norm_mul, mul_pow]
  rw [hcongr f, hcongr g]
  have hx := h x
  nlinarith [hx, sq_nonneg (‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖)]

end

end BookProof.GaussCoreQuadBounds
