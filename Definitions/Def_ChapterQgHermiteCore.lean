import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterStarobinskyPotential
import Mathlib

import Mathlib

/-!
# The Gauss–polynomial (Hermite) core: the one-particle Hamiltonian is well defined on it

Plan item **§10.6.1, target 1** of `CONSOLIDATED_PLAN.md`: *well-definedness of the
gauge-fixed `R + αR²` one-particle Hamiltonian on the Gauss–polynomial core*.

The scalaron potential `V(φ) = (M⁴/16α)(1 − e^{−√(2/3)φ/M})²` grows **exponentially** as
`φ → −∞`, so it is not of temperate growth and the Schwartz-core multiplication theorem does
not apply to it.  The Gauss–polynomial core `p(x)e^{−x²/4}` — the basis in which the SIRK
numerics actually work — is nevertheless a legitimate domain for it, because its Gaussian
tail **dominates every exponential**.

## What is proved

**1. Gaussian dominance of exponentials.**  `exp_abs_le_const_mul_exp_sq`: for every `c ≥ 0`
and every `x`, `e^{c|x|} ≤ e^{2c²} e^{x²/8}`; hence `exp_abs_mul_gaussH_le`
`e^{c|x|}e^{−x²/4} ≤ e^{2c²}e^{−x²/8}`, and `tendsto_exp_abs_mul_gaussH_cocompact` — the
product tends to `0` at infinity.

**2. The exponential growth class.**  `ExpBounded f` says `|f x| ≤ C e^{c|x|}` for some
constants.  It contains every polynomial (`expBounded_poly`), is closed under sums and
scalar multiples, and contains the scalaron potential (`expBounded_starobinskyV`) — for
which no temperate bound exists.

**3. Multiplication by such a potential maps the core into `L²`.**
`memLp_gaussPoly` (the core lies in `L²`), `memLp_mul_gaussPoly_of_expBounded` (an
exp-bounded continuous potential times a core element is in `L²`), and the instances
`memLp_starobinskyV_mul_gaussPoly` and `memLp_scalaronFull1D_mul_gaussPoly` for the scalaron
potential and for the full one-variable potential `V₃ + V` (conformal-mode parabola plus
scalaron).

**4. The core is invariant under the kinetic term.**  `hasDerivAt_gaussPoly` shows the
derivative of a Gauss polynomial is the Gauss polynomial of `p' − x p / 2`
(`gaussPolyDeriv`), so `deriv_gaussPoly` and `deriv2_gaussPoly` stay in the core, and
`memLp_hamiltonian_gaussPoly` concludes: **`H ψ = −ψ'' + Wψ` lands in `L²` for every core
element `ψ`**, for every continuous exp-bounded potential `W`, in particular for the
scalaron one (`memLp_scalaronHamiltonian_gaussPoly`).

**6. Symmetry on the core.**  `gint_gaussPolyDeriv_antisymm` and
`gint_gaussPolyDeriv_two_symm` are the integration-by-parts identities at polynomial level
(the boundary terms vanish because of the Gaussian weight), and `integral_kinetic_symm` /
`integral_hamiltonian_symm` conclude that `−d²/dx² + W` is **symmetric** on the core for
every continuous exp-bounded `W` (`integral_scalaronHamiltonian_symm` for the scalaron).
This is the symmetric-operator half of the essential-self-adjointness question; the
deficiency half is not proved here (for the potential term alone it is proved, for
exponentially growing potentials too, in `BookProof.ChapterScalaronHermiteEsa`).

**7. Arbitrary dimension.**  `ExpBounded` is stated for any normed space, and
`memLp_mul_pgFun_of_expBounded` transports item 3 to the project's product Gauss–polynomial
core `pgFun` of `L²(ℝᵈ)` (`BookProof.HermiteProductCore`): multiplication by a continuous,
exponentially bounded potential maps that core into `L²(ℝᵈ)`.  `ExpBounded.comp_coord` and
`exists_exp_bound_mvPolyEval` are the two ingredients, and
`memLp_scalaronSectorPotential_mul_pgFun` is the instance for the **reduced two-variable
sector** `(R_c, φ)` with the potential `V₃(R_c) + V(φ)`.

This answers, in the Hermite basis, the domain question that §10.3 flags for the raw
operator.  It does **not** by itself give essential self-adjointness (targets 2–4 of
§10.6.1); those remain open.
-/

namespace BookProof.QgHermiteCore

