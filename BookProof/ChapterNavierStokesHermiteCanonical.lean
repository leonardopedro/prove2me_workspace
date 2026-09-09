import Mathlib
import BookProof.ChapterNavierStokesHermiteFarisLavine

/-!
# The canonical pair behind the Navier–Stokes fiber Hamiltonian

`BookProof.ChapterNavierStokesHermiteFarisLavine` proves the two Faris–Lavine
inequalities for a concrete operator `nsH` on `ℓ²(ℕ)` — the `±2`-shift with
amplitudes `w(n) = (κ/2)√((n+1)(n+2))` — and for the diagonal comparison operator
`diagMax (oscSymbol κ)`.  This module verifies that these two operators really
*are* the Navier–Stokes objects they are advertised to be, namely

* `H = ½(π V + V π)`, the symmetrised first-order transport operator, and
* `N = π² + V² + I`, the comparison operator built from the squares of the
  individual non-commuting pieces,

for the canonical pair `π = -i ∂/∂u`, `u` of the fiber and the *linear* advection
field `V(u) = κ u`.  Everything is checked on the finite-mode core
`lpFiniteModes ℕ`, which the Hermite functions span.

## Contents

* `ann`, `cre` — the annihilation and creation operators of the Hermite basis,
  with `[a, a†] = I` (`comm_ann_cre`);
* `mom κ = i√(κ/2)(a† - a)`, `pos κ = (2κ)^{-1/2}(a + a†)`, `drift κ = κ · pos κ`
  — the momentum, the fiber coordinate and the advection field;
* `comm_mom_pos` — **`[π, u] = -i`**: the two are genuinely non-commuting, which
  is the whole point of the Faris–Lavine mechanism;
* `comparison_eq` — **`π² + V² + I = N`**, the diagonal comparison operator of
  the Faris–Lavine chapter;
* `hamiltonian_eq` — **`½(πV + Vπ) = H`**, the `±2`-shift operator of the
  Faris–Lavine chapter;
* `canonical_essentiallySelfAdjointOn_core` — hence the *canonically written*
  Navier–Stokes fiber Hamiltonian `½(πV + Vπ)` is essentially self-adjoint on the
  finite-mode core.
-/

open scoped ENNReal

namespace BookProof.NavierStokesFlow

namespace HermiteCanonical

open LpNat FarisLavine IkebeKato HermiteFarisLavine

/-! ## The core, and states given by their coordinates -/

/-- A finitely supported coordinate sequence as a state of the finite-mode
core. -/
noncomputable def mkCore {X : ℕ → ℂ} (h : (Function.support X).Finite) : lpFiniteModes ℕ :=
  ⟨⟨X, memLpTwo_of_finite_support h⟩, h⟩

