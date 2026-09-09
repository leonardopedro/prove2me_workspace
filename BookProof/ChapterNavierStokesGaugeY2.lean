import Mathlib
import BookProof.ChapterNavierStokesGaugeY

/-!
# The second-order second coordinate: `genY2` and the Laplacian modes

Source: `book.tex`, chapter *"Free field parametrization in Classical Statistical
Field Theory and Navier–Stokes equations"* (~4133–4216), and plan item **A.7** of
`PLAN_LEAN_SPECIALIST_NS_FLOW.md` (recorded in `CONSOLIDATED_PLAN.md` §9).

`BookProof.ChapterNavierStokesGaugeY` builds the second coordinate `y` and its
gauge generator `G_j = ∂/∂y_j − u_{i,j} ∂/∂u_i`; that generator compensates only
the *first*-derivative modes, i.e. it annihilates the **linear** field
`u_i(y) = u_i + u_{i,j} y_j`.  The Laplacian modes `u_{i,jj}` therefore sit in the
Hamiltonian without being tied to the expansion of the field.

This module carries out the second-order refinement.  With the same canonical
variables (`BookProof.NavierStokesGaugeY.NSVar`, whose `uL` constructor is the
Laplacian mode) it introduces

* the **second-order field**
  `u_i(y) = u_i + u_{i,j} y_j + ½ u_{i,jj} y_j²`  (`uField2`),
  the genuine Taylor expansion to second order (the `½` is the Taylor
  coefficient; perturbing it breaks the invariance, see
  `genY2_uField2_perturbed_ne_zero`);
* the **derivative field** `u_{i,j}(y) = u_{i,j} + u_{i,jj} y_j` (`uDField`),
  which is exactly `∂ u_i(y)/∂ y_j` (`uField2_pderiv_y`);
* the **second-order gauge generator**
  `G²_j = ∂/∂y_j − u_{i,j} ∂/∂u_i − u_{i,jj} ∂/∂u_{i,j}`  (`genY2`).

The headline results are

* `genY2_uField2` — `G²_j` annihilates the second-order field, so the Laplacian
  modes are now legitimate gauge partners rather than spectators;
* `genY2_uDField` — it annihilates the derivative field as well;
* `genY2_nsSymbol2` — hence the Navier–Stokes symbol built from the *fields*,
  `A_i(y) = ∑_j u_j(y) u_{i,j}(y) − ν u_{i,jj}`, is gauge invariant, while
  `setYZero_nsSymbol2` shows that on the initial state `y = 0` it is the ordinary
  Navier–Stokes symbol `u_j u_{i,j} − ν u_{i,jj}`;
* sharpness in both directions: the first-order generator does **not** annihilate
  the second-order field (`genY_uField2`, `genY_uField2_ne_zero`) and the
  second-order generator does **not** annihilate the first-order field
  (`genY2_uField`, `genY2_uField_ne_zero`);
* `genY2_leibniz` — `G²_j` is a derivation, hence generates a one-parameter group
  of algebra automorphisms, and the second-order gauge algebra is abelian, i.e.
  first class (`genY2_genY2_commute`, `genX_genY2_commute`).

The mixed bracket is *not* zero and we say so honestly
(`genY_genY2_bracket_X_u`, `genY_genY2_not_commute`): the first- and the
second-order generators are truncations of the *same* gauge transformation at
different orders, and only the second-order one is a symmetry of the
second-order field.

Everything here is `sorry`-free and `axiom`-free.
-/

namespace BookProof.NavierStokesGaugeY2

open MvPolynomial BookProof.NavierStokesGaugeY

/-! ## Two generic facts about derivations of the polynomial algebra -/

/-- A linear map of `NSAlg` obeying the Leibniz rule and vanishing on the
constants and on every canonical variable is zero. -/
theorem end_ext_of_leibniz (D : Module.End ℂ NSAlg)
    (hL : ∀ p q, D (p * q) = D p * q + p * D q)
    (hC : ∀ c : ℂ, D (C c) = 0) (hX : ∀ v, D (X v) = 0) : D = 0 := by
  refine LinearMap.ext fun p => ?_
  induction p using MvPolynomial.induction_on with
  | C c => simpa using hC c
  | add p q hp hq => simp [map_add, hp, hq]
  | mul_X p v hp =>
      simp only [LinearMap.zero_apply] at hp ⊢
      rw [hL, hp, hX]; ring

