import Mathlib
import BookProof.ChapterQgHermiteOscillatorEsa

/-!
# Unbounded quadratic-type perturbations on the Gauss–polynomial (Hermite) core

`CONSOLIDATED_PLAN.md` §10.6.1 target 4 asks for essential self-adjointness of the *sum*
`−Δ + V` on the Gauss–polynomial core of `L²(ℝᵈ)`.  What was available so far is
`BookProof.ChapterQgHermiteOscillatorEsa`: the harmonic (conformal-mode) Hamiltonian
`−Δ + ‖x‖²/4` is essentially self-adjoint on that core, and — by Kato–Rellich with relative
bound `0` — so is `−Δ + ‖x‖²/4 + B` for a *bounded* continuous `B`.  On the other side,
`BookProof.ChapterHermiteExpWall` shows that the exponentially growing scalaron wall is
**not** relatively bounded on this core at all, so no Kato–Rellich argument can reach it.

This module fills the gap in between: **unbounded** perturbations of quadratic type.

## The analytic input

The one quantitative fact needed is the relative bound of the harmonic potential itself with
respect to the harmonic Hamiltonian, with constant `1`:

`‖(‖x‖²/4)ψ‖² ≤ ‖(−Δ + ‖x‖²/4)ψ‖² + (d/2)‖ψ‖²`   (`norm_sq_harmPoly_mul_le`).

It comes from the anticommutator identity (`gaussInt_anticommutator`), which on the
Gauss–polynomial core is a purely algebraic computation with the twisted derivative
`coreD j = ∂ⱼ − xⱼ/2` and Gaussian integration by parts:

`⟪−Δψ, Wψ⟫ + ⟪Wψ, −Δψ⟫ = 2 ∑ⱼ ⟪∂ⱼψ, W ∂ⱼψ⟫ − (d/2)‖ψ‖²`,  `W = ‖x‖²/4`,

whose right-hand side is `≥ −(d/2)‖ψ‖²` because `W ≥ 0`.  (Classically this is
`{−Δ, W} = −ΔW + 2∑ⱼ(−∂ⱼ)W∂ⱼ` with `ΔW = d/2`.)

## What is proved

* `gaussInt_anticommutator`, `two_re_inner_kin_harm_ge`, `norm_sq_harmPoly_mul_le`,
  `norm_harmPoly_mul_le` — the relative bound of `‖x‖²/4` with respect to `−Δ + ‖x‖²/4`,
  with relative constant `1` and additive constant `√(d/2)`;
* `norm_potLp_le_of_le_harm` — the `L²` bound `‖Vψ‖ ≤ a‖Wψ‖ + b‖ψ‖` for a potential
  dominated pointwise by `a·‖x‖²/4 + b`;
* **`harmonic_add_subquadratic_essentiallySelfAdjoint`** — the headline: if `V` is
  continuous with `|V(x)| ≤ a‖x‖²/4 + b` and `a < 1`, then `−Δ + ‖x‖²/4 + V` is essentially
  self-adjoint on the Gauss–polynomial core.  The perturbation may be unbounded;
* `harmonic_add_subquadratic_stone_flow` — the self-adjoint realization and its unitary
  group, read off from essential self-adjointness;
* `quadraticGrowth_essentiallySelfAdjoint` — the criterion in growth form: a continuous
  potential `U` with `|U(x) − ‖x‖²/4| ≤ A‖x‖² + C‖x‖ + B` and `4A < 1`;
* `scaledHarmonic_essentiallySelfAdjoint` — `−Δ + λ‖x‖²/4` is essentially self-adjoint on the
  (fixed, width-one) Gauss core for every `λ ∈ (0, 2)`;
* **`confV_essentiallySelfAdjoint`** — the conformal-mode instance of §10.6.1 target 4: the
  regularized `R + αR²` conformal-mode Hamiltonian `−Δ + V₃`,
  `V₃(R_c) = −(M²/2)R_c + αR_c²`, is essentially self-adjoint on the Gauss core of `L²(ℝ)`
  for `0 < α < 1/2`, unconditionally (no finite-speed hypothesis), together with its Stone
  flow `confV_stone_flow`;
* **`sectorQuad_essentiallySelfAdjoint`** — the two-variable reduced `(R_c, φ)` sector with
  the scalaron wall replaced by a quadratic term, `V₃(R_c) + μφ²` on `L²(ℝ²)`, for
  `0 < α < 1/2` and `0 < μ < 1/2`, with `sectorQuad_stone_flow`;
  `tendsto_starobinskyV_div_sq` computes the curvature of the scalaron potential at its
  minimum, `V(φ)/φ² → M²/(24α)`, and `sectorHarmonicApprox_essentiallySelfAdjoint` is the
  sector statement at that physically natural value of `μ`, valid when `M² < 12α`.

**Honest boundary.**  The relative bound of `‖x‖²/4` against `−Δ + ‖x‖²/4` is exactly `1`, so
the Kato–Rellich window `a < 1` is the natural limit of this method: it reaches quadratic
potentials whose curvature is within a factor `2` of the width of the Gauss core (this is why
`confV_essentiallySelfAdjoint` carries `α < 1/2`; a different `α` is the same operator on a
Gauss core of a different width, which this module does not build), and every strictly
subquadratic perturbation of them.  It does not reach the exponential scalaron wall — nothing
can, on this core, by `BookProof.ChapterHermiteExpWall`.
-/

namespace BookProof.HermiteQuadraticEsa

open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

/-! ## 1. Algebraic preliminaries on the core -/

/-- The gradient of the harmonic potential: `∂ⱼ(‖x‖²/4) = xⱼ/2`. -/
theorem pderiv_harmPoly (j : Fin d) :
    pderiv j (harmPoly (d := d)) = C (1 / 2 : ℂ) * X j := by
  have hC : (C (1 / 4 : ℂ) : MvPolynomial (Fin d) ℂ) * 2 = C (1 / 2 : ℂ) := by
    have h2 : ((2 : MvPolynomial (Fin d) ℂ)) = C (2 : ℂ) :=
      (MvPolynomial.ext _ _ (congrFun rfl)).symm
    rw [h2, ← C_mul]
    norm_num
  unfold harmPoly
  rw [map_sum, Finset.sum_eq_single j]
  · rw [pderiv_C_mul, pow_two, pderiv_mul, pderiv_X_self]
    linear_combination (X j : MvPolynomial (Fin d) ℂ) * hC
  · intro k _ hk
    rw [pderiv_C_mul, pow_two, pderiv_mul, pderiv_X_of_ne hk]
    ring
  · intro h
    exact absurd (Finset.mem_univ j) h