@[simp] theorem mkCore_coe {X : ℕ → ℂ} (h : (Function.support X).Finite) (n : ℕ) :
    (((mkCore h : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n = X n := rfl

theorem support_finite (x : lpFiniteModes ℕ) :
    (Function.support (((x : L2I ℕ) : ℕ → ℂ))).Finite := x.2

/-! ## Annihilation and creation -/

/-- `a x` has coordinates `√(n+1) xₙ₊₁`. -/
noncomputable def annFun (X : ℕ → ℂ) : ℕ → ℂ := fun n => (Real.sqrt (n + 1) : ℂ) * X (n + 1)

/-- `a† x` has coordinates `√n xₙ₋₁` (and `0` at `n = 0`, since `√0 = 0`). -/
noncomputable def creFun (X : ℕ → ℂ) : ℕ → ℂ := fun n => (Real.sqrt n : ℂ) * X (n - 1)

theorem support_annFun {X : ℕ → ℂ} (h : (Function.support X).Finite) :
    (Function.support (annFun X)).Finite := by
  refine Set.Finite.subset (h.preimage (f := fun n : ℕ => n + 1) (Set.injOn_of_injective
    (fun a b hab => by omega))) ?_
  intro n hn
  simp only [Function.mem_support, annFun] at hn
  simp only [Set.mem_preimage, Function.mem_support]
  intro h0
  exact hn (by rw [h0, mul_zero])

theorem support_creFun {X : ℕ → ℂ} (h : (Function.support X).Finite) :
    (Function.support (creFun X)).Finite := by
  refine Set.Finite.subset (h.image (fun n : ℕ => n + 1)) ?_
  intro n hn
  simp only [Function.mem_support, creFun] at hn
  have hn0 : n ≠ 0 := by
    intro h0
    apply hn
    simp [h0]
  refine ⟨n - 1, ?_, by simp only []; omega⟩
  simp only [Function.mem_support]
  intro h0
  exact hn (by rw [h0, mul_zero])

/-- **The annihilation operator** of the Hermite basis. -/
noncomputable def ann : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ where
  toFun x := mkCore (support_annFun (support_finite x))
  map_add' x y := by
    refine Subtype.ext (lp.ext (funext fun n => ?_))
    simp only [mkCore_coe, annFun, Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    ring
  map_smul' a x := by
    refine Subtype.ext (lp.ext (funext fun n => ?_))
    simp only [mkCore_coe, annFun, Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply,
      smul_eq_mul, RingHom.id_apply]
    ring

/-- **The creation operator** of the Hermite basis. -/
noncomputable def cre : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ where
  toFun x := mkCore (support_creFun (support_finite x))
  map_add' x y := by
    refine Subtype.ext (lp.ext (funext fun n => ?_))
    simp only [mkCore_coe, creFun, Submodule.coe_add, lp.coeFn_add, Pi.add_apply]
    ring
  map_smul' a x := by
    refine Subtype.ext (lp.ext (funext fun n => ?_))
    simp only [mkCore_coe, creFun, Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply,
      smul_eq_mul, RingHom.id_apply]
    ring

@[simp] theorem ann_coe (x : lpFiniteModes ℕ) (n : ℕ) :
    (((ann x : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n
      = (Real.sqrt (n + 1) : ℂ) * ((x : L2I ℕ) : ℕ → ℂ) (n + 1) := rfl

@[simp] theorem cre_coe (x : lpFiniteModes ℕ) (n : ℕ) :
    (((cre x : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n
      = (Real.sqrt n : ℂ) * ((x : L2I ℕ) : ℕ → ℂ) (n - 1) := rfl

theorem sqrt_mul_sqrt (r : ℝ) (hr : 0 ≤ r) : (Real.sqrt r : ℂ) * (Real.sqrt r : ℂ) = (r : ℂ) := by
  rw [← Complex.ofReal_mul, Real.mul_self_sqrt hr]

/-! ### Coordinates of the quadratic expressions -/

theorem ann_ann_coe (x : lpFiniteModes ℕ) (n : ℕ) :
    (((ann (ann x) : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n
      = (Real.sqrt ((n : ℝ) + 1) : ℂ) * (Real.sqrt ((n : ℝ) + 2) : ℂ)
        * ((x : L2I ℕ) : ℕ → ℂ) (n + 2) := by
  rw [ann_coe, ann_coe]
  push_cast
  ring_nf

theorem cre_cre_coe_add_two (x : lpFiniteModes ℕ) (k : ℕ) :
    (((cre (cre x) : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) (k + 2)
      = (Real.sqrt ((k : ℝ) + 2) : ℂ) * (Real.sqrt ((k : ℝ) + 1) : ℂ)
        * ((x : L2I ℕ) : ℕ → ℂ) k := by
  rw [cre_coe, cre_coe]
  have h1 : (k + 2 - 1) = k + 1 := by omega
  have h2 : (k + 1 - 1) = k := by omega
  rw [h1, h2]
  push_cast
  ring

theorem cre_cre_coe_zero (x : lpFiniteModes ℕ) :
    (((cre (cre x) : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) 0 = 0 := by
  rw [cre_coe]
  simp

theorem cre_cre_coe_one (x : lpFiniteModes ℕ) :
    (((cre (cre x) : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) 1 = 0 := by
  rw [cre_coe, cre_coe]
  simp

theorem ann_cre_coe (x : lpFiniteModes ℕ) (n : ℕ) :
    (((ann (cre x) : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n
      = ((n : ℂ) + 1) * ((x : L2I ℕ) : ℕ → ℂ) n := by
  rw [ann_coe, cre_coe]
  have h1 : (n + 1 - 1) = n := by omega
  rw [h1]
  push_cast
  rw [← mul_assoc, sqrt_mul_sqrt _ (by positivity)]
  push_cast
  ring

theorem cre_ann_coe (x : lpFiniteModes ℕ) (n : ℕ) :
    (((cre (ann x) : lpFiniteModes ℕ) : L2I ℕ) : ℕ → ℂ) n
      = (n : ℂ) * ((x : L2I ℕ) : ℕ → ℂ) n := by
  rw [cre_coe]
  cases n with
  | zero => simp
  | succ k =>
      rw [ann_coe]
      have h1 : (k + 1 - 1) = k := by omega
      rw [h1]
      push_cast
      rw [← mul_assoc, sqrt_mul_sqrt _ (by positivity)]
      push_cast
      ring

/-- **The canonical commutation relation** `[a, a†] = I`. -/
theorem comm_ann_cre : ann.comp cre - cre.comp ann = LinearMap.id := by
  refine LinearMap.ext fun x => Subtype.ext (lp.ext (funext fun n => ?_))
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, LinearMap.id_apply, Submodule.coe_sub,
    lp.coeFn_sub, Pi.sub_apply, ann_cre_coe, cre_ann_coe]
  ring

/-! ## The canonical pair and the advection field -/

variable {κ : ℝ}

/-- The momentum `π = i√(κ/2)(a† - a) = -i ∂/∂u`. -/
noncomputable def mom (κ : ℝ) : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ :=
  (Complex.I * (Real.sqrt (κ / 2) : ℂ)) • (cre - ann)

/-- The fiber coordinate `u = (2κ)^(-1/2)(a + a†)`. -/
noncomputable def pos (κ : ℝ) : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ :=
  ((1 / Real.sqrt (2 * κ) : ℝ) : ℂ) • (cre + ann)

/-- The linear advection field `V(u) = κ u = √(κ/2)(a + a†)`. -/
noncomputable def drift (κ : ℝ) : lpFiniteModes ℕ →ₗ[ℂ] lpFiniteModes ℕ :=
  ((Real.sqrt (κ / 2) : ℝ) : ℂ) • (cre + ann)

/-! ### The three algebraic identities of the canonical pair -/

/-- `[a† - a, a† + a] = -2`. -/
theorem bracket_DS :
    (cre - ann).comp (cre + ann) - (cre + ann).comp (cre - ann) = (-2 : ℂ) • LinearMap.id := by
  refine LinearMap.ext fun x => Subtype.ext (lp.ext (funext fun n => ?_))
  simp only [LinearMap.sub_apply, LinearMap.add_apply, LinearMap.comp_apply, LinearMap.smul_apply,
    LinearMap.id_apply, map_add, map_sub, Submodule.coe_sub, Submodule.coe_add, Submodule.coe_smul,
    lp.coeFn_sub, lp.coeFn_add, lp.coeFn_smul, Pi.sub_apply, Pi.add_apply, Pi.smul_apply,
    smul_eq_mul, ann_cre_coe, cre_ann_coe]
  ring

/-- `(a† + a)² - (a† - a)² = 2(a†a + a a†)`. -/
theorem sq_diff :
    (cre + ann).comp (cre + ann) - (cre - ann).comp (cre - ann)
      = (2 : ℂ) • (cre.comp ann + ann.comp cre) := by
  refine LinearMap.ext fun x => Subtype.ext (lp.ext (funext fun n => ?_))
  simp only [LinearMap.sub_apply, LinearMap.add_apply, LinearMap.comp_apply, LinearMap.smul_apply,
    map_add, map_sub, Submodule.coe_sub, Submodule.coe_add, Submodule.coe_smul,
    lp.coeFn_sub, lp.coeFn_add, lp.coeFn_smul, Pi.sub_apply, Pi.add_apply, Pi.smul_apply,
    smul_eq_mul]
  ring

/-- `(a† - a)(a† + a) + (a† + a)(a† - a) = 2(a†² - a²)`. -/
theorem anti_DS :
    (cre - ann).comp (cre + ann) + (cre + ann).comp (cre - ann)
      = (2 : ℂ) • (cre.comp cre - ann.comp ann) := by
  refine LinearMap.ext fun x => Subtype.ext (lp.ext (funext fun n => ?_))
  simp only [LinearMap.sub_apply, LinearMap.add_apply, LinearMap.comp_apply, LinearMap.smul_apply,
    map_add, map_sub, Submodule.coe_sub, Submodule.coe_add, Submodule.coe_smul,
    lp.coeFn_sub, lp.coeFn_add, lp.coeFn_smul, Pi.sub_apply, Pi.add_apply, Pi.smul_apply,
    smul_eq_mul]
  ring

/-! ### Scalars -/

theorem sqrt_half_sq (hκ : 0 ≤ κ) :
    (Real.sqrt (κ / 2) : ℂ) * (Real.sqrt (κ / 2) : ℂ) = (κ : ℂ) / 2 := by
  rw [sqrt_mul_sqrt _ (by positivity)]
  push_cast
  ring

theorem sqrt_half_mul_inv (hκ : 0 < κ) :
    (Real.sqrt (κ / 2) : ℂ) * ((1 / Real.sqrt (2 * κ) : ℝ) : ℂ) = 1 / 2 := by
  have hreal : Real.sqrt (κ / 2) * (1 / Real.sqrt (2 * κ)) = 1 / 2 := by
    rw [Real.sqrt_div hκ.le, Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 2)]
    have hk : 0 < Real.sqrt κ := Real.sqrt_pos.mpr hκ
    have h2 : Real.sqrt 2 * Real.sqrt 2 = 2 := Real.mul_self_sqrt (by norm_num)
    field_simp
    nlinarith [h2, hk]
  rw [← Complex.ofReal_mul, hreal]
  norm_num

/-- The advection field is `κ` times the fiber coordinate: `V(u) = κu` is *linear*
in `u`, which is what makes `∂V` a constant. -/
theorem drift_eq (hκ : 0 < κ) : drift κ = (κ : ℂ) • pos κ := by
  rw [drift, pos, smul_smul]
  congr 1
  have hne : Real.sqrt (2 * κ) ≠ 0 := Real.sqrt_ne_zero'.mpr (by linarith)
  have hmul : Real.sqrt (κ / 2) * Real.sqrt (2 * κ) = κ := by
    rw [← Real.sqrt_mul (by positivity)]
    have hsq : κ / 2 * (2 * κ) = κ ^ 2 := by ring
    rw [hsq, Real.sqrt_sq hκ.le]
  have hreal : Real.sqrt (κ / 2) = κ * (1 / Real.sqrt (2 * κ)) := by
    rw [eq_comm, mul_one_div, div_eq_iff hne]
    exact hmul.symm
  rw [← Complex.ofReal_mul, ← hreal]

/-- **`[π, u] = -i`.**  The momentum and the fiber coordinate do not commute; this
is exactly why `[H, N] ≠ 0`. -/
theorem comm_mom_pos (hκ : 0 < κ) :
    (mom κ).comp (pos κ) - (pos κ).comp (mom κ) = (-Complex.I) • LinearMap.id := by
  have hs : Complex.I * (Real.sqrt (κ / 2) : ℂ) * ((1 / Real.sqrt (2 * κ) : ℝ) : ℂ) * (-2)
      = -Complex.I := by
    linear_combination (-2 * Complex.I) * sqrt_half_mul_inv hκ
  refine LinearMap.ext fun x => Subtype.ext (lp.ext (funext fun n => ?_))
  simp only [LinearMap.sub_apply, LinearMap.comp_apply, mom, pos, LinearMap.smul_apply,
    LinearMap.id_apply, LinearMap.add_apply, map_smul, map_add, map_sub,
    Submodule.coe_sub, Submodule.coe_add, Submodule.coe_smul, lp.coeFn_sub, lp.coeFn_add,
    lp.coeFn_smul, Pi.sub_apply, Pi.add_apply, Pi.smul_apply, smul_eq_mul,
    ann_cre_coe, cre_ann_coe]
  linear_combination (((x : L2I ℕ) : ℕ → ℂ) n) * hs

/-- The amplitude, factorised. -/
theorem amp_eq_sqrt_mul (κ : ℝ) (n : ℕ) :
    amp κ n = (κ / 2) * (Real.sqrt ((n : ℝ) + 1) * Real.sqrt ((n : ℝ) + 2)) := by
  rw [amp, ← Real.sqrt_mul (by positivity)]

/-- **`π² + V² + I = N`**: the comparison operator of the Faris–Lavine chapter is
the sum of the squares of the individual non-commuting pieces. -/
theorem comparison_eq (hκ : 0 ≤ κ) :
    (lpFiniteModes ℕ).subtype.comp
        ((mom κ).comp (mom κ) + (drift κ).comp (drift κ) + LinearMap.id)
      = (diagMax (oscSymbol κ)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol κ))) := by
  have hsq : (mom κ).comp (mom κ) + (drift κ).comp (drift κ)
      = (κ : ℂ) • (cre.comp ann + ann.comp cre) := by
    have h1 : (mom κ).comp (mom κ)
        = (-((Real.sqrt (κ / 2) : ℂ) * (Real.sqrt (κ / 2) : ℂ))) •
          (cre - ann).comp (cre - ann) := by
      simp only [mom, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
      congr 1
      have : Complex.I * Complex.I = -1 := Complex.I_mul_I
      ring_nf
      rw [Complex.I_sq]
      ring
    have h2 : (drift κ).comp (drift κ)
        = ((Real.sqrt (κ / 2) : ℂ) * (Real.sqrt (κ / 2) : ℂ)) • (cre + ann).comp (cre + ann) := by
      simp only [drift, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
    have hexp : (cre + ann).comp (cre + ann)
        = (cre - ann).comp (cre - ann) + (2 : ℂ) • (cre.comp ann + ann.comp cre) := by
      rw [← sq_diff]
      abel
    rw [h1, h2, sqrt_half_sq hκ, hexp]
    module
  refine LinearMap.ext fun x => lp.ext (funext fun n => ?_)
  simp only [LinearMap.comp_apply, LinearMap.add_apply, hsq, Submodule.subtype_apply,
    LinearMap.smul_apply, LinearMap.id_apply, Submodule.coe_add, Submodule.coe_smul,
    lp.coeFn_add, lp.coeFn_smul, Pi.add_apply, Pi.smul_apply, smul_eq_mul, diagMax_coe,
    ann_cre_coe, cre_ann_coe, Submodule.inclusion_apply]
  simp only [oscSymbol]
  push_cast
  ring

/-- **`½(πV + Vπ) = H`**: the Hamiltonian of the Faris–Lavine chapter is the
symmetrised transport operator. -/
theorem hamiltonian_eq (hκ : 0 ≤ κ) :
    (lpFiniteModes ℕ).subtype.comp
        (((1 : ℂ) / 2) • ((mom κ).comp (drift κ) + (drift κ).comp (mom κ)))
      = (nsH κ hκ).comp (Submodule.inclusion (finiteModes_le_maxDom (oscSymbol κ))) := by
  have hsym : (mom κ).comp (drift κ) + (drift κ).comp (mom κ)
      = (Complex.I * (κ : ℂ)) • (cre.comp cre - ann.comp ann) := by
    have h1 : (mom κ).comp (drift κ)
        = (Complex.I * ((Real.sqrt (κ / 2) : ℂ) * (Real.sqrt (κ / 2) : ℂ))) •
          (cre - ann).comp (cre + ann) := by
      simp only [mom, drift, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
      congr 1
      ring
    have h2 : (drift κ).comp (mom κ)
        = (Complex.I * ((Real.sqrt (κ / 2) : ℂ) * (Real.sqrt (κ / 2) : ℂ))) •
          (cre + ann).comp (cre - ann) := by
      simp only [mom, drift, LinearMap.smul_comp, LinearMap.comp_smul, smul_smul]
      congr 1
      ring
    rw [h1, h2, ← smul_add, anti_DS, sqrt_half_sq hκ, smul_smul]
    congr 1
    ring
  refine LinearMap.ext fun x => lp.ext (funext fun m => ?_)
  simp only [LinearMap.comp_apply, hsym, Submodule.subtype_apply, LinearMap.smul_apply,
    Submodule.coe_smul, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, LinearMap.sub_apply,
    Submodule.coe_sub, lp.coeFn_sub, Pi.sub_apply, nsH_coe, Submodule.inclusion_apply]
  rw [hFun, ann_ann_coe]
  rcases Nat.lt_or_ge m 2 with hm | hm
  · interval_cases m
    · rw [cre_cre_coe_zero]
      simp only [shift2_zero_apply]
      rw [amp_eq_sqrt_mul]
      push_cast
      ring
    · rw [cre_cre_coe_one]
      simp only [shift2_one_apply]
      rw [amp_eq_sqrt_mul]
      push_cast
      ring
  · obtain ⟨k, rfl⟩ : ∃ k, m = k + 2 := ⟨m - 2, by omega⟩
    rw [cre_cre_coe_add_two, shift2_add_two, amp_eq_sqrt_mul, amp_eq_sqrt_mul]
    push_cast
    ring

/-- **The canonically written Navier–Stokes fiber Hamiltonian `½(πV + Vπ)` is
essentially self-adjoint on the finite-mode core.** -/
theorem canonical_essentiallySelfAdjointOn_core (hκ : 0 ≤ κ) :
    EssentiallySelfAdjointOn (lpFiniteModes ℕ)
      ((lpFiniteModes ℕ).subtype.comp
        (((1 : ℂ) / 2) • ((mom κ).comp (drift κ) + (drift κ).comp (mom κ)))) := by
  rw [hamiltonian_eq hκ]
  exact nsH_essentiallySelfAdjointOn_core hκ

end HermiteCanonical

end BookProof.NavierStokesFlow