/-- The commutator of two derivations is a derivation. -/
theorem commutator_leibniz (D₁ D₂ : Module.End ℂ NSAlg)
    (h₁ : ∀ p q, D₁ (p * q) = D₁ p * q + p * D₁ q)
    (h₂ : ∀ p q, D₂ (p * q) = D₂ p * q + p * D₂ q) (p q : NSAlg) :
    ⁅D₁, D₂⁆ (p * q) = ⁅D₁, D₂⁆ p * q + p * ⁅D₁, D₂⁆ q := by
  simp only [Ring.lie_def, LinearMap.sub_apply, Module.End.mul_apply, h₁, h₂, map_add]
  ring

/-- `½ · 2 = 1` inside the polynomial algebra. -/
theorem C_half_mul_two : (C (1 / 2 : ℂ) : NSAlg) * 2 = 1 := by
  rw [(map_ofNat C 2).symm, ← C_mul]
  norm_num

/-! ## The second-order field and the derivative field -/

/-- **The second-order field**: the Taylor expansion of the velocity in the
second coordinate carried one order further,
`u_i(y) = u_i + u_{i,j} y_j + ½ u_{i,jj} y_j²`. -/
noncomputable def uField2 (i : Fin 3) : NSAlg :=
  X (NSVar.u i) + (∑ j : Fin 3, X (NSVar.uD i j) * X (NSVar.y j))
    + C (1 / 2 : ℂ) * ∑ j : Fin 3, X (NSVar.uL i) * (X (NSVar.y j) * X (NSVar.y j))

/-- **The derivative field** `u_{i,j}(y) = u_{i,j} + u_{i,jj} y_j`: the first
derivative of the velocity, itself expanded to first order in `y`. -/
noncomputable def uDField (i j : Fin 3) : NSAlg :=
  X (NSVar.uD i j) + X (NSVar.uL i) * X (NSVar.y j)

/-! ### The partial derivatives of the second-order field -/

/-- *The derivative field is the `y`-derivative of the second-order field*:
`∂ u_i(y)/∂ y_j = u_{i,j}(y)`. -/
theorem uField2_pderiv_y (i j : Fin 3) :
    pderiv (NSVar.y j) (uField2 i) = uDField i j := by
  have h1 : pderiv (NSVar.y j) (X (NSVar.u i) : NSAlg) = 0 := by simp [pderiv_X]
  have h2 : ∀ m : Fin 3, pderiv (NSVar.y j) (X (NSVar.uD i m) * X (NSVar.y m) : NSAlg)
      = if j = m then X (NSVar.uD i m) else 0 := by
    intro m; rw [pderiv_mul]
    by_cases h : j = m
    · subst h; simp [pderiv_X]
    · simp [pderiv_X, h, Ne.symm h]
  have h3 : ∀ m : Fin 3,
      pderiv (NSVar.y j) (X (NSVar.uL i) * (X (NSVar.y m) * X (NSVar.y m)) : NSAlg)
        = if j = m then 2 * (X (NSVar.uL i) * X (NSVar.y m)) else 0 := by
    intro m; rw [pderiv_mul, pderiv_mul]
    by_cases h : j = m
    · subst h; simp [pderiv_X]; ring
    · simp [pderiv_X, h, Ne.symm h]
  rw [uField2, map_add, map_add, h1, map_sum, MvPolynomial.pderiv_C_mul, map_sum,
    Finset.sum_congr rfl (fun m _ => h2 m), Finset.sum_congr rfl (fun m _ => h3 m),
    Finset.sum_ite_eq Finset.univ j (fun m => X (NSVar.uD i m)),
    Finset.sum_ite_eq Finset.univ j (fun m => 2 * (X (NSVar.uL i) * X (NSVar.y m))),
    if_pos (Finset.mem_univ j), if_pos (Finset.mem_univ j), uDField, zero_add,
    ← mul_assoc, C_half_mul_two, one_mul]

/-- *The Laplacian mode is the second `y`-derivative of the field*:
`∂² u_i(y)/∂ y_j² = u_{i,jj}`.  This is what makes the modes `u_{i,jj}`
legitimate degrees of freedom of the expansion. -/
theorem uField2_pderiv_y_twice (i j : Fin 3) :
    pderiv (NSVar.y j) (pderiv (NSVar.y j) (uField2 i)) = X (NSVar.uL i) := by
  rw [uField2_pderiv_y, uDField, map_add, pderiv_mul]
  simp [pderiv_X]