/-- **Leibniz for the twisted derivative against the harmonic potential.** -/
theorem coreD_harmPoly_mul (j : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    coreD j (harmPoly * p) = C (1 / 2 : ℂ) * (X j * p) + harmPoly * coreD j p := by
  unfold coreD
  rw [pderiv_mul, pderiv_harmPoly]
  ring

/-- The twisted derivative against a coordinate. -/
theorem coreD_X_mul (j : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    coreD j (X j * p) = p + X j * coreD j p := by
  unfold coreD
  rw [pderiv_mul, pderiv_X_self]
  ring

/-- Conjugation of coefficients is additive. -/
theorem cpoly_add (p q : MvPolynomial (Fin d) ℂ) : cpoly (p + q) = cpoly p + cpoly q := by
  simp [cpoly]

/-- The harmonic polynomial has real coefficients. -/
theorem cpoly_harmPoly : cpoly (harmPoly (d := d)) = harmPoly := by
  have hq : (starRingEnd ℂ) (1 / 4 : ℂ) = 1 / 4 := by norm_num [Complex.ext_iff]
  unfold harmPoly
  rw [cpoly_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [pow_two, cpoly_mul, cpoly_mul, cpoly_C, cpoly_X, hq]

/-- The cross term of the anticommutator: Gaussian integration by parts against `xⱼ`. -/
theorem gaussInt_cross (j : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    gaussInt (cpoly (coreD j p) * (X j * p)) + gaussInt (cpoly p * (X j * coreD j p))
      = -gaussInt (cpoly p * p) := by
  rw [gaussInt_coreD j p (X j * p), coreD_X_mul, mul_add, gaussInt_add]
  ring

/-- The Gaussian pairing of a polynomial with itself is the squared `L²` norm of the core
vector it names. -/
theorem gaussInt_self (r : MvPolynomial (Fin d) ℂ) :
    gaussInt (cpoly r * r) = ((‖pgLp r‖ ^ 2 : ℝ) : ℂ) := by
  rw [← inner_pgLp_pgLp, inner_self_eq_norm_sq_to_K (𝕜 := ℂ)]
  norm_cast

/-- The harmonic quadratic form on the core is a sum of squared norms — in particular it is
a nonnegative real. -/
theorem gaussInt_harm_self (q : MvPolynomial (Fin d) ℂ) :
    gaussInt (cpoly q * (harmPoly * q))
      = (((∑ k : Fin d, ‖pgLp (X k * q)‖ ^ 2) / 4 : ℝ) : ℂ) := by
  have hsum : cpoly q * (harmPoly * q)
      = ∑ k : Fin d, (1 / 4 : ℂ) • (cpoly (X k * q) * (X k * q)) := by
    unfold harmPoly
    rw [Finset.sum_mul, Finset.mul_sum]
    refine Finset.sum_congr rfl fun k _ => ?_
    rw [cpoly_mul, cpoly_X, smul_eq_C_mul]
    ring
  have hterm : ∀ k : Fin d, gaussInt ((1 / 4 : ℂ) • (cpoly (X k * q) * (X k * q)))
      = ((‖pgLp (X k * q)‖ ^ 2 / 4 : ℝ) : ℂ) := by
    intro k
    rw [gaussInt_smul, gaussInt_self]
    push_cast
    ring
  rw [hsum, gaussInt_sum]
  simp only [hterm]
  rw [← Complex.ofReal_sum, Finset.sum_div]

/-- **The anticommutator identity** `{−Δ, W} = −(d/2) + 2∑ⱼ(−∂ⱼ)W∂ⱼ`, in the Gaussian
pairing of the core. -/
theorem gaussInt_anticommutator (p : MvPolynomial (Fin d) ℂ) :
    gaussInt (cpoly (kinPoly p) * (harmPoly * p))
        + gaussInt (cpoly (harmPoly * p) * kinPoly p)
      = 2 * (∑ j : Fin d, gaussInt (cpoly (coreD j p) * (harmPoly * coreD j p)))
        - ((d : ℂ) / 2) * gaussInt (cpoly p * p) := by
  have hhalf : (starRingEnd ℂ) (1 / 2 : ℂ) = 1 / 2 := by norm_num [Complex.ext_iff]
  have hT1 : ∀ j : Fin d, gaussInt (cpoly (coreD j p) * coreD j (harmPoly * p))
      = (1 / 2 : ℂ) * gaussInt (cpoly (coreD j p) * (X j * p))
        + gaussInt (cpoly (coreD j p) * (harmPoly * coreD j p)) := by
    intro j
    rw [coreD_harmPoly_mul, mul_add, gaussInt_add]
    congr 1
    have hsm : cpoly (coreD j p) * (C (1 / 2 : ℂ) * (X j * p))
        = (1 / 2 : ℂ) • (cpoly (coreD j p) * (X j * p)) := by
      rw [smul_eq_C_mul]; ring
    rw [hsm, gaussInt_smul]
  have hT2 : ∀ j : Fin d, gaussInt (cpoly (coreD j (harmPoly * p)) * coreD j p)
      = (1 / 2 : ℂ) * gaussInt (cpoly p * (X j * coreD j p))
        + gaussInt (cpoly (coreD j p) * (harmPoly * coreD j p)) := by
    intro j
    rw [coreD_harmPoly_mul, cpoly_add]
    simp only [cpoly_mul, cpoly_C, cpoly_X, cpoly_harmPoly, hhalf]
    rw [add_mul, gaussInt_add]
    congr 1
    · have hsm : C (1 / 2 : ℂ) * (X j * cpoly p) * coreD j p
          = (1 / 2 : ℂ) • (cpoly p * (X j * coreD j p)) := by
        rw [smul_eq_C_mul]; ring
      rw [hsm, gaussInt_smul]
    · congr 1
      ring
  rw [gaussInt_kinPoly_left p (harmPoly * p), gaussInt_kinPoly (harmPoly * p) p]
  simp only [hT1, hT2]
  rw [← Finset.sum_add_distrib]
  have hstep : ∀ j : Fin d,
      ((1 / 2 : ℂ) * gaussInt (cpoly (coreD j p) * (X j * p))
          + gaussInt (cpoly (coreD j p) * (harmPoly * coreD j p)))
        + ((1 / 2 : ℂ) * gaussInt (cpoly p * (X j * coreD j p))
          + gaussInt (cpoly (coreD j p) * (harmPoly * coreD j p)))
      = 2 * gaussInt (cpoly (coreD j p) * (harmPoly * coreD j p))
        - (1 / 2 : ℂ) * gaussInt (cpoly p * p) := by
    intro j
    have h := gaussInt_cross j p
    linear_combination (1 / 2 : ℂ) * h
  simp only [hstep]
  rw [Finset.sum_sub_distrib, ← Finset.mul_sum, Finset.sum_const, Finset.card_univ,
    Fintype.card_fin, nsmul_eq_mul]
  ring

/-! ## 2. The relative bound of the harmonic potential -/

/-- The cross term in `‖(−Δ + W)ψ‖²` is bounded below by `−(d/2)‖ψ‖²`. -/
theorem two_re_inner_kin_harm_ge (p : MvPolynomial (Fin d) ℂ) :
    -((d : ℝ) / 2) * ‖pgLp p‖ ^ 2
      ≤ 2 * (inner ℂ (pgLp (kinPoly p)) (pgLp (harmPoly * p)) : ℂ).re := by
  set A : ℂ := (inner ℂ (pgLp (kinPoly p)) (pgLp (harmPoly * p)) : ℂ) with hAdef
  set R : ℝ := ∑ j : Fin d, (∑ k : Fin d, ‖pgLp (X k * coreD j p)‖ ^ 2) / 4 with hRdef
  have hR : 0 ≤ R := by
    rw [hRdef]; positivity
  have hA : A = gaussInt (cpoly (kinPoly p) * (harmPoly * p)) := inner_pgLp_pgLp _ _
  have hB : (inner ℂ (pgLp (harmPoly * p)) (pgLp (kinPoly p)) : ℂ)
      = gaussInt (cpoly (harmPoly * p) * kinPoly p) := inner_pgLp_pgLp _ _
  have hconj : gaussInt (cpoly (harmPoly * p) * kinPoly p) = (starRingEnd ℂ) A := by
    rw [← hB, hAdef, inner_conj_symm]
  have key := gaussInt_anticommutator p
  rw [← hA, hconj, Complex.add_conj, gaussInt_self] at key
  simp only [gaussInt_harm_self] at key
  have hcast :
      (2 : ℂ) * (∑ j : Fin d, (((∑ k : Fin d, ‖pgLp (X k * coreD j p)‖ ^ 2) / 4 : ℝ) : ℂ))
        - ((d : ℂ) / 2) * ((‖pgLp p‖ ^ 2 : ℝ) : ℂ)
      = (((2 * R - (d : ℝ) / 2 * ‖pgLp p‖ ^ 2 : ℝ)) : ℂ) := by
    rw [hRdef]
    push_cast
    ring
  rw [hcast] at key
  have hreal : 2 * A.re = 2 * R - (d : ℝ) / 2 * ‖pgLp p‖ ^ 2 := by exact_mod_cast key
  linarith

/-- **The harmonic potential is relatively bounded by the harmonic Hamiltonian with relative
constant `1`.** -/
theorem norm_sq_harmPoly_mul_le (p : MvPolynomial (Fin d) ℂ) :
    ‖pgLp (harmPoly * p)‖ ^ 2
      ≤ ‖pgLp (kinPoly p + harmPoly * p)‖ ^ 2 + ((d : ℝ) / 2) * ‖pgLp p‖ ^ 2 := by
  have hadd : pgLp (kinPoly p + harmPoly * p) = pgLp (kinPoly p) + pgLp (harmPoly * p) := by
    rw [← pgMap_apply, ← pgMap_apply, ← pgMap_apply, map_add]
  have hre : RCLike.re (inner ℂ (pgLp (kinPoly p)) (pgLp (harmPoly * p)) : ℂ)
      = (inner ℂ (pgLp (kinPoly p)) (pgLp (harmPoly * p)) : ℂ).re := rfl
  rw [hadd, norm_add_sq (𝕜 := ℂ), hre]
  have h := two_re_inner_kin_harm_ge p
  nlinarith [sq_nonneg ‖pgLp (kinPoly p)‖]

/-- The same bound in the form Kato–Rellich uses. -/
theorem norm_harmPoly_mul_le (p : MvPolynomial (Fin d) ℂ) :
    ‖pgLp (harmPoly * p)‖
      ≤ ‖pgLp (kinPoly p + harmPoly * p)‖ + Real.sqrt ((d : ℝ) / 2) * ‖pgLp p‖ := by
  have hs : Real.sqrt ((d : ℝ) / 2) ^ 2 = (d : ℝ) / 2 :=
    Real.sq_sqrt (by positivity)
  have hs0 : 0 ≤ Real.sqrt ((d : ℝ) / 2) := Real.sqrt_nonneg _
  have h := norm_sq_harmPoly_mul_le p
  nlinarith [norm_nonneg (pgLp (harmPoly * p)), norm_nonneg (pgLp (kinPoly p + harmPoly * p)),
    norm_nonneg (pgLp p), mul_nonneg hs0 (norm_nonneg (pgLp p))]

/-! ## 3. Potentials dominated by the harmonic one -/

/-- A potential dominated by `a‖x‖²/4 + b` is exponentially bounded. -/
theorem expBounded_of_le_harm {V : Vd d → ℝ} {a b : ℝ} (ha : 0 ≤ a) (hb : 0 ≤ b)
    (hV : ∀ x, |V x| ≤ a * harmW x + b) : ExpBounded V := by
  refine ⟨a / 2 + b, 1, zero_le_one, fun x => ?_⟩
  have h := Real.pow_div_factorial_le_exp ‖x‖ (norm_nonneg x) 2
  have hfac : ((Nat.factorial 2 : ℕ) : ℝ) = 2 := by norm_num
  rw [hfac] at h
  have h1 : (1 : ℝ) ≤ Real.exp ‖x‖ := Real.one_le_exp (norm_nonneg x)
  have hharm : harmW x = ‖x‖ ^ 2 / 4 := rfl
  have hVx := hV x
  rw [hharm] at hVx
  rw [one_mul]
  nlinarith

/-- The `L²` bound for a potential dominated by `a‖x‖²/4 + b`. -/
theorem norm_potLp_le_of_le_harm {V : Vd d → ℝ} (hVc : Continuous V) (hVb : ExpBounded V)
    {a b : ℝ} (ha : 0 ≤ a) (hb : 0 ≤ b) (hV : ∀ x, |V x| ≤ a * harmW x + b)
    (p : MvPolynomial (Fin d) ℂ) :
    ‖potLp V hVc hVb p‖ ≤ a * ‖pgLp (harmPoly * p)‖ + b * ‖pgLp p‖ := by
  have hstep : ‖potLp V hVc hVb p‖
      ≤ ‖((a : ℝ) : ℂ) • pgLp (harmPoly * p) + ((b : ℝ) : ℂ) • pgLp p‖ := by
    refine Lp.norm_le_norm_of_ae_le ?_
    filter_upwards [potLp_coeFn V hVc hVb p,
      Lp.coeFn_add (((a : ℝ) : ℂ) • pgLp (harmPoly * p)) (((b : ℝ) : ℂ) • pgLp p),
      Lp.coeFn_smul ((a : ℝ) : ℂ) (pgLp (harmPoly * p)),
      Lp.coeFn_smul ((b : ℝ) : ℂ) (pgLp p),
      pgLp_coeFn (harmPoly * p), pgLp_coeFn p] with x h1 h2 h3 h4 h5 h6
    have hfun : pgFun (harmPoly * p) x = ((harmW x : ℝ) : ℂ) * pgFun p x := by
      simp only [pgFun, map_mul, eval_harmPoly]
      ring
    rw [h1, h2, Pi.add_apply, h3, h4, Pi.smul_apply, Pi.smul_apply, h5, h6, hfun,
      smul_eq_mul, smul_eq_mul]
    have hrw : ((a : ℝ) : ℂ) * (((harmW x : ℝ) : ℂ) * pgFun p x) + ((b : ℝ) : ℂ) * pgFun p x
        = ((a * harmW x + b : ℝ) : ℂ) * pgFun p x := by
      push_cast
      ring
    rw [hrw, norm_mul, norm_mul, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs,
      Real.norm_eq_abs]
    refine mul_le_mul_of_nonneg_right ?_ (norm_nonneg _)
    have hpos : 0 ≤ a * harmW x + b := by
      have : 0 ≤ harmW x := by unfold harmW; positivity
      positivity
    rw [abs_of_nonneg hpos]
    exact hV x
  refine hstep.trans ((norm_add_le _ _).trans ?_)
  rw [norm_smul, norm_smul, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs,
    Real.norm_eq_abs, abs_of_nonneg ha, abs_of_nonneg hb]

/-! ## 4. The essential self-adjointness theorem -/

/-- **Essential self-adjointness of `−Δ + ‖x‖²/4 + V` for an unbounded, quadratically
dominated perturbation.**  If `V` is continuous and `|V(x)| ≤ a‖x‖²/4 + b` with `a < 1`, the
Gauss–polynomial (Hermite) core is a core for `−Δ + ‖x‖²/4 + V`. -/
theorem harmonic_add_subquadratic_essentiallySelfAdjoint {V : Vd d → ℝ} {a b : ℝ}
    (hVc : Continuous V) (ha : 0 ≤ a) (ha1 : a < 1) (hb : 0 ≤ b)
    (hV : ∀ x, |V x| ≤ a * harmW x + b)
    (hsc : Continuous fun x => harmW x + V x) (hsb : ExpBounded fun x => harmW x + V x) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (hamCore (fun x => harmW x + V x) hsc hsb) := by
  have hVb : ExpBounded V := expBounded_of_le_harm ha hb hV
  have hs0 : (0 : ℝ) ≤ Real.sqrt ((d : ℝ) / 2) := Real.sqrt_nonneg _
  rw [hamCore_add_potential harmW V continuous_harmW expBounded_harmW hVc hVb hsc hsb]
  refine BookProof.KatoRellich.essentiallySelfAdjointOn_add_relBounded
    (a := a) (b := a * Real.sqrt ((d : ℝ) / 2) + b) _ _
    harmonicCore_symmetricOn harmonicCore_essentiallySelfAdjoint
    (potCore_symmetricOn V hVc hVb) ha ha1 (by positivity) fun x => ?_
  obtain ⟨p, hp⟩ := x.2
  have hx : x = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext hp.symm
  rw [hx, potCore_pgLp]
  have hham : (hamCore harmW continuous_harmW expBounded_harmW) ⟨pgLp p, pgLp_mem_core p⟩
      = pgLp (kinPoly p + harmPoly * p) := harmCore_pgLp p
  rw [hham]
  have h1 := norm_potLp_le_of_le_harm hVc hVb ha hb hV p
  have h2 := norm_harmPoly_mul_le p
  have hcoe : ‖((⟨pgLp p, pgLp_mem_core p⟩ : polyGaussCore (d := d)) : L2d d)‖ = ‖pgLp p‖ := rfl
  rw [hcoe]
  nlinarith [norm_nonneg (pgLp p), norm_nonneg (pgLp (kinPoly p + harmPoly * p))]

/-- The Stone flow of `−Δ + ‖x‖²/4 + V`: essential self-adjointness on the dense core produces
a self-adjoint realization together with the unitary group it generates. -/
theorem harmonic_add_subquadratic_stone_flow {V : Vd d → ℝ} {a b : ℝ}
    (hVc : Continuous V) (ha : 0 ≤ a) (ha1 : a < 1) (hb : 0 ≤ b)
    (hV : ∀ x, |V x| ≤ a * harmW x + b)
    (hsc : Continuous fun x => harmW x + V x) (hsb : ExpBounded fun x => harmW x + V x) :
    ∃ (T : UnboundedSelfAdjoint (L2d d)) (U : ℝ → (L2d d →L[ℂ] L2d d)),
      IsSelfAdjointExtension (hamCore (fun x => harmW x + V x) hsc hsb) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense (hamCore_symmetricOn _ hsc hsb)
    (harmonic_add_subquadratic_essentiallySelfAdjoint hVc ha ha1 hb hV hsc hsb)

/-! ## 5. The criterion in growth form, and instances -/

/-- Equal potentials give the same Hamiltonian on the core (the continuity and growth proofs
are irrelevant). -/
theorem hamCore_congr {U U' : Vd d → ℝ} (h : U = U') (hUc : Continuous U) (hUb : ExpBounded U)
    (hU'c : Continuous U') (hU'b : ExpBounded U') :
    hamCore U hUc hUb = hamCore U' hU'c hU'b := by
  subst h; rfl

/-- **The criterion for a potential close to the harmonic one**: if `U` is continuous and
`|U(x) − ‖x‖²/4| ≤ a‖x‖²/4 + b` with `a < 1`, then `−Δ + U` is essentially self-adjoint on the
Gauss–polynomial core. -/
theorem esa_of_close_to_harmonic {U : Vd d → ℝ} (hUc : Continuous U) (hUb : ExpBounded U)
    {a b : ℝ} (ha : 0 ≤ a) (ha1 : a < 1) (hb : 0 ≤ b)
    (hU : ∀ x, |U x - harmW x| ≤ a * harmW x + b) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (hamCore U hUc hUb) := by
  have hfun : (fun x => harmW x + (U x - harmW x)) = U := by
    funext x; ring
  have hsc : Continuous fun x => harmW x + (U x - harmW x) := by
    rw [hfun]; exact hUc
  have hsb : ExpBounded fun x => harmW x + (U x - harmW x) := by
    rw [hfun]; exact hUb
  have h := harmonic_add_subquadratic_essentiallySelfAdjoint (V := fun x => U x - harmW x)
    (hUc.sub continuous_harmW) ha ha1 hb hU hsc hsb
  rwa [hamCore_congr hfun hsc hsb hUc hUb] at h

/-- A potential whose distance to the harmonic one grows at most quadratically is
exponentially bounded — the growth-form companion of `expBounded_of_le_harm`. -/
theorem expBounded_of_growth_bound {U : Vd d → ℝ} {A Ccoef B : ℝ} (hA : 0 ≤ A)
    (hC : 0 ≤ Ccoef) (hB : 0 ≤ B)
    (hU : ∀ x, |U x - harmW x| ≤ A * ‖x‖ ^ 2 + Ccoef * ‖x‖ + B) :
    ExpBounded U := by
  refine expBounded_of_le_harm (a := 4 * A + 1 + Ccoef) (b := Ccoef + B) (by positivity)
    (by positivity) fun x => ?_
  have h := hU x
  have hharm : harmW x = ‖x‖ ^ 2 / 4 := rfl
  have hlin : Ccoef * ‖x‖ ≤ Ccoef * (‖x‖ ^ 2 / 4 + 1) :=
    mul_le_mul_of_nonneg_left (by nlinarith [sq_nonneg (‖x‖ - 2)]) hC
  have hsplit : U x = (U x - harmW x) + harmW x := by ring
  have habs : |U x| ≤ |U x - harmW x| + |harmW x| := by
    calc |U x| = |(U x - harmW x) + harmW x| := by rw [← hsplit]
      _ ≤ |U x - harmW x| + |harmW x| := abs_add_le _ _
  have hharm0 : |harmW x| = ‖x‖ ^ 2 / 4 := by
    rw [hharm, abs_of_nonneg (by positivity : (0 : ℝ) ≤ ‖x‖ ^ 2 / 4)]
  rw [hharm]
  rw [hharm0] at habs
  nlinarith [norm_nonneg x]

/-- **The criterion in growth form.**  A continuous potential whose distance to the harmonic
one grows at most like `A‖x‖² + C‖x‖ + B` with `4A < 1` — the linear and constant terms with
*arbitrary* coefficients — is essentially self-adjoint on the Gauss–polynomial core. -/
theorem quadraticGrowth_essentiallySelfAdjoint {U : Vd d → ℝ} (hUc : Continuous U)
    (hUb : ExpBounded U) {A Ccoef B : ℝ} (hA : 0 ≤ A) (hA1 : 4 * A < 1)
    (hB : 0 ≤ B) (hU : ∀ x, |U x - harmW x| ≤ A * ‖x‖ ^ 2 + Ccoef * ‖x‖ + B) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d)) (hamCore U hUc hUb) := by
  set e : ℝ := (1 - 4 * A) / 2 with he
  have he0 : 0 < e := by rw [he]; linarith
  have hene : e ≠ 0 := ne_of_gt he0
  refine esa_of_close_to_harmonic hUc hUb (a := 4 * A + e) (b := B + Ccoef ^ 2 / e)
    (by positivity) (by rw [he]; linarith) (by positivity) fun x => ?_
  have hharm : harmW x = ‖x‖ ^ 2 / 4 := rfl
  have hk : Ccoef ^ 2 / e * e = Ccoef ^ 2 := div_mul_cancel₀ _ hene
  have hlin : Ccoef * ‖x‖ ≤ e / 4 * ‖x‖ ^ 2 + Ccoef ^ 2 / e := by
    nlinarith [sq_nonneg (e * ‖x‖ - 2 * Ccoef), he0, norm_nonneg x]
  have h := hU x
  rw [hharm] at h ⊢
  linarith

/-- **Perturbations of at most linear growth**, with arbitrary coefficients: `−Δ + ‖x‖²/4 + V`
is essentially self-adjoint on the Gauss–polynomial core for every continuous `V` with
`|V(x)| ≤ C‖x‖ + B`.  The perturbation need not be a polynomial. -/
theorem harmonic_add_linearGrowth_essentiallySelfAdjoint {V : Vd d → ℝ} {Ccoef B : ℝ}
    (hB : 0 ≤ B)
    (hV : ∀ x, |V x| ≤ Ccoef * ‖x‖ + B)
    (hsc : Continuous fun x => harmW x + V x) (hsb : ExpBounded fun x => harmW x + V x) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (hamCore (fun x => harmW x + V x) hsc hsb) := by
  refine quadraticGrowth_essentiallySelfAdjoint (A := 0) (Ccoef := Ccoef) (B := B) hsc hsb
    le_rfl (by norm_num) hB fun x => ?_
  have h := hV x
  have : harmW x + V x - harmW x = V x := by ring
  rw [this]
  linarith

/-- **The scaled harmonic oscillator.**  `−Δ + λ‖x‖²/4` is essentially self-adjoint on the
(fixed, width-one) Gauss–polynomial core for every `λ ∈ (0, 2)`. -/
theorem scaledHarmonic_essentiallySelfAdjoint {lam : ℝ} (h0 : 0 < lam) (h2 : lam < 2)
    (hsc : Continuous fun x : Vd d => lam * harmW x)
    (hsb : ExpBounded fun x : Vd d => lam * harmW x) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (hamCore (fun x : Vd d => lam * harmW x) hsc hsb) := by
  refine esa_of_close_to_harmonic hsc hsb (a := |lam - 1|) (b := 0) (abs_nonneg _)
    (by rw [abs_lt]; constructor <;> linarith) le_rfl fun x => ?_
  have hharm : (0 : ℝ) ≤ harmW x := by unfold harmW; positivity
  have : lam * harmW x - harmW x = (lam - 1) * harmW x := by ring
  rw [this, abs_mul, abs_of_nonneg hharm]
  linarith

/-! ## 6. The regularized conformal mode of the `R + αR²` Hamiltonian -/

/-- The conformal-mode potential `V₃(R_c) = −(M²/2)R_c + αR_c²`, as a potential on `L²(ℝ)`. -/
def confW (M alpha : ℝ) (x : Vd 1) : ℝ := confV M alpha (x 0)

theorem continuous_confW (M alpha : ℝ) : Continuous (confW M alpha) := by
  unfold confW confV
  fun_prop

/-- On the line the Euclidean norm is the absolute value of the single coordinate. -/
theorem norm_sq_one (x : Vd 1) : ‖x‖ ^ 2 = (x 0) ^ 2 := by
  rw [norm_sq_eq_sum x, Fin.sum_univ_one]

theorem abs_coord_le_norm (x : Vd 1) : |x 0| ≤ ‖x‖ := by
  have h := norm_sq_one x
  nlinarith [abs_nonneg (x 0), norm_nonneg x, sq_abs (x 0)]

/-- The distance of the conformal-mode potential to the harmonic one grows quadratically with
coefficient `|α − 1/4|`. -/
theorem abs_confW_sub_harmW_le (M alpha : ℝ) (x : Vd 1) :
    |confW M alpha x - harmW x| ≤ |alpha - 1 / 4| * ‖x‖ ^ 2 + (M ^ 2 / 2) * ‖x‖ + 0 := by
  have hsq := norm_sq_one x
  have habs := abs_coord_le_norm x
  have hharm : harmW x = ‖x‖ ^ 2 / 4 := rfl
  have hsplit : confW M alpha x - harmW x
      = (alpha - 1 / 4) * (x 0) ^ 2 - (M ^ 2 / 2) * (x 0) := by
    unfold confW confV
    rw [hharm, hsq]
    ring
  rw [hsplit]
  have h1 : |(alpha - 1 / 4) * (x 0) ^ 2 - (M ^ 2 / 2) * (x 0)|
      ≤ |(alpha - 1 / 4) * (x 0) ^ 2| + |(M ^ 2 / 2) * (x 0)| := abs_sub _ _
  have h2 : |(alpha - 1 / 4) * (x 0) ^ 2| = |alpha - 1 / 4| * ‖x‖ ^ 2 := by
    rw [abs_mul, abs_of_nonneg (sq_nonneg (x 0)), hsq]
  have h3 : |(M ^ 2 / 2) * (x 0)| ≤ (M ^ 2 / 2) * ‖x‖ := by
    rw [abs_mul, abs_of_nonneg (by positivity : (0 : ℝ) ≤ M ^ 2 / 2)]
    exact mul_le_mul_of_nonneg_left habs (by positivity)
  linarith

theorem expBounded_confW (M alpha : ℝ) : ExpBounded (confW M alpha) := by
  refine expBounded_of_le_harm (a := 4 * |alpha - 1 / 4| + 1 + M ^ 2 / 2)
    (b := M ^ 2 / 2) (by positivity) (by positivity) fun x => ?_
  have h := abs_confW_sub_harmW_le M alpha x
  have hharm : harmW x = ‖x‖ ^ 2 / 4 := rfl
  have hlin : (M ^ 2 / 2) * ‖x‖ ≤ (M ^ 2 / 2) * (‖x‖ ^ 2 / 4 + 1) := by
    have : ‖x‖ ≤ ‖x‖ ^ 2 / 4 + 1 := by nlinarith [sq_nonneg (‖x‖ - 2)]
    exact mul_le_mul_of_nonneg_left this (by positivity)
  have habs : |confW M alpha x| ≤ |confW M alpha x - harmW x| + |harmW x| := by
    have hsplit : confW M alpha x = (confW M alpha x - harmW x) + harmW x := by ring
    calc |confW M alpha x| = |(confW M alpha x - harmW x) + harmW x| := by rw [← hsplit]
      _ ≤ |confW M alpha x - harmW x| + |harmW x| := abs_add_le _ _
  have hharm0 : |harmW x| = ‖x‖ ^ 2 / 4 := by
    rw [hharm, abs_of_nonneg (by positivity : (0 : ℝ) ≤ ‖x‖ ^ 2 / 4)]
  rw [hharm]
  rw [hharm0] at habs
  nlinarith [norm_nonneg x, abs_nonneg (alpha - 1 / 4)]

/-- **The regularized conformal mode of the `R + αR²` Hamiltonian is essentially self-adjoint
on the Gauss–polynomial (Hermite) core of `L²(ℝ)`**, unconditionally — no finite-speed and no
unique-continuation hypothesis — for `0 < α < 1/2`.  This is the elliptic (conformal-mode)
instance of `CONSOLIDATED_PLAN.md` §10.6.1 target 4. -/
theorem confV_essentiallySelfAdjoint (M alpha : ℝ) (h0 : 0 < alpha) (h2 : alpha < 1 / 2) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 1))
      (hamCore (confW M alpha) (continuous_confW M alpha) (expBounded_confW M alpha)) := by
  refine quadraticGrowth_essentiallySelfAdjoint (A := |alpha - 1 / 4|) (Ccoef := M ^ 2 / 2)
    (B := 0) _ _ (abs_nonneg _) ?_ le_rfl (abs_confW_sub_harmW_le M alpha)
  have habs : |alpha - 1 / 4| < 1 / 4 := by
    rw [abs_lt]
    constructor <;> linarith
  linarith