open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky

/-! ## 1. The Gaussian tail dominates every exponential -/







/-! ## 2. The exponential growth class -/

section ExpBoundedGeneral

variable {E : Type*} [NormedAddCommGroup E]

/-- `ExpBounded f`: `f` is dominated by some exponential, `|f x| ≤ C e^{c‖x‖}`.  This is the
growth class that the Gauss–polynomial core can absorb; it strictly contains the polynomials
and it contains the scalaron potential, which is *not* of temperate growth. -/
def ExpBounded (f : E → ℝ) : Prop :=
  ∃ C c : ℝ, 0 ≤ c ∧ ∀ x, |f x| ≤ C * Real.exp (c * ‖x‖)









end ExpBoundedGeneral









/-! ## 3. The Gauss–polynomial core, and multiplication by such a potential -/

/-- A **Gauss polynomial** `p(x)e^{−x²/4}`: the generic element of the Hermite core. -/
noncomputable def gaussPoly (p : Polynomial ℝ) (x : ℝ) : ℝ := p.eval x * gaussH x













/-! ## 4. The core is invariant under differentiation -/

/-- The polynomial of the derivative of a Gauss polynomial: `(p e^{−x²/4})' =
(p' − x p / 2) e^{−x²/4}`. -/
noncomputable def gaussPolyDeriv (p : Polynomial ℝ) : Polynomial ℝ :=
  Polynomial.derivative p - Polynomial.C (1 / 2) * Polynomial.X * p











/-! ## 6. Symmetry of the Hamiltonian on the core -/

















/-! ## 7. Arbitrary dimension: the product Gauss–polynomial core of `L²(ℝᵈ)` -/

section MultiDim

open BookProof.HermiteProductCore

variable {d : ℕ}







/-! ### The reduced `(R_c, φ)` sector -/

/-- The full potential of the reduced two-variable sector of the gauge-fixed `R + αR²`
Hamiltonian: the conformal-mode parabola `V₃` in the first coordinate plus the scalaron
potential in the second. -/
noncomputable def scalaronSectorPotential (M alpha : ℝ) (V3 : Polynomial ℝ) (x : Vd 2) : ℝ :=
  V3.eval (x 0) + starobinskyV M alpha (x 1)







end MultiDim



variable {E : Type*} [NormedAddCommGroup E]

open BookProof.HermiteProductCore

variable {d : ℕ}

theorem ExpBounded.nonneg_const {f : E → ℝ} {C c : ℝ}
    (h : ∀ x, |f x| ≤ C * Real.exp (c * ‖x‖)) : 0 ≤ C := by
  have h0 := h 0
  rw [norm_zero, mul_zero, Real.exp_zero, mul_one] at h0
  exact (abs_nonneg _).trans h0

theorem exists_exp_bound_mvPolyEval (p : MvPolynomial (Fin d) ℂ) :
    ∃ C c : ℝ, 0 ≤ C ∧ 0 ≤ c ∧ ∀ x : Vd d,
      ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖ ≤ C * Real.exp (c * ‖x‖) := by
  induction p using MvPolynomial.induction_on with
  | C a =>
      refine ⟨‖a‖, 0, norm_nonneg a, le_rfl, fun x => ?_⟩
      simp
  | add p q hp hq =>
      obtain ⟨C1, c1, hC1, hc1, h1⟩ := hp
      obtain ⟨C2, c2, hC2, _, h2⟩ := hq
      refine ⟨C1 + C2, max c1 c2, by linarith, le_trans hc1 (le_max_left _ _), fun x => ?_⟩
      have e1 : C1 * Real.exp (c1 * ‖x‖) ≤ C1 * Real.exp (max c1 c2 * ‖x‖) := by
        gcongr
        exact le_max_left _ _
      have e2 : C2 * Real.exp (c2 * ‖x‖) ≤ C2 * Real.exp (max c1 c2 * ‖x‖) := by
        gcongr
        exact le_max_right _ _
      calc ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) (p + q)‖
          ≤ ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖
            + ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q‖ := by
            rw [map_add]
            exact norm_add_le _ _
        _ ≤ C1 * Real.exp (c1 * ‖x‖) + C2 * Real.exp (c2 * ‖x‖) := add_le_add (h1 x) (h2 x)
        _ ≤ (C1 + C2) * Real.exp (max c1 c2 * ‖x‖) := by linarith
  | mul_X p i hp =>
      obtain ⟨C, c, hC, hc, h⟩ := hp
      refine ⟨C, c + 1, hC, by linarith, fun x => ?_⟩
      have hxi : ‖(((x i : ℝ)) : ℂ)‖ ≤ ‖x‖ := by
        rw [Complex.norm_real]
        exact PiLp.norm_apply_le x i
      have hnorm : ‖x‖ ≤ Real.exp ‖x‖ := by
        have := Real.add_one_le_exp ‖x‖
        linarith
      calc ‖MvPolynomial.eval (fun j => ((x j : ℝ) : ℂ)) (p * MvPolynomial.X i)‖
          = ‖MvPolynomial.eval (fun j => ((x j : ℝ) : ℂ)) p‖ * ‖(((x i : ℝ)) : ℂ)‖ := by
            rw [map_mul, MvPolynomial.eval_X, norm_mul]
        _ ≤ (C * Real.exp (c * ‖x‖)) * Real.exp ‖x‖ :=
            mul_le_mul (h x) (hxi.trans hnorm) (norm_nonneg _) (by positivity)
        _ = C * Real.exp ((c + 1) * ‖x‖) := by
            rw [mul_assoc, ← Real.exp_add]
            congr 1
            ring