/-- The velocity modes enter the field with coefficient one. -/
theorem uField2_pderiv_u (m i : Fin 3) :
    pderiv (NSVar.u m) (uField2 i) = if m = i then 1 else 0 := by
  have h2 : ∀ k : Fin 3, pderiv (NSVar.u m) (X (NSVar.uD i k) * X (NSVar.y k) : NSAlg) = 0 := by
    intro k; rw [pderiv_mul]; simp [pderiv_X]
  have h3 : ∀ k : Fin 3,
      pderiv (NSVar.u m) (X (NSVar.uL i) * (X (NSVar.y k) * X (NSVar.y k)) : NSAlg) = 0 := by
    intro k; rw [pderiv_mul, pderiv_mul]; simp [pderiv_X]
  rw [uField2, map_add, map_add, map_sum, MvPolynomial.pderiv_C_mul, map_sum,
    Finset.sum_eq_zero (fun k _ => h2 k), Finset.sum_eq_zero (fun k _ => h3 k)]
  simp [pderiv_X, Pi.single_apply, @eq_comm _ i m]

/-- The first-derivative modes enter the field linearly in `y`. -/
theorem uField2_pderiv_uD (m k i : Fin 3) :
    pderiv (NSVar.uD m k) (uField2 i) = if m = i then X (NSVar.y k) else 0 := by
  have h1 : pderiv (NSVar.uD m k) (X (NSVar.u i) : NSAlg) = 0 := by simp [pderiv_X]
  have h3 : ∀ l : Fin 3,
      pderiv (NSVar.uD m k) (X (NSVar.uL i) * (X (NSVar.y l) * X (NSVar.y l)) : NSAlg) = 0 := by
    intro l; rw [pderiv_mul, pderiv_mul]; simp [pderiv_X]
  by_cases hm : m = i
  · subst hm
    have h2 : ∀ l : Fin 3, pderiv (NSVar.uD m k) (X (NSVar.uD m l) * X (NSVar.y l) : NSAlg)
        = if k = l then X (NSVar.y l) else 0 := by
      intro l; rw [pderiv_mul]
      by_cases hl : k = l
      · subst hl; simp [pderiv_X]
      · simp [pderiv_X, hl, Ne.symm hl]
    rw [uField2, map_add, map_add, h1, map_sum, MvPolynomial.pderiv_C_mul, map_sum,
      Finset.sum_eq_zero (fun l _ => h3 l), Finset.sum_congr rfl (fun l _ => h2 l),
      Finset.sum_ite_eq Finset.univ k (fun l => X (NSVar.y l)), if_pos (Finset.mem_univ k)]
    simp
  · have h2 : ∀ l : Fin 3, pderiv (NSVar.uD m k) (X (NSVar.uD i l) * X (NSVar.y l) : NSAlg)
        = 0 := by
      intro l; rw [pderiv_mul]
      simp [pderiv_X, hm]
    rw [uField2, map_add, map_add, h1, map_sum, MvPolynomial.pderiv_C_mul, map_sum,
      Finset.sum_eq_zero (fun l _ => h3 l), Finset.sum_eq_zero (fun l _ => h2 l)]
    simp [hm]

/-- The second-order field carries no `x`-dependence. -/
theorem uField2_pderiv_x (i j : Fin 3) : pderiv (NSVar.x j) (uField2 i) = 0 := by
  have h1 : pderiv (NSVar.x j) (X (NSVar.u i) : NSAlg) = 0 := by simp [pderiv_X]
  have h2 : ∀ k : Fin 3, pderiv (NSVar.x j) (X (NSVar.uD i k) * X (NSVar.y k) : NSAlg) = 0 := by
    intro k; rw [pderiv_mul]; simp [pderiv_X]
  have h3 : ∀ k : Fin 3,
      pderiv (NSVar.x j) (X (NSVar.uL i) * (X (NSVar.y k) * X (NSVar.y k)) : NSAlg) = 0 := by
    intro k; rw [pderiv_mul, pderiv_mul]; simp [pderiv_X]
  rw [uField2, map_add, map_add, h1, map_sum, MvPolynomial.pderiv_C_mul, map_sum,
    Finset.sum_eq_zero (fun k _ => h2 k), Finset.sum_eq_zero (fun k _ => h3 k)]
  simp

/-! ### The partial derivatives of the first-order field -/