/-- The unitary group of the regularized conformal mode, obtained from essential
self-adjointness on the Hermite core rather than from a choice of extension. -/
theorem confV_stone_flow (M alpha : ℝ) (h0 : 0 < alpha) (h2 : alpha < 1 / 2) :
    ∃ (T : UnboundedSelfAdjoint (L2d 1)) (U : ℝ → (L2d 1 →L[ℂ] L2d 1)),
      IsSelfAdjointExtension
        (hamCore (confW M alpha) (continuous_confW M alpha) (expBounded_confW M alpha)) T.op
        ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense (hamCore_symmetricOn _ _ _)
    (confV_essentiallySelfAdjoint M alpha h0 h2)

/-! ## 7. The reduced two-variable sector with a quadratic scalaron term

The reduced `(R_c, φ)` sector of the gauge-fixed `R + αR²` Hamiltonian carries the
conformal-mode parabola `V₃(R_c)` in the first variable and the scalaron potential `V(φ)` in
the second.  The scalaron wall itself is out of reach on this core
(`BookProof.ChapterHermiteExpWall`), but its *harmonic approximation at the minimum* is not:
`V` vanishes to second order at `φ = 0` with `V(φ)/φ² → M²/(24α)`
(`tendsto_starobinskyV_div_sq`), so the model potential `V₃(R_c) + μφ²` with
`μ = M²/(24α)` is the quadratic sector Hamiltonian.  Both variables are handled at once by
the two-dimensional criterion. -/