theorem memLp_mul_pgFun_of_expBounded {W : Vd d → ℝ} (hW : Continuous W) (hWb : ExpBounded W)
    (p : MvPolynomial (Fin d) ℂ) :
    MemLp (fun x : Vd d => ((W x : ℝ) : ℂ) * pgFun p x) 2 (volume : Measure (Vd d)) := by
  obtain ⟨CW, cW, hcW, hW1⟩ := hWb
  have hCW : 0 ≤ CW := ExpBounded.nonneg_const hW1
  obtain ⟨Cp, cp, hCp, hcp, hp1⟩ := exists_exp_bound_mvPolyEval p
  have hmaj : MemLp (fun x : Vd d => ((CW * Cp : ℝ) : ℂ)
      * ((Real.exp ((cW + cp) * ‖x‖) * gaussD x : ℝ) : ℂ)) 2 (volume : Measure (Vd d)) :=
    (memLp_two_exp_norm_mul_gaussD (cW + cp)).const_mul _
  refine hmaj.of_le ?_ (Filter.Eventually.of_forall fun x => ?_)
  · exact ((Complex.continuous_ofReal.comp hW).mul (continuous_pgFun p)).aestronglyMeasurable
  · have hg : 0 < gaussD x := gaussD_pos x
    have hexp : Real.exp (cW * ‖x‖) * Real.exp (cp * ‖x‖) = Real.exp ((cW + cp) * ‖x‖) := by
      rw [← Real.exp_add]
      congr 1
      ring
    have hlhs : ‖((W x : ℝ) : ℂ) * pgFun p x‖
        = |W x| * (‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖ * gaussD x) := by
      rw [pgFun, norm_mul, norm_mul, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs,
        Real.norm_eq_abs, abs_of_pos hg]
    have hrhs : ‖((CW * Cp : ℝ) : ℂ) * ((Real.exp ((cW + cp) * ‖x‖) * gaussD x : ℝ) : ℂ)‖
        = CW * Cp * (Real.exp ((cW + cp) * ‖x‖) * gaussD x) := by
      rw [norm_mul, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs, Real.norm_eq_abs,
        abs_of_nonneg (by positivity : (0:ℝ) ≤ CW * Cp),
        abs_of_nonneg (by positivity : (0:ℝ) ≤ Real.exp ((cW + cp) * ‖x‖) * gaussD x)]
    rw [hlhs, hrhs]
    calc |W x| * (‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖ * gaussD x)
        ≤ (CW * Real.exp (cW * ‖x‖)) * ((Cp * Real.exp (cp * ‖x‖)) * gaussD x) := by
          have h2 : ‖MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) p‖ * gaussD x
              ≤ (Cp * Real.exp (cp * ‖x‖)) * gaussD x :=
            mul_le_mul_of_nonneg_right (hp1 x) hg.le
          exact mul_le_mul (hW1 x) h2 (by positivity) (by positivity)
      _ = CW * Cp * ((Real.exp (cW * ‖x‖) * Real.exp (cp * ‖x‖)) * gaussD x) := by ring
      _ = CW * Cp * (Real.exp ((cW + cp) * ‖x‖) * gaussD x) := by rw [hexp]


end BookProof.QgHermiteCore