theorem uField_pderiv_u (m i : Fin 3) :
    pderiv (NSVar.u m) (uField i) = if m = i then 1 else 0 := by
  have h2 : ∀ k : Fin 3, pderiv (NSVar.u m) (X (NSVar.uD i k) * X (NSVar.y k) : NSAlg) = 0 := by
    intro k; rw [pderiv_mul]; simp [pderiv_X]
  rw [uField, map_add, map_sum, Finset.sum_eq_zero (fun k _ => h2 k)]
  simp [pderiv_X, Pi.single_apply, @eq_comm _ i m]

theorem uField_pderiv_uD (m k i : Fin 3) :
    pderiv (NSVar.uD m k) (uField i) = if m = i then X (NSVar.y k) else 0 := by
  have h1 : pderiv (NSVar.uD m k) (X (NSVar.u i) : NSAlg) = 0 := by simp [pderiv_X]
  by_cases hm : m = i
  · subst hm
    have h2 : ∀ l : Fin 3, pderiv (NSVar.uD m k) (X (NSVar.uD m l) * X (NSVar.y l) : NSAlg)
        = if k = l then X (NSVar.y l) else 0 := by
      intro l; rw [pderiv_mul]
      by_cases hl : k = l
      · subst hl; simp [pderiv_X]
      · simp [pderiv_X, hl, Ne.symm hl]
    rw [uField, map_add, h1, map_sum, Finset.sum_congr rfl (fun l _ => h2 l),
      Finset.sum_ite_eq Finset.univ k (fun l => X (NSVar.y l)), if_pos (Finset.mem_univ k)]
    simp
  · have h2 : ∀ l : Fin 3, pderiv (NSVar.uD m k) (X (NSVar.uD i l) * X (NSVar.y l) : NSAlg)
        = 0 := by
      intro l; rw [pderiv_mul]; simp [pderiv_X, hm]
    rw [uField, map_add, h1, map_sum, Finset.sum_eq_zero (fun l _ => h2 l)]
    simp [hm]

/-! ## The second-order gauge generator -/

/-- **The second-order gauge generator**
`G²_j = ∂/∂y_j − u_{i,j} ∂/∂u_i − u_{i,jj} ∂/∂u_{i,j}`: translating the second
coordinate now shifts the velocity modes by their first derivatives *and* the
first-derivative modes by the Laplacian modes. -/
noncomputable def genY2 (j : Fin 3) : Module.End ℂ NSAlg :=
  (pderiv (NSVar.y j)).toLinearMap
    - (∑ i : Fin 3, (LinearMap.mulLeft ℂ (X (NSVar.uD i j) : NSAlg)) ∘ₗ
        (pderiv (NSVar.u i)).toLinearMap)
    - ∑ i : Fin 3, (LinearMap.mulLeft ℂ (X (NSVar.uL i) : NSAlg)) ∘ₗ
        (pderiv (NSVar.uD i j)).toLinearMap

theorem genY2_apply (j : Fin 3) (p : NSAlg) :
    genY2 j p = pderiv (NSVar.y j) p
      - (∑ i : Fin 3, X (NSVar.uD i j) * pderiv (NSVar.u i) p)
      - ∑ i : Fin 3, X (NSVar.uL i) * pderiv (NSVar.uD i j) p := by
  simp [genY2]

/-- `G²_j` obeys the Leibniz rule: it is a derivation, hence generates a
one-parameter group of algebra automorphisms — a genuine gauge transformation. -/
theorem genY2_leibniz (j : Fin 3) (p q : NSAlg) :
    genY2 j (p * q) = genY2 j p * q + p * genY2 j q := by
  have key : ∀ (f : Fin 3 → NSVar) (c : Fin 3 → NSAlg),
      ∑ i : Fin 3, c i * pderiv (f i) (p * q)
        = (∑ i : Fin 3, c i * pderiv (f i) p) * q + p * ∑ i : Fin 3, c i * pderiv (f i) q := by
    intro f c
    rw [Finset.sum_mul, Finset.mul_sum, ← Finset.sum_add_distrib]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [pderiv_mul]; ring
  rw [genY2_apply, genY2_apply, genY2_apply, key (fun i => NSVar.u i) _,
    key (fun i => NSVar.uD i j) _, pderiv_mul]
  ring

@[simp] theorem genY2_C (j : Fin 3) (c : ℂ) : genY2 j (C c) = 0 := by
  simp [genY2_apply]