/-- The reduced sector potential with the scalaron wall replaced by a quadratic term:
`V₃(R_c) + μφ²` on `L²(ℝ²)`. -/
def sectorQuadW (M alpha mu : ℝ) (x : Vd 2) : ℝ := confV M alpha (x 0) + mu * (x 1) ^ 2

theorem continuous_sectorQuadW (M alpha mu : ℝ) : Continuous (sectorQuadW M alpha mu) := by
  unfold sectorQuadW confV
  fun_prop

/-- In two variables the Euclidean norm is the sum of the two coordinate squares. -/
theorem norm_sq_two (x : Vd 2) : ‖x‖ ^ 2 = (x 0) ^ 2 + (x 1) ^ 2 := by
  rw [norm_sq_eq_sum x, Fin.sum_univ_two]

theorem abs_coord_zero_le_norm_two (x : Vd 2) : |x 0| ≤ ‖x‖ := by
  have h := norm_sq_two x
  nlinarith [abs_nonneg (x 0), norm_nonneg x, sq_abs (x 0), sq_nonneg (x 1)]

/-- The distance of the quadratic sector potential to the harmonic one grows quadratically
with coefficient `max |α − 1/4| |μ − 1/4|`. -/
theorem abs_sectorQuadW_sub_harmW_le (M alpha mu : ℝ) (x : Vd 2) :
    |sectorQuadW M alpha mu x - harmW x|
      ≤ max |alpha - 1 / 4| |mu - 1 / 4| * ‖x‖ ^ 2 + (M ^ 2 / 2) * ‖x‖ + 0 := by
  have hsq := norm_sq_two x
  have hc0 := abs_coord_zero_le_norm_two x
  have hharm : harmW x = ‖x‖ ^ 2 / 4 := rfl
  have hsplit : sectorQuadW M alpha mu x - harmW x
      = (alpha - 1 / 4) * (x 0) ^ 2 + (mu - 1 / 4) * (x 1) ^ 2 - (M ^ 2 / 2) * (x 0) := by
    unfold sectorQuadW confV
    rw [hharm, hsq]
    ring
  have hmax0 : |alpha - 1 / 4| ≤ max |alpha - 1 / 4| |mu - 1 / 4| := le_max_left _ _
  have hmax1 : |mu - 1 / 4| ≤ max |alpha - 1 / 4| |mu - 1 / 4| := le_max_right _ _
  have t1 := abs_sub ((alpha - 1 / 4) * (x 0) ^ 2 + (mu - 1 / 4) * (x 1) ^ 2)
    ((M ^ 2 / 2) * (x 0))
  have t2 := abs_add_le ((alpha - 1 / 4) * (x 0) ^ 2) ((mu - 1 / 4) * (x 1) ^ 2)
  have e0 : |(alpha - 1 / 4) * (x 0) ^ 2| = |alpha - 1 / 4| * (x 0) ^ 2 := by
    rw [abs_mul, abs_of_nonneg (sq_nonneg (x 0))]
  have e1 : |(mu - 1 / 4) * (x 1) ^ 2| = |mu - 1 / 4| * (x 1) ^ 2 := by
    rw [abs_mul, abs_of_nonneg (sq_nonneg (x 1))]
  have e2 : |(M ^ 2 / 2) * (x 0)| ≤ (M ^ 2 / 2) * ‖x‖ := by
    rw [abs_mul, abs_of_nonneg (by positivity : (0 : ℝ) ≤ M ^ 2 / 2)]
    exact mul_le_mul_of_nonneg_left hc0 (by positivity)
  have b0 : |alpha - 1 / 4| * (x 0) ^ 2 ≤ max |alpha - 1 / 4| |mu - 1 / 4| * (x 0) ^ 2 :=
    mul_le_mul_of_nonneg_right hmax0 (sq_nonneg _)
  have b1 : |mu - 1 / 4| * (x 1) ^ 2 ≤ max |alpha - 1 / 4| |mu - 1 / 4| * (x 1) ^ 2 :=
    mul_le_mul_of_nonneg_right hmax1 (sq_nonneg _)
  have hAsum : max |alpha - 1 / 4| |mu - 1 / 4| * ‖x‖ ^ 2
      = max |alpha - 1 / 4| |mu - 1 / 4| * (x 0) ^ 2
        + max |alpha - 1 / 4| |mu - 1 / 4| * (x 1) ^ 2 := by
    rw [hsq]; ring
  rw [hsplit]
  linarith