@[simp] theorem genY2_one (j : Fin 3) : genY2 j (1 : NSAlg) = 0 := by
  simpa using genY2_C j 1

@[simp] theorem genX_one (j : Fin 3) : genX j (1 : NSAlg) = 0 := by
  simp [genX_apply]

/-! ### The action on the canonical variables -/

@[simp] theorem genY2_X_x (j m : Fin 3) : genY2 j (X (NSVar.x m)) = 0 := by
  simp [genY2_apply, pderiv_X]

@[simp] theorem genY2_X_y (j m : Fin 3) :
    genY2 j (X (NSVar.y m)) = if j = m then 1 else 0 := by
  by_cases h : j = m
  · subst h; simp [genY2_apply, pderiv_X]
  · simp [genY2_apply, pderiv_X, h, Ne.symm h]

/-- Translating `y` shifts each velocity mode by its first derivative. -/
@[simp] theorem genY2_X_u (j i : Fin 3) :
    genY2 j (X (NSVar.u i)) = -X (NSVar.uD i j) := by
  simp [genY2_apply, pderiv_X, Pi.single_apply, apply_ite]

/-- **The new ingredient**: translating `y` shifts each first-derivative mode by
the corresponding Laplacian mode. -/
@[simp] theorem genY2_X_uD (j i m : Fin 3) :
    genY2 j (X (NSVar.uD i m)) = if j = m then -X (NSVar.uL i) else 0 := by
  by_cases h : j = m
  · subst h
    simp [genY2_apply, pderiv_X, Pi.single_apply, apply_ite, eq_comm]
  · simp [genY2_apply, pderiv_X, h, Ne.symm h]

/-- The Laplacian modes are gauge invariant. -/
@[simp] theorem genY2_X_uL (j i : Fin 3) : genY2 j (X (NSVar.uL i)) = 0 := by
  simp [genY2_apply, pderiv_X]

/-! ## Gauge invariance of the second-order field -/

/-- **Headline (plan item A.7).** The second-order gauge generator annihilates
the second-order field:
`(∂/∂y_j − u_{k,l} ∂/∂u_k − u_{k,ll} ∂/∂u_{k,l}) (u_i + u_{i,l} y_l + ½ u_{i,ll} y_l²) = 0`.
The shift of the second coordinate is compensated by the shift of the velocity
modes by their first derivatives *and* of the first-derivative modes by the
Laplacian modes; the latter are therefore legitimate gauge partners. -/
theorem genY2_uField2 (i j : Fin 3) : genY2 j (uField2 i) = 0 := by
  rw [genY2_apply, uField2_pderiv_y,
    Finset.sum_congr rfl (fun m (_ : m ∈ Finset.univ) => by
      rw [uField2_pderiv_u m i] :
      ∀ m ∈ Finset.univ, X (NSVar.uD m j) * pderiv (NSVar.u m) (uField2 i)
        = X (NSVar.uD m j) * (if m = i then 1 else 0)),
    Finset.sum_congr rfl (fun m (_ : m ∈ Finset.univ) => by
      rw [uField2_pderiv_uD m j i] :
      ∀ m ∈ Finset.univ, X (NSVar.uL m) * pderiv (NSVar.uD m j) (uField2 i)
        = X (NSVar.uL m) * (if m = i then X (NSVar.y j) else 0))]
  simp only [mul_ite, mul_one, mul_zero, Finset.sum_ite_eq' Finset.univ i,
    if_pos (Finset.mem_univ i), uDField]
  ring

/-- The derivative field is gauge invariant as well: `G²_j u_{i,k}(y) = 0`. -/
theorem genY2_uDField (i j k : Fin 3) : genY2 j (uDField i k) = 0 := by
  rw [uDField, map_add, genY2_X_uD, genY2_leibniz, genY2_X_uL, genY2_X_y]
  by_cases h : j = k <;> simp [h]

/-- The second-order field is annihilated by the `x`-gauge generator (the
standard momentum) too. -/
theorem genX_uField2 (i j : Fin 3) : genX j (uField2 i) = 0 := uField2_pderiv_x i j

/-! ### Sharpness: the two generators are genuinely different -/

/-- The **first-order** generator does not annihilate the second-order field: it
leaves the Laplacian term behind. -/
theorem genY_uField2 (i j : Fin 3) :
    genY j (uField2 i) = X (NSVar.uL i) * X (NSVar.y j) := by
  rw [genY_apply, uField2_pderiv_y,
    Finset.sum_congr rfl (fun m (_ : m ∈ Finset.univ) => by
      rw [uField2_pderiv_u m i] :
      ∀ m ∈ Finset.univ, X (NSVar.uD m j) * pderiv (NSVar.u m) (uField2 i)
        = X (NSVar.uD m j) * (if m = i then 1 else 0))]
  simp only [mul_ite, mul_one, mul_zero, Finset.sum_ite_eq' Finset.univ i,
    if_pos (Finset.mem_univ i), uDField]
  ring

theorem genY_uField2_ne_zero (i j : Fin 3) : genY j (uField2 i) ≠ 0 := by
  rw [genY_uField2]
  exact mul_ne_zero (X_ne_zero _) (X_ne_zero _)

/-- Conversely, the **second-order** generator does not annihilate the
first-order field: the compensation of the first-derivative modes is left
uncancelled. -/
theorem genY2_uField (i j : Fin 3) :
    genY2 j (uField i) = -(X (NSVar.uL i) * X (NSVar.y j)) := by
  rw [genY2_apply, uField_pderiv_y,
    Finset.sum_congr rfl (fun m (_ : m ∈ Finset.univ) => by
      rw [uField_pderiv_u m i] :
      ∀ m ∈ Finset.univ, X (NSVar.uD m j) * pderiv (NSVar.u m) (uField i)
        = X (NSVar.uD m j) * (if m = i then 1 else 0)),
    Finset.sum_congr rfl (fun m (_ : m ∈ Finset.univ) => by
      rw [uField_pderiv_uD m j i] :
      ∀ m ∈ Finset.univ, X (NSVar.uL m) * pderiv (NSVar.uD m j) (uField i)
        = X (NSVar.uL m) * (if m = i then X (NSVar.y j) else 0))]
  simp only [mul_ite, mul_one, mul_zero, Finset.sum_ite_eq' Finset.univ i,
    if_pos (Finset.mem_univ i)]
  ring

theorem genY2_uField_ne_zero (i j : Fin 3) : genY2 j (uField i) ≠ 0 := by
  rw [genY2_uField, neg_ne_zero]
  exact mul_ne_zero (X_ne_zero _) (X_ne_zero _)

/-- **Sharpness of the Taylor coefficient.**  Changing the coefficient of `y_j²`
in the field by a constant `c` gives `G²_j = 2c y_j`, so `½ u_{i,jj}` is the only
admissible quadratic coefficient. -/
theorem genY2_uField2_perturbed (i j : Fin 3) (c : ℂ) :
    genY2 j (uField2 i + C c * (X (NSVar.y j) * X (NSVar.y j)))
      = C c * (2 * X (NSVar.y j)) := by
  rw [map_add, genY2_uField2, zero_add, genY2_leibniz, genY2_C, genY2_leibniz, genY2_X_y,
    if_pos rfl]
  ring

theorem genY2_uField2_perturbed_ne_zero (i j : Fin 3) (c : ℂ) (hc : c ≠ 0) :
    genY2 j (uField2 i + C c * (X (NSVar.y j) * X (NSVar.y j))) ≠ 0 := by
  rw [genY2_uField2_perturbed]
  refine mul_ne_zero ?_ (mul_ne_zero two_ne_zero (X_ne_zero _))
  simpa using hc

/-! ### The second-order gauge algebra is abelian (first class) -/

/-- **The second-order gauge generators commute**: the algebra is abelian, hence
first class. -/
theorem genY2_genY2_commute (j k : Fin 3) : ⁅genY2 j, genY2 k⁆ = 0 := by
  refine end_ext_of_leibniz _
    (commutator_leibniz _ _ (genY2_leibniz j) (genY2_leibniz k)) (fun c => ?_) (fun v => ?_)
  · simp [Ring.lie_def]
  · rw [Ring.lie_def]
    cases v with
    | x m => simp
    | y m => by_cases h : j = m <;> by_cases h' : k = m <;> simp [h, h']
    | u i =>
        by_cases h : j = k
        · subst h; simp
        · simp [h, Ne.symm h]
    | uD i m => by_cases h : j = m <;> by_cases h' : k = m <;> simp [h, h']
    | uL i => simp