theorem expBounded_sectorQuadW (M alpha mu : ℝ) : ExpBounded (sectorQuadW M alpha mu) :=
  expBounded_of_growth_bound (le_trans (abs_nonneg _) (le_max_left _ _)) (by positivity) le_rfl
    (abs_sectorQuadW_sub_harmW_le M alpha mu)

/-- **The quadratic reduced sector is essentially self-adjoint on the Gauss–polynomial
(Hermite) core of `L²(ℝ²)`**, unconditionally, for `0 < α < 1/2` and `0 < μ < 1/2`: both the
conformal-mode curvature and the scalaron mass have to sit inside the window of the core, and
the mass term `−(M²/2)R_c` is absorbed for free at any `M`. -/
theorem sectorQuad_essentiallySelfAdjoint (M alpha mu : ℝ) (ha0 : 0 < alpha)
    (ha2 : alpha < 1 / 2) (hm0 : 0 < mu) (hm2 : mu < 1 / 2) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 2))
      (hamCore (sectorQuadW M alpha mu) (continuous_sectorQuadW M alpha mu)
        (expBounded_sectorQuadW M alpha mu)) := by
  refine quadraticGrowth_essentiallySelfAdjoint (A := max |alpha - 1 / 4| |mu - 1 / 4|)
    (Ccoef := M ^ 2 / 2) (B := 0) _ _ (le_trans (abs_nonneg _) (le_max_left _ _)) ?_ le_rfl
    (abs_sectorQuadW_sub_harmW_le M alpha mu)
  have h1 : |alpha - 1 / 4| < 1 / 4 := by
    rw [abs_lt]; constructor <;> linarith
  have h2 : |mu - 1 / 4| < 1 / 4 := by
    rw [abs_lt]; constructor <;> linarith
  have hmax : max |alpha - 1 / 4| |mu - 1 / 4| < 1 / 4 := max_lt h1 h2
  linarith

/-- The unitary group of the quadratic reduced sector. -/
theorem sectorQuad_stone_flow (M alpha mu : ℝ) (ha0 : 0 < alpha) (ha2 : alpha < 1 / 2)
    (hm0 : 0 < mu) (hm2 : mu < 1 / 2) :
    ∃ (T : UnboundedSelfAdjoint (L2d 2)) (U : ℝ → (L2d 2 →L[ℂ] L2d 2)),
      IsSelfAdjointExtension
        (hamCore (sectorQuadW M alpha mu) (continuous_sectorQuadW M alpha mu)
          (expBounded_sectorQuadW M alpha mu)) T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ polyGaussCore_dense (hamCore_symmetricOn _ _ _)
    (sectorQuad_essentiallySelfAdjoint M alpha mu ha0 ha2 hm0 hm2)

/-- **The scalaron potential is quadratic at its minimum with curvature `M²/(12α)`**:
`V(φ)/φ² → M²/(24α)` as `φ → 0`.  This is what fixes the physically natural value of `μ` in
`sectorQuadW`. -/
theorem tendsto_starobinskyV_div_sq (M alpha : ℝ) :
    Filter.Tendsto (fun phi : ℝ => starobinskyV M alpha phi / phi ^ 2)
      (nhdsWithin 0 {(0 : ℝ)}ᶜ) (nhds (M ^ 2 / (24 * alpha))) := by
  set k : ℝ := Real.sqrt (2 / 3) / M with hk
  have hg : ∀ phi : ℝ, starobinskyV M alpha phi / phi ^ 2
      = M ^ 4 / (16 * alpha) * ((1 - Real.exp (-(k * phi))) / phi) ^ 2 := by
    intro phi
    unfold starobinskyV
    rw [hk]
    field_simp
  have hderiv : HasDerivAt (fun phi : ℝ => 1 - Real.exp (-(k * phi))) k 0 := by
    have h1 : HasDerivAt (fun phi : ℝ => -(k * phi)) (-k) 0 := by
      simpa using ((hasDerivAt_id (0 : ℝ)).const_mul k).neg
    have h2 := (Real.hasDerivAt_exp (-(k * 0))).comp 0 h1
    simpa using h2.const_sub 1
  have hslope : Filter.Tendsto
      (fun phi : ℝ => (1 - Real.exp (-(k * phi))) / phi) (nhdsWithin 0 {(0 : ℝ)}ᶜ) (nhds k) := by
    have h := hasDerivAt_iff_tendsto_slope.mp hderiv
    refine h.congr fun phi => ?_
    simp [slope_def_field, div_eq_inv_mul, sub_zero]
  have hsq : Filter.Tendsto (fun phi : ℝ => M ^ 4 / (16 * alpha)
      * ((1 - Real.exp (-(k * phi))) / phi) ^ 2)
      (nhdsWithin 0 {(0 : ℝ)}ᶜ) (nhds (M ^ 4 / (16 * alpha) * k ^ 2)) :=
    ((hslope.pow 2).const_mul _)
  have hval : M ^ 4 / (16 * alpha) * k ^ 2 = M ^ 2 / (24 * alpha) := by
    have hk2 : k ^ 2 = (2 / 3) / M ^ 2 := by
      rw [hk, div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2 / 3)]
    rw [hk2]
    field_simp
    ring
  rw [← hval]
  exact hsq.congr fun phi => (hg phi).symm