/-- **The `x`- and the second-order `y`-generators commute.** -/
theorem genX_genY2_commute (j k : Fin 3) : ⁅genX j, genY2 k⁆ = 0 := by
  refine end_ext_of_leibniz _
    (commutator_leibniz _ _ (genX_leibniz j) (genY2_leibniz k)) (fun c => ?_) (fun v => ?_)
  · simp [Ring.lie_def, genX_apply]
  · rw [Ring.lie_def]
    cases v with
    | x m => by_cases h : j = m <;> simp [genX_apply, pderiv_X, h]
    | y m => by_cases h : k = m <;> simp [genX_apply, pderiv_X, h]
    | u i => simp [genX_apply, pderiv_X]
    | uD i m => by_cases h : k = m <;> simp [genX_apply, pderiv_X, h]
    | uL i => simp [genX_apply, pderiv_X]

/-- **The mixed bracket is not zero.**  On a velocity mode,
`⁅G_j, G²_j⁆ u_i = −u_{i,jj}`: the first-order and the second-order generators
are truncations of the same gauge transformation at different orders, and only
the second-order one is a symmetry of the second-order field. -/
theorem genY_genY2_bracket_X_u (i j : Fin 3) :
    ⁅genY j, genY2 j⁆ (X (NSVar.u i)) = -X (NSVar.uL i) := by
  rw [Ring.lie_def]
  simp [genY_apply, pderiv_X, Pi.single_apply, apply_ite, eq_comm]

theorem genY_genY2_not_commute (j : Fin 3) : ⁅genY j, genY2 j⁆ ≠ 0 := by
  intro h
  have h0 : ⁅genY j, genY2 j⁆ (X (NSVar.u 0)) = 0 := by rw [h]; simp
  rw [genY_genY2_bracket_X_u 0 j, neg_eq_zero] at h0
  exact X_ne_zero (R := ℂ) (NSVar.uL 0) h0

/-! ## The Navier–Stokes symbol in second-order form -/

/-- The Navier–Stokes symbol built from the **fields**,
`A_i(y) = ∑_j u_j(y) u_{i,j}(y) − ν u_{i,jj}`. -/
noncomputable def nsSymbol2 (nu : ℂ) (i : Fin 3) : NSAlg :=
  (∑ j : Fin 3, uField2 j * uDField i j) - C nu * X (NSVar.uL i)

/-- **Headline.** The second-order symbol is invariant under the second-order
gauge generator: with the Laplacian modes now gauge partners of the
first-derivative modes, the advection term `u_j(y) u_{i,j}(y)` is gauge
invariant as it stands. -/
theorem genY2_nsSymbol2 (nu : ℂ) (i j : Fin 3) : genY2 j (nsSymbol2 nu i) = 0 := by
  simp only [nsSymbol2, map_sub, map_sum, genY2_leibniz, genY2_uField2, genY2_uDField,
    genY2_X_uL, genY2_C, zero_mul, mul_zero, add_zero, Finset.sum_const_zero, sub_self]

/-- The second-order symbol is invariant under the `x`-gauge generator. -/
theorem genX_nsSymbol2 (nu : ℂ) (i j : Fin 3) : genX j (nsSymbol2 nu i) = 0 := by
  have huD : ∀ k : Fin 3, genX j (uDField i k) = 0 := by
    intro k
    simp [uDField, genX_apply, pderiv_X]
  have huL : genX j (X (NSVar.uL i)) = 0 := by simp
  have hC : genX j (C nu) = 0 := by simp
  simp only [nsSymbol2, map_sub, map_sum, genX_leibniz, genX_uField2, huD, huL, hC,
    zero_mul, mul_zero, add_zero, Finset.sum_const_zero, sub_self]

/-! ## The initial state `y = 0` -/

@[simp] theorem setYZero_uField2 (i : Fin 3) : setYZero (uField2 i) = X (NSVar.u i) := by
  simp [uField2]

@[simp] theorem setYZero_uDField (i j : Fin 3) :
    setYZero (uDField i j) = X (NSVar.uD i j) := by
  simp [uDField]

/-- **Headline.** *On the initial state, where the second coordinate evaluates to
zero, the second-order symbol is the ordinary Navier–Stokes symbol*
`u_j u_{i,j} − ν u_{i,jj}`: the whole second-order gauge structure is invisible in
the initial data. -/
theorem setYZero_nsSymbol2 (nu : ℂ) (i : Fin 3) :
    setYZero (nsSymbol2 nu i) = nsSymbolPoint nu i := by
  simp [nsSymbol2, nsSymbolPoint]

end BookProof.NavierStokesGaugeY2