/-- **The reduced sector at the harmonic approximation of the scalaron potential.**  Taking
`μ = M²/(24α)` — the curvature of `V` at its minimum, `tendsto_starobinskyV_div_sq` — the
quadratic sector Hamiltonian is essentially self-adjoint on the Gauss–polynomial core of
`L²(ℝ²)` whenever `0 < α < 1/2` and `M² < 12α`. -/
theorem sectorHarmonicApprox_essentiallySelfAdjoint (M alpha : ℝ) (hM : M ≠ 0)
    (ha0 : 0 < alpha) (ha2 : alpha < 1 / 2) (hMa : M ^ 2 < 12 * alpha) :
    EssentiallySelfAdjointOn (polyGaussCore (d := 2))
      (hamCore (sectorQuadW M alpha (M ^ 2 / (24 * alpha)))
        (continuous_sectorQuadW M alpha (M ^ 2 / (24 * alpha)))
        (expBounded_sectorQuadW M alpha (M ^ 2 / (24 * alpha)))) := by
  have hM2 : 0 < M ^ 2 := by positivity
  refine sectorQuad_essentiallySelfAdjoint M alpha _ ha0 ha2 (by positivity) ?_
  rw [div_lt_iff₀ (by positivity : (0 : ℝ) < 24 * alpha)]
  linarith

end

end BookProof.HermiteQuadraticEsa
