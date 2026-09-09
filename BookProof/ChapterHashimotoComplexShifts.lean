import Mathlib
import BookProof.ChapterHashimotoShiftInvert
import BookProof.ChapterComplexShiftCore

/-!
# The Hashimoto (SIRK) algorithm with **complex, non-real, and many different shifts**

`BookProof.ChapterHashimotoShiftInvert` develops the shift-invert trick for a
*single, real, positive* shift `γ`, where invertibility of `A + γ` comes from
positivity of `A`.  The Shift-invert Rational Krylov method of Hashimoto and
Nodera is however run with

* shifts `γ` that are **complex with non-zero imaginary part** — then
  `γ I − A` is invertible for *every* self-adjoint `A`, with no positivity
  assumption at all, purely because a non-real number is at distance
  `|Im γ| > 0` from the (real) numerical range; and
* **many different shifts** `γ₁, γ₂, …`, one per step, the rational Krylov
  subspace `Q_m({X_j}, v) = span{v, X₁v, X₂X₁v, …, X_{m-1}⋯X₁v}` being built
  out of the resolvents `X_j = (γ_j I − A)⁻¹`.

This module adapts the theory to that setting.  Everything is in the same
namespace `BookProof.HashimotoShiftInvert`.

## Part 1 — the non-real shift bound

`norm_cshiftMap_ge`: `‖(γ − A)x‖ ≥ |Im γ| ‖x‖` for a **symmetric** `A`, with no
positivity.  Hence `cshiftMap_injective`.

## Part 2 — bijectivity

`cshiftRange_isClosed`, `cshiftRange_orthogonal_eq_bot`, `cshiftMap_surjective`:
for a self-adjoint `A` (symmetry plus the adjoint criterion) and non-real `γ`,
`γ − A` is a bijection of `Dom` onto the whole space.

## Part 3 — the resolvent `X = (γ − A)⁻¹`

`IsShiftInvertC`, `exists_isShiftInvertC`, `IsShiftInvertC.opNorm_le`
(`‖X‖ ≤ 1/|Im γ|`), `IsShiftInvertC.adjoint_eq` (the adjoint of `X` is the
resolvent at the conjugate shift — `X` is no longer self-adjoint, it is normal),
`shiftInvertC_determines`, `isShiftInvertC_unique`, and
`isShiftInvertC_neg_of_isShiftInvert` relating the new theory to the real
positive-shift theory of the previous chapter.

## Part 4 — many shifts

`shiftInvertC_resolvent_identity` (`X_j − X_k = (γ_k − γ_j) X_j X_k`),
`shiftInvertC_commute`, `shiftInvertC_comp_one_sub` (the SIRK relation
`X_j (I − (γ_m − γ_j) X_m) = X_m`), the rational Krylov flag `rkVec`,
`rkSpan`, and `rkSpan_den_eq` — the cleared-denominator form of Hashimoto–Nodera
Eq. (11): `∏_{i<k} (I − (γ_m − γ_i)X_m)` maps the `k`-th rational Krylov vector
to `X_m^k v`, so the rational Krylov subspace built from many shifts is a space
of *rational* functions of the single resolvent `X_m`.  `rkCompression_tendsto`
gives strong convergence of the compressions along the flag.

## Part 5 — the headline

`hashimoto_multishift_selects_friedrichs`.

## Part 6 — a genuinely unbounded example with non-real shifts

The number operator `A eₙ = n eₙ` on `ℓ²(ℕ, ℂ)`, its resolvents at arbitrary
non-real shifts, and `hashimoto_multishift_unbounded_example`.
-/

namespace BookProof.HashimotoShiftInvert

open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology


/-! ## Part 3 — the resolvent `X = (γ I − A)⁻¹` at a non-real shift -/

section CShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

/-- `X` is the **resolvent (shift-invert) of `A` at the complex shift `γ`**: a
bounded everywhere-defined operator inverting `γ I − A` in both directions. -/
def IsShiftInvertC (A : Dom →ₗ[ℂ] F) (γ : ℂ) (X : F →L[ℂ] F) : Prop :=
  (∀ x : Dom, X (cshiftMap A γ x) = (x : F)) ∧
    ∀ u : F, ∃ h : X u ∈ Dom, cshiftMap A γ ⟨X u, h⟩ = u

theorem IsShiftInvertC.mem {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (h : IsShiftInvertC A γ X) (u : F) : X u ∈ Dom := (h.2 u).choose

theorem IsShiftInvertC.shift_apply {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (h : IsShiftInvertC A γ X) (u : F) :
    γ • X u - A ⟨X u, h.mem u⟩ = u := (h.2 u).choose_spec

/-- The unbounded operator is recovered from a resolvent: `A = γ − X⁻¹`. -/
theorem IsShiftInvertC.apply_eq {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (h : IsShiftInvertC A γ X) (u : F) :
    A ⟨X u, h.mem u⟩ = γ • X u - u := by
  have h1 : γ • X u - A ⟨X u, h.mem u⟩ = u := h.shift_apply u
  have ha : γ • X u = u + A ⟨X u, h.mem u⟩ := sub_eq_iff_eq_add.mp h1
  rw [ha]; abel

/-- **The resolvent at a non-real shift is bounded by `1/|Im γ|`** — for any
symmetric `A`, however unbounded, and with no positivity. -/
theorem IsShiftInvertC.norm_apply_le {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (h : IsShiftInvertC A γ X) (hsym : SymmetricOn Dom A) (hγ : γ.im ≠ 0) (u : F) :
    ‖X u‖ ≤ |γ.im|⁻¹ * ‖u‖ := by
  have hpos : 0 < |γ.im| := abs_pos.mpr hγ
  have hb : |γ.im| * ‖((⟨X u, h.mem u⟩ : Dom) : F)‖ ≤ ‖cshiftMap A γ ⟨X u, h.mem u⟩‖ :=
    norm_cshiftMap_ge hsym _ _
  rw [show cshiftMap A γ ⟨X u, h.mem u⟩ = u from h.shift_apply u] at hb
  rw [inv_mul_eq_div, le_div_iff₀ hpos, mul_comm]
  simpa using hb

theorem IsShiftInvertC.opNorm_le {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (h : IsShiftInvertC A γ X) (hsym : SymmetricOn Dom A) (hγ : γ.im ≠ 0) :
    ‖X‖ ≤ |γ.im|⁻¹ :=
  X.opNorm_le_bound (by positivity) (h.norm_apply_le hsym hγ)

theorem IsShiftInvertC.injective {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (h : IsShiftInvertC A γ X) : Function.Injective X := by
  intro u v huv
  have hu := h.shift_apply u
  have hv := h.shift_apply v
  have hsub : (⟨X u, h.mem u⟩ : Dom) = ⟨X v, h.mem v⟩ := Subtype.ext huv
  rw [← hu, ← hv, hsub, huv]

/-- **The domain of `A` is the range of any of its resolvents** — in particular
all the resolvents `X_j` used by the algorithm have the same range. -/
theorem IsShiftInvertC.dom_eq_range {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (h : IsShiftInvertC A γ X) : Dom = LinearMap.range (X : F →ₗ[ℂ] F) := by
  apply le_antisymm
  · intro x hx
    exact ⟨cshiftMap A γ ⟨x, hx⟩, h.1 ⟨x, hx⟩⟩
  · rintro _ ⟨u, rfl⟩
    exact h.mem u

/-- **The adjoint of the resolvent is the resolvent at the conjugate shift.**
For a non-real shift `X = (γ − A)⁻¹` is no longer self-adjoint; instead
`X* = (γ̄ − A)⁻¹`. -/
theorem IsShiftInvertC.inner_adjoint {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X Y : F →L[ℂ] F}
    (hX : IsShiftInvertC A γ X) (hY : IsShiftInvertC A ((starRingEnd ℂ) γ) Y)
    (hsym : SymmetricOn Dom A) (u v : F) :
    (inner ℂ (X u) v : ℂ) = inner ℂ u (Y v) := by
  have hu : γ • X u - A ⟨X u, hX.mem u⟩ = u := hX.shift_apply u
  have hv : (starRingEnd ℂ) γ • Y v - A ⟨Y v, hY.mem v⟩ = v := hY.shift_apply v
  have hcross : (inner ℂ (A ⟨X u, hX.mem u⟩) (Y v) : ℂ)
      = inner ℂ (X u) (A ⟨Y v, hY.mem v⟩) :=
    hsym ⟨X u, hX.mem u⟩ ⟨Y v, hY.mem v⟩
  have e1 : (inner ℂ (X u) v : ℂ)
      = (starRingEnd ℂ) γ * inner ℂ (X u) (Y v) - inner ℂ (X u) (A ⟨Y v, hY.mem v⟩) := by
    conv_lhs => rw [← hv]
    rw [inner_sub_right, inner_smul_right]
  have e2 : (inner ℂ u (Y v) : ℂ)
      = (starRingEnd ℂ) γ * inner ℂ (X u) (Y v) - inner ℂ (A ⟨X u, hX.mem u⟩) (Y v) := by
    conv_lhs => rw [← hu]
    rw [inner_sub_left, inner_smul_left]
  rw [e1, e2, hcross]

/-- **A resolvent determines the operator.**  Two operators (on possibly
different domains) with the same resolvent at the same shift have the same
domain and are equal on it. -/
theorem shiftInvertC_determines {Dom₁ Dom₂ : Submodule ℂ F} {A₁ : Dom₁ →ₗ[ℂ] F}
    {A₂ : Dom₂ →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (h₁ : IsShiftInvertC A₁ γ X) (h₂ : IsShiftInvertC A₂ γ X) :
    Dom₁ = Dom₂ ∧ ∀ (x : F) (hx₁ : x ∈ Dom₁) (hx₂ : x ∈ Dom₂), A₁ ⟨x, hx₁⟩ = A₂ ⟨x, hx₂⟩ := by
  refine ⟨by rw [h₁.dom_eq_range, h₂.dom_eq_range], ?_⟩
  intro x hx₁ hx₂
  set u : F := cshiftMap A₁ γ ⟨x, hx₁⟩ with hu
  have hXu : X u = x := h₁.1 ⟨x, hx₁⟩
  have e₁ : A₁ ⟨X u, h₁.mem u⟩ = γ • X u - u := h₁.apply_eq u
  have e₂ : A₂ ⟨X u, h₂.mem u⟩ = γ • X u - u := h₂.apply_eq u
  have c₁ : (⟨X u, h₁.mem u⟩ : Dom₁) = ⟨x, hx₁⟩ := Subtype.ext hXu
  have c₂ : (⟨X u, h₂.mem u⟩ : Dom₂) = ⟨x, hx₂⟩ := Subtype.ext hXu
  rw [c₁] at e₁
  rw [c₂] at e₂
  rw [e₁, e₂]

/-- The resolvent at a given shift is unique. -/
theorem isShiftInvertC_unique {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X Y : F →L[ℂ] F}
    (hX : IsShiftInvertC A γ X) (hY : IsShiftInvertC A γ Y) : X = Y := by
  ext u
  have h1 : Y (cshiftMap A γ ⟨X u, hX.mem u⟩) = X u := hY.1 ⟨X u, hX.mem u⟩
  rw [show cshiftMap A γ ⟨X u, hX.mem u⟩ = u from hX.shift_apply u] at h1
  exact h1.symm

/-- A right inverse of `γ − A` is automatically a two-sided one, because
`γ − A` is injective for non-real `γ`. -/
theorem isShiftInvertC_of_rightInverse {A : Dom →ₗ[ℂ] F} {γ : ℂ} {X : F →L[ℂ] F}
    (hsym : SymmetricOn Dom A) (hγ : γ.im ≠ 0)
    (hright : ∀ u : F, ∃ h : X u ∈ Dom, cshiftMap A γ ⟨X u, h⟩ = u) :
    IsShiftInvertC A γ X := by
  refine ⟨fun x => ?_, hright⟩
  obtain ⟨hmem, hval⟩ := hright (cshiftMap A γ x)
  have heq : (⟨X (cshiftMap A γ x), hmem⟩ : Dom) = x :=
    cshiftMap_injective hsym hγ (by rw [hval])
  exact congrArg Subtype.val heq

/-- **Existence of the resolvent at a non-real shift** — for a symmetric `A`
with surjective `γ − A`; no positivity and no boundedness. -/
theorem exists_isShiftInvertC {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A)
    {γ : ℂ} (hγ : γ.im ≠ 0) (hsurj : Function.Surjective (cshiftMap A γ)) :
    ∃ X : F →L[ℂ] F, IsShiftInvertC A γ X := by
  classical
  have hpos : 0 < |γ.im| := abs_pos.mpr hγ
  have hinj : Function.Injective (cshiftMap A γ) := cshiftMap_injective hsym hγ
  choose g hg using hsurj
  have hgshift : ∀ x : Dom, g (cshiftMap A γ x) = x := fun x => hinj (hg _)
  have hadd : ∀ u v : F, ((g (u + v) : Dom) : F) = (g u : F) + (g v : F) := by
    intro u v
    have : cshiftMap A γ (g (u + v)) = cshiftMap A γ (g u + g v) := by
      rw [hg, map_add, hg, hg]
    exact congrArg Subtype.val (hinj this)
  have hsmul : ∀ (c : ℂ) (u : F), ((g (c • u) : Dom) : F) = c • (g u : F) := by
    intro c u
    have : cshiftMap A γ (g (c • u)) = cshiftMap A γ (c • g u) := by
      rw [hg, map_smul, hg]
    exact congrArg Subtype.val (hinj this)
  let L : F →ₗ[ℂ] F :=
    { toFun := fun u => (g u : F)
      map_add' := hadd
      map_smul' := by intro c u; simpa using hsmul c u }
  have hbound : ∀ u : F, ‖L u‖ ≤ |γ.im|⁻¹ * ‖u‖ := by
    intro u
    have hb : |γ.im| * ‖((g u : Dom) : F)‖ ≤ ‖cshiftMap A γ (g u)‖ := norm_cshiftMap_ge hsym _ _
    rw [hg u] at hb
    rw [inv_mul_eq_div, le_div_iff₀ hpos, mul_comm]
    exact hb
  refine ⟨L.mkContinuous |γ.im|⁻¹ hbound, fun x => ?_, fun u => ?_⟩
  · change ((g (cshiftMap A γ x) : Dom) : F) = (x : F)
    rw [hgshift x]
  · refine ⟨(g u).2, ?_⟩
    have hsub : (⟨((g u : Dom) : F), (g u).2⟩ : Dom) = g u := Subtype.ext rfl
    change cshiftMap A γ ⟨((g u : Dom) : F), _⟩ = u
    rw [hsub, hg u]

/-- The real positive-shift theory of the previous chapter is the special case
`γ = −c` of this one: `(A + c)⁻¹ = −((−c) − A)⁻¹`.  (Of course `γ = −c` is real,
so this direction needs the positivity that chapter assumes; the point is only
that the two notions of shift-invert agree.) -/
theorem isShiftInvertC_neg_of_isShiftInvert {A : Dom →ₗ[ℂ] F} {c : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A c R) : IsShiftInvertC A (-(c : ℂ)) (-R) := by
  constructor
  · intro x
    have hx : cshiftMap A (-(c : ℂ)) x = -(shiftMap A c x) := by
      simp only [cshiftMap_apply, shiftMap_apply, neg_smul]
      abel
    change (-R) (cshiftMap A (-(c : ℂ)) x) = (x : F)
    rw [hx]
    simp only [ContinuousLinearMap.neg_apply, map_neg, neg_neg]
    exact h.1 x
  · intro u
    have hmemneg : (-R) u ∈ Dom := by
      change -(R u) ∈ Dom
      exact Dom.neg_mem (h.mem u)
    refine ⟨hmemneg, ?_⟩
    have hval : A ⟨R u, h.mem u⟩ + (c : ℂ) • R u = u := h.shift_apply u
    have hcoe : (⟨(-R) u, hmemneg⟩ : Dom) = -(⟨R u, h.mem u⟩ : Dom) := Subtype.ext rfl
    rw [cshiftMap_apply, hcoe, map_neg]
    have hL : (-(c : ℂ)) • (((-(⟨R u, h.mem u⟩ : Dom)) : Dom) : F) - -A ⟨R u, h.mem u⟩
        = A ⟨R u, h.mem u⟩ + (c : ℂ) • R u := by
      simp only [Submodule.coe_neg]
      module
    rw [hL, hval]

end CShiftInvert

/-! ## Part 4 — many shifts: the rational Krylov structure -/

section ManyShifts

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

/-- **The first resolvent identity**, for the resolvents used at two different
steps of the algorithm: `X_j − X_k = (γ_k − γ_j) X_j X_k`. -/
theorem shiftInvertC_resolvent_identity {A : Dom →ₗ[ℂ] F} {γ δ : ℂ} {X Y : F →L[ℂ] F}
    (hX : IsShiftInvertC A γ X) (hY : IsShiftInvertC A δ Y) (u : F) :
    X u - Y u = (δ - γ) • X (Y u) := by
  have hy : δ • Y u - A ⟨Y u, hY.mem u⟩ = u := hY.shift_apply u
  have hsplit : cshiftMap A γ ⟨Y u, hY.mem u⟩ + (δ - γ) • Y u = u := by
    rw [cshiftMap_apply]
    have hrw : γ • ((⟨Y u, hY.mem u⟩ : Dom) : F) - A ⟨Y u, hY.mem u⟩ + (δ - γ) • Y u
        = δ • Y u - A ⟨Y u, hY.mem u⟩ := by
      module
    rw [hrw, hy]
  have hXu : X u = Y u + (δ - γ) • X (Y u) := by
    conv_lhs => rw [← hsplit]
    rw [map_add, map_smul, hX.1 ⟨Y u, hY.mem u⟩]
  rw [hXu]; abel

/-- **Resolvents at different shifts commute.**  This is what makes the
different shifts of the rational Krylov method interchangeable. -/
theorem shiftInvertC_commute {A : Dom →ₗ[ℂ] F} {γ δ : ℂ} {X Y : F →L[ℂ] F}
    (hX : IsShiftInvertC A γ X) (hY : IsShiftInvertC A δ Y) : X ∘L Y = Y ∘L X := by
  rcases eq_or_ne γ δ with rfl | hne
  · rw [isShiftInvertC_unique hX hY]
  · have h1 : ∀ u, X u - Y u = (δ - γ) • X (Y u) :=
      shiftInvertC_resolvent_identity hX hY
    have h2 : ∀ u, Y u - X u = (γ - δ) • Y (X u) :=
      shiftInvertC_resolvent_identity hY hX
    have hd : (δ - γ) ≠ 0 := sub_ne_zero.mpr (Ne.symm hne)
    ext u
    have h3 : (δ - γ) • X (Y u) = (δ - γ) • Y (X u) := by
      have hneg : (δ - γ) • X (Y u) = -((γ - δ) • Y (X u)) := by
        rw [← h1 u, ← h2 u]; abel
      rw [hneg]; module
    exact smul_right_injective F hd h3

/-- **The SIRK relation** `X_j (I − (γ_m − γ_j) X_m) = X_m` of Hashimoto–Nodera:
the resolvent at any shift is a rational function of the resolvent at the last
shift.  This is the identity behind Eq. (11) of the paper. -/
theorem shiftInvertC_comp_one_sub {A : Dom →ₗ[ℂ] F} {γ δ : ℂ} {X Y : F →L[ℂ] F}
    (hX : IsShiftInvertC A γ X) (hY : IsShiftInvertC A δ Y) :
    X ∘L (ContinuousLinearMap.id ℂ F - (δ - γ) • Y) = Y := by
  ext u
  have h := shiftInvertC_resolvent_identity hX hY u
  simp only [ContinuousLinearMap.coe_comp', Function.comp_apply,
    ContinuousLinearMap.sub_apply, ContinuousLinearMap.id_apply,
    ContinuousLinearMap.coe_smul', Pi.smul_apply, map_sub, map_smul]
  rw [← h]
  abel

/-- The `k`-th vector of the **rational Krylov sequence** with shifts `X 0, X 1, …`:
`v, X₀v, X₁X₀v, …` — the vectors spanning `Q_m({X_j}, v)` of Eq. (8). -/
noncomputable def rkVec (X : ℕ → F →L[ℂ] F) (v : F) : ℕ → F
  | 0 => v
  | k + 1 => X k (rkVec X v k)

@[simp] theorem rkVec_zero (X : ℕ → F →L[ℂ] F) (v : F) : rkVec X v 0 = v := rfl

@[simp] theorem rkVec_succ (X : ℕ → F →L[ℂ] F) (v : F) (k : ℕ) :
    rkVec X v (k + 1) = X k (rkVec X v k) := rfl

/-- The **rational Krylov subspace** `Q_m({X_j}, v)` of Eq. (8). -/
noncomputable def rkSpan (X : ℕ → F →L[ℂ] F) (v : F) (m : ℕ) : Submodule ℂ F :=
  Submodule.span ℂ (rkVec X v '' {k | k < m})

theorem rkSpan_mono (X : ℕ → F →L[ℂ] F) (v : F) {m n : ℕ} (hmn : m ≤ n) :
    rkSpan X v m ≤ rkSpan X v n :=
  Submodule.span_mono (Set.image_mono fun _ hk => lt_of_lt_of_le hk hmn)

instance rkSpan_finiteDimensional (X : ℕ → F →L[ℂ] F) (v : F) (m : ℕ) :
    FiniteDimensional ℂ (rkSpan X v m) :=
  FiniteDimensional.span_of_finite ℂ ((Set.finite_Iio m).image _)

/-- The **denominator** `∏_{i<k} (I − (γ_m − γ_i) X_m)` of the rational function
of Eq. (11), built up recursively. -/
noncomputable def sirkDen (Xm : F →L[ℂ] F) (c : ℕ → ℂ) : ℕ → F →L[ℂ] F
  | 0 => ContinuousLinearMap.id ℂ F
  | k + 1 => (ContinuousLinearMap.id ℂ F - c k • Xm) ∘L sirkDen Xm c k

@[simp] theorem sirkDen_zero (Xm : F →L[ℂ] F) (c : ℕ → ℂ) :
    sirkDen Xm c 0 = ContinuousLinearMap.id ℂ F := rfl

@[simp] theorem sirkDen_succ (Xm : F →L[ℂ] F) (c : ℕ → ℂ) (k : ℕ) :
    sirkDen Xm c (k + 1) = (ContinuousLinearMap.id ℂ F - c k • Xm) ∘L sirkDen Xm c k := rfl

/-- Anything commuting with `X_m` commutes with the SIRK denominators, which are
polynomials in `X_m`. -/
theorem sirkDen_commute {Xm T : F →L[ℂ] F} (c : ℕ → ℂ) (hT : T ∘L Xm = Xm ∘L T) (k : ℕ) :
    T ∘L sirkDen Xm c k = sirkDen Xm c k ∘L T := by
  induction k with
  | zero => ext u; simp
  | succ k ih =>
      have h1 : T ∘L (ContinuousLinearMap.id ℂ F - c k • Xm)
          = (ContinuousLinearMap.id ℂ F - c k • Xm) ∘L T := by
        ext u
        have := congrArg (fun S : F →L[ℂ] F => S u) hT
        simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at this
        simp only [ContinuousLinearMap.coe_comp', Function.comp_apply,
          ContinuousLinearMap.sub_apply, ContinuousLinearMap.id_apply,
          ContinuousLinearMap.coe_smul', Pi.smul_apply, map_sub, map_smul, this]
      calc T ∘L ((ContinuousLinearMap.id ℂ F - c k • Xm) ∘L sirkDen Xm c k)
          = (T ∘L (ContinuousLinearMap.id ℂ F - c k • Xm)) ∘L sirkDen Xm c k := rfl
        _ = ((ContinuousLinearMap.id ℂ F - c k • Xm) ∘L T) ∘L sirkDen Xm c k := by rw [h1]
        _ = (ContinuousLinearMap.id ℂ F - c k • Xm) ∘L (T ∘L sirkDen Xm c k) := rfl
        _ = (ContinuousLinearMap.id ℂ F - c k • Xm) ∘L (sirkDen Xm c k ∘L T) := by rw [ih]
        _ = ((ContinuousLinearMap.id ℂ F - c k • Xm) ∘L sirkDen Xm c k) ∘L T := rfl

/-- **The rational Krylov subspace is a space of rational functions of a single
resolvent** (Hashimoto–Nodera Eq. (11)), in cleared-denominator form: with
`c i = γ_m − γ_i`, the `k`-th rational Krylov vector `X_{k-1}⋯X_0 v` satisfies

`∏_{i<k}(I − (γ_m − γ_i)X_m) · X_{k-1}⋯X_0 v = X_m^k v`.

So the space built from *many* shifts is `{p(X_m)/q(X_m) v}` for the fixed
denominator `q`, exactly as in the paper. -/
theorem sirkDen_rkVec {A : Dom →ₗ[ℂ] F} {γ : ℕ → ℂ} {X : ℕ → F →L[ℂ] F} (m : ℕ)
    (hX : ∀ j, IsShiftInvertC A (γ j) (X j)) (v : F) (k : ℕ) :
    sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k) = (X m ^ k) v := by
  induction k with
  | zero => simp
  | succ k ih =>
      have hcomm : X k ∘L X m = X m ∘L X k :=
        shiftInvertC_commute (hX k) (hX m)
      have hden : X k ∘L sirkDen (X m) (fun i => γ m - γ i) k
          = sirkDen (X m) (fun i => γ m - γ i) k ∘L X k :=
        sirkDen_commute _ hcomm k
      have hkey : (ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m) ∘L X k = X m := by
        have h := shiftInvertC_comp_one_sub (hX k) (hX m)
        have hcomm' : X k ∘L (ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m)
            = (ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m) ∘L X k := by
          ext u
          have := congrArg (fun S : F →L[ℂ] F => S u) hcomm
          simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at this
          simp only [ContinuousLinearMap.coe_comp', Function.comp_apply,
            ContinuousLinearMap.sub_apply, ContinuousLinearMap.id_apply,
            ContinuousLinearMap.coe_smul', Pi.smul_apply, map_sub, map_smul, this]
        rw [← hcomm', h]
      calc sirkDen (X m) (fun i => γ m - γ i) (k + 1) (rkVec X v (k + 1))
          = (ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m)
              (sirkDen (X m) (fun i => γ m - γ i) k (X k (rkVec X v k))) := rfl
        _ = (ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m)
              (X k (sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k))) := by
              have := congrArg (fun S : F →L[ℂ] F => S (rkVec X v k)) hden
              simp only [ContinuousLinearMap.coe_comp', Function.comp_apply] at this
              rw [← this]
        _ = (ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m) (X k ((X m ^ k) v)) := by rw [ih]
        _ = ((ContinuousLinearMap.id ℂ F - (γ m - γ k) • X m) ∘L X k) ((X m ^ k) v) := rfl
        _ = (X m ^ (k + 1)) v := by
              rw [hkey, pow_succ']
              rfl

end ManyShifts

/-! ## Part 4b — convergence of the compressions along the rational Krylov flag -/

section RkConvergence

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- The **rational Krylov (Hashimoto/SIRK) compression** `P_m T P_m` of a bounded
operator along the flag of rational Krylov subspaces generated by the shifts. -/
noncomputable def rkCompression (T : F →L[ℂ] F) (X : ℕ → F →L[ℂ] F) (v : F) (m : ℕ) :
    F →L[ℂ] F :=
  (rkSpan X v m).starProjection ∘L T ∘L (rkSpan X v m).starProjection

omit [CompleteSpace F] in
/-- **The rational Krylov projections converge strongly to the identity** when
the flag is dense — the multi-shift analogue of `galerkinProj_tendsto`. -/
theorem rkProj_tendsto (X : ℕ → F →L[ℂ] F) (v : F)
    (hdense : Dense ((⨆ m : ℕ, rkSpan X v m : Submodule ℂ F) : Set F)) (u : F) :
    Tendsto (fun m : ℕ => (rkSpan X v m).starProjection u) atTop (nhds u) :=
  starProjection_tendsto_of_monotone_dense _ (fun _ _ h => rkSpan_mono X v h) hdense u

omit [CompleteSpace F] in
/-- **The multi-shift compressions converge strongly.**  For a dense rational
Krylov flag the compressions `P_m T P_m` of any bounded operator converge to `T`
in the strong operator topology; applied to `T = X_m` this is the convergence of
the SIRK approximation. -/
theorem rkCompression_tendsto (T : F →L[ℂ] F) (X : ℕ → F →L[ℂ] F) (v : F)
    (hdense : Dense ((⨆ m : ℕ, rkSpan X v m : Submodule ℂ F) : Set F)) (u : F) :
    Tendsto (fun m : ℕ => rkCompression T X v m u) atTop (nhds (T u)) :=
  compression_tendsto_of_starProjection_tendsto _ T (rkProj_tendsto X v hdense) u

end RkConvergence

/-! ## Part 5 — the headline theorem for complex, multiple shifts -/

section Headline

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- **The Hashimoto/SIRK algorithm with non-real, step-dependent shifts.**

Let `H` be the matrix of a symmetric Hamiltonian in a complete orthonormal
basis, and let `A` be any positive self-adjoint extension of it — no
boundedness anywhere.  Let `γ : ℕ → ℂ` be an arbitrary sequence of shifts, each
with non-zero imaginary part (which is what makes `γ_j I − A` invertible: the
positivity of `A` is no longer needed).  Then there is a family of resolvents
`X_j = (γ_j I − A)⁻¹` such that

1. each `X_j` is everywhere defined and **bounded**, with `‖X_j‖ ≤ 1/|Im γ_j|`;
2. the `X_j` all have the same range, namely the domain of `A`, and each of them
   determines `A` completely;
3. they satisfy the first resolvent identity and commute pairwise;
4. the SIRK relation `X_j (I − (γ_m − γ_j) X_m) = X_m` holds, so the rational
   Krylov space built from all the shifts is a space of rational functions of the
   single resolvent `X_m` (`sirkDen_rkVec`);
5. the Galerkin truncations of each `X_j` converge to it strongly. -/
theorem hashimoto_multishift_selects_friedrichs (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) {Dom : Submodule ℂ F} (A : Dom →ₗ[ℂ] F)
    (hA : IsPositiveSelfAdjointExtension H A) (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ X : ℕ → F →L[ℂ] F,
      (∀ j, IsShiftInvertC A (γ j) (X j)) ∧
      (∀ j, ‖X j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j, Dom = LinearMap.range ((X j : F →ₗ[ℂ] F))) ∧
      (∀ j k u, X j u - X k u = (γ k - γ j) • X j (X k u)) ∧
      (∀ j k, X j ∘L X k = X k ∘L X j) ∧
      (∀ j m, X j ∘L (ContinuousLinearMap.id ℂ F - (γ m - γ j) • X m) = X m) ∧
      (∀ m v k, sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k) = (X m ^ k) v) ∧
      (∀ j u, Tendsto (fun n : ℕ => galerkinCompression (X j) b n u) atTop (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ F) (A' : Dom' →ₗ[ℂ] F), IsShiftInvertC A' (γ j) (X j) →
        Dom' = Dom ∧ ∀ (x : F) (hx : x ∈ Dom) (hx' : x ∈ Dom'), A' ⟨x, hx'⟩ = A ⟨x, hx⟩) := by
  obtain ⟨-, hsym, -, hsa⟩ := hA
  choose X hX using fun j : ℕ =>
    exists_isShiftInvertC hsym (hγ j) (cshiftMap_surjective hsym hsa (hγ j))
  refine ⟨X, hX, fun j => (hX j).opNorm_le hsym (hγ j), fun j => (hX j).dom_eq_range,
    fun j k u => shiftInvertC_resolvent_identity (hX j) (hX k) u,
    fun j k => shiftInvertC_commute (hX j) (hX k),
    fun j m => shiftInvertC_comp_one_sub (hX j) (hX m),
    fun m v k => sirkDen_rkVec m hX v k,
    fun j u => galerkinCompression_tendsto (X j) b u, ?_⟩
  intro j Dom' A' hA'
  obtain ⟨hdom, hval⟩ := shiftInvertC_determines hA' (hX j)
  exact ⟨hdom, fun x hx hx' => hval x hx' hx⟩

end Headline

/-! ## Part 6 — a genuinely unbounded example with non-real shifts

The number operator `A eₙ = n eₙ` on `ℓ²(ℕ, ℂ)` of
`BookProof.ChapterHashimotoShiftInvert`, whose resolvent at a shift `γ` off the
real axis is the bounded complex diagonal operator `eₙ ↦ eₙ/(γ − n)`.  Running
the algorithm with a whole sequence of such shifts is therefore not vacuous. -/

section UnboundedExample

open scoped InnerProductSpace ENNReal

/-! ### Complex diagonal operators on `ℓ²(ℕ, ℂ)` -/

theorem memlp_diagFunC {c : ℕ → ℂ} {M : ℝ} (hc : ∀ n, ‖c n‖ ≤ M) (x : ℓ²(ℕ, ℂ)) :
    Memℓp (fun n => c n * x n) 2 := by
  have hx : Summable fun n => ‖(x : ℕ → ℂ) n‖ ^ (2 : ℝ≥0∞).toReal :=
    (lp.memℓp x).summable (by norm_num)
  refine memℓp_gen (Summable.of_nonneg_of_le (fun n => by positivity) (fun n => ?_)
    (hx.mul_left (M ^ 2)))
  have ht : (2 : ℝ≥0∞).toReal = 2 := by norm_num
  rw [ht, Real.rpow_two, Real.rpow_two, norm_mul, mul_pow]
  gcongr
  exact hc n

/-- The diagonal (multiplication) operator on `ℓ²(ℕ, ℂ)` with **complex**
coefficients bounded by `M`, as a linear map. -/
noncomputable def diagLinC {c : ℕ → ℂ} {M : ℝ} (hc : ∀ n, ‖c n‖ ≤ M) :
    ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ) where
  toFun x := ⟨fun n => c n * x n, memlp_diagFunC hc x⟩
  map_add' x y := by apply lp.ext; funext n; simp [mul_add]
  map_smul' a x := by apply lp.ext; funext n; simp; ring

@[simp] theorem diagLinC_apply {c : ℕ → ℂ} {M : ℝ} (hc : ∀ n, ‖c n‖ ≤ M) (x : ℓ²(ℕ, ℂ)) (n : ℕ) :
    ((diagLinC hc x : ℓ²(ℕ, ℂ)) : ℕ → ℂ) n = c n * x n := rfl

theorem diagLinC_norm_le {c : ℕ → ℂ} {M : ℝ} (hc : ∀ n, ‖c n‖ ≤ M) (x : ℓ²(ℕ, ℂ)) :
    ‖diagLinC hc x‖ ≤ M * ‖x‖ := by
  have hM : 0 ≤ M := le_trans (norm_nonneg (c 0)) (hc 0)
  refine lp.norm_le_of_tsum_le (by norm_num) (by positivity) ?_
  have hMx : Summable fun n => M ^ (2 : ℝ≥0∞).toReal * ‖(x : ℕ → ℂ) n‖ ^ (2 : ℝ≥0∞).toReal :=
    ((lp.memℓp x).summable (by norm_num)).mul_left _
  refine le_trans (Summable.tsum_le_tsum (fun n => ?_)
    ((memlp_diagFunC hc x).summable (by norm_num)) hMx) ?_
  · have ht : (2 : ℝ≥0∞).toReal = 2 := by norm_num
    change ‖c n * (x : ℕ → ℂ) n‖ ^ (2 : ℝ≥0∞).toReal ≤ _
    rw [ht, Real.rpow_two, Real.rpow_two, Real.rpow_two, norm_mul, mul_pow]
    gcongr
    exact hc n
  · rw [tsum_mul_left, ← lp.norm_rpow_eq_tsum (by norm_num : (0 : ℝ) < (2 : ℝ≥0∞).toReal) x]
    exact le_of_eq (Real.mul_rpow hM (norm_nonneg x)).symm

/-- The complex diagonal operator as a bounded operator, of norm at most `M`. -/
noncomputable def diagCLMC {c : ℕ → ℂ} {M : ℝ} (hc : ∀ n, ‖c n‖ ≤ M) :
    ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ) :=
  (diagLinC hc).mkContinuous M (diagLinC_norm_le hc)

@[simp] theorem diagCLMC_apply {c : ℕ → ℂ} {M : ℝ} (hc : ∀ n, ‖c n‖ ≤ M) (x : ℓ²(ℕ, ℂ)) (n : ℕ) :
    ((diagCLMC hc x : ℓ²(ℕ, ℂ)) : ℕ → ℂ) n = c n * x n := rfl

/-! ### The resolvents of the number operator at non-real shifts -/

/-- The coefficients `1/(γ − n)` of the resolvent of the number operator. -/
noncomputable def resCoeff (γ : ℂ) (n : ℕ) : ℂ := 1 / (γ - n)

/-- The coefficients `(n+1)/(γ − n)`: applying `R = (A+1)⁻¹` to this diagonal
gives the resolvent, which is how one sees that the resolvent lands in the
domain of `A`. -/
noncomputable def preCoeff (γ : ℂ) (n : ℕ) : ℂ := ((n : ℂ) + 1) / (γ - n)

theorem norm_sub_natCast_ge (γ : ℂ) (n : ℕ) : |γ.im| ≤ ‖γ - (n : ℂ)‖ := by
  have h := Complex.abs_im_le_norm (γ - (n : ℂ))
  simpa using h

theorem sub_natCast_ne_zero {γ : ℂ} (hγ : γ.im ≠ 0) (n : ℕ) : γ - (n : ℂ) ≠ 0 := by
  intro h
  have := norm_sub_natCast_ge γ n
  rw [h, norm_zero] at this
  exact hγ (abs_eq_zero.mp (le_antisymm this (abs_nonneg _)))

theorem resCoeff_norm_le {γ : ℂ} (hγ : γ.im ≠ 0) (n : ℕ) : ‖resCoeff γ n‖ ≤ |γ.im|⁻¹ := by
  have hd : 0 < |γ.im| := abs_pos.mpr hγ
  have hw : |γ.im| ≤ ‖γ - (n : ℂ)‖ := norm_sub_natCast_ge γ n
  have hwpos : 0 < ‖γ - (n : ℂ)‖ := lt_of_lt_of_le hd hw
  rw [resCoeff, norm_div, norm_one, div_le_iff₀ hwpos, inv_mul_eq_div, le_div_iff₀ hd]
  nlinarith

theorem preCoeff_norm_le {γ : ℂ} (hγ : γ.im ≠ 0) (n : ℕ) :
    ‖preCoeff γ n‖ ≤ 1 + (|γ.re| + 1) / |γ.im| := by
  have hd : 0 < |γ.im| := abs_pos.mpr hγ
  have hw : |γ.im| ≤ ‖γ - (n : ℂ)‖ := norm_sub_natCast_ge γ n
  have hwpos : 0 < ‖γ - (n : ℂ)‖ := lt_of_lt_of_le hd hw
  have hre : |γ.re - (n : ℝ)| ≤ ‖γ - (n : ℂ)‖ := by
    have h := Complex.abs_re_le_norm (γ - (n : ℂ))
    simpa using h
  have hnum : ((n : ℝ) + 1) ≤ ‖γ - (n : ℂ)‖ + (|γ.re| + 1) := by
    have h1 : (n : ℝ) - γ.re ≤ |γ.re - (n : ℝ)| := by
      rw [abs_sub_comm]; exact le_abs_self _
    have h2 : γ.re ≤ |γ.re| := le_abs_self _
    linarith
  have hnorm : ‖preCoeff γ n‖ = ((n : ℝ) + 1) / ‖γ - (n : ℂ)‖ := by
    rw [preCoeff, norm_div]
    congr 1
    rw [show ((n : ℂ) + 1) = (((n + 1 : ℕ) : ℂ)) by push_cast; ring, Complex.norm_natCast]
    push_cast
    ring
  rw [hnorm, div_le_iff₀ hwpos]
  have hkey : (|γ.re| + 1) ≤ (|γ.re| + 1) / |γ.im| * ‖γ - (n : ℂ)‖ := by
    rw [div_mul_eq_mul_div, le_div_iff₀ hd]
    nlinarith [abs_nonneg γ.re]
  nlinarith

/-- **The resolvent of the number operator at a non-real shift**: the bounded
complex diagonal operator `eₙ ↦ eₙ/(γ − n)`, of norm at most `1/|Im γ|`. -/
noncomputable def ell2Resolvent {γ : ℂ} (hγ : γ.im ≠ 0) : ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ) :=
  diagCLMC (resCoeff_norm_le hγ)

/-- The auxiliary diagonal `eₙ ↦ (n+1) eₙ/(γ − n)`, a preimage of the resolvent
under `R = (A+1)⁻¹`. -/
noncomputable def ell2ResolventPre {γ : ℂ} (hγ : γ.im ≠ 0) : ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ) :=
  diagCLMC (preCoeff_norm_le hγ)

theorem ell2Example_symmetricOn :
    SymmetricOn (LinearMap.range (ell2ShiftInvert : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ)))
      ell2UnboundedExample :=
  ell2Example_isPositiveSelfAdjointExtension.2.1

theorem ell2ShiftInvert_resolventPre {γ : ℂ} (hγ : γ.im ≠ 0) (u : ℓ²(ℕ, ℂ)) :
    ell2ShiftInvert (ell2ResolventPre hγ u) = ell2Resolvent hγ u := by
  apply lp.ext
  funext n
  have hne : γ - (n : ℂ) ≠ 0 := sub_natCast_ne_zero hγ n
  have hn1 : ((n : ℂ) + 1) ≠ 0 := by
    rw [show ((n : ℂ) + 1) = (((n + 1 : ℕ) : ℂ)) by push_cast; ring]
    exact_mod_cast Nat.succ_ne_zero n
  have hcoe : ((invCoeff n : ℝ) : ℂ) = ((n : ℂ) + 1)⁻¹ := by
    rw [invCoeff]
    push_cast
    rw [one_div]
  rw [ell2ShiftInvert, diagCLM_apply, ell2ResolventPre, diagCLMC_apply, ell2Resolvent,
    diagCLMC_apply, hcoe, preCoeff, resCoeff]
  field_simp

/-- **The diagonal operator `eₙ ↦ eₙ/(γ − n)` really is the resolvent** of the
unbounded number operator at the non-real shift `γ`. -/
theorem ell2Resolvent_isShiftInvertC {γ : ℂ} (hγ : γ.im ≠ 0) :
    IsShiftInvertC ell2UnboundedExample γ (ell2Resolvent hγ) := by
  refine isShiftInvertC_of_rightInverse ell2Example_symmetricOn hγ ?_
  intro u
  have hR : ell2ShiftInvert (ell2ResolventPre hγ u) = ell2Resolvent hγ u :=
    ell2ShiftInvert_resolventPre hγ u
  have hmem : ell2Resolvent hγ u
      ∈ LinearMap.range (ell2ShiftInvert : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ)) :=
    ⟨ell2ResolventPre hγ u, hR⟩
  refine ⟨hmem, ?_⟩
  have hpre : preim ell2ShiftInvert ⟨ell2Resolvent hγ u, hmem⟩ = ell2ResolventPre hγ u :=
    preim_eq _ ell2ShiftInvert_injective _ hR
  have hA : ell2UnboundedExample ⟨ell2Resolvent hγ u, hmem⟩
      = ell2ResolventPre hγ u - (1 : ℂ) • (ell2Resolvent hγ u) := by
    rw [ell2UnboundedExample, invShiftOperator_apply, hpre]
    norm_num
  rw [cshiftMap_apply]
  change γ • (ell2Resolvent hγ u) - ell2UnboundedExample ⟨ell2Resolvent hγ u, hmem⟩ = u
  rw [hA]
  apply lp.ext
  funext n
  have hne : γ - (n : ℂ) ≠ 0 := sub_natCast_ne_zero hγ n
  simp only [lp.coeFn_sub, lp.coeFn_smul, Pi.sub_apply, Pi.smul_apply, smul_eq_mul,
    ell2Resolvent, ell2ResolventPre, diagCLMC_apply, resCoeff, preCoeff]
  field_simp
  ring

/-- **The Hashimoto/SIRK algorithm with many non-real shifts, on a genuinely
unbounded Hamiltonian.**  For the number operator `A eₙ = n eₙ` on `ℓ²(ℕ, ℂ)`
— unbounded, by the last clause — and *any* sequence `γ : ℕ → ℂ` of shifts off
the real axis, the resolvents `X_j = (γ_j − A)⁻¹` are the bounded diagonal
operators `eₙ ↦ eₙ/(γ_j − n)`, they obey the resolvent identity, commute, obey
the SIRK relation and the rational-function identity of Eq. (11), their
Galerkin truncations converge to them, and each determines `A`. -/
theorem hashimoto_multishift_unbounded_example (γ : ℕ → ℂ) (hγ : ∀ j, (γ j).im ≠ 0) :
    ∃ X : ℕ → ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ),
      (∀ j u n, ((X j u : ℓ²(ℕ, ℂ)) : ℕ → ℂ) n = (u : ℕ → ℂ) n / (γ j - (n : ℂ))) ∧
      (∀ j, IsShiftInvertC ell2UnboundedExample (γ j) (X j)) ∧
      (∀ j, ‖X j‖ ≤ |(γ j).im|⁻¹) ∧
      (∀ j k u, X j u - X k u = (γ k - γ j) • X j (X k u)) ∧
      (∀ j k, X j ∘L X k = X k ∘L X j) ∧
      (∀ j m, X j ∘L (ContinuousLinearMap.id ℂ (ℓ²(ℕ, ℂ)) - (γ m - γ j) • X m) = X m) ∧
      (∀ m v k, sirkDen (X m) (fun i => γ m - γ i) k (rkVec X v k) = (X m ^ k) v) ∧
      (∀ j u, Tendsto (fun n : ℕ => galerkinCompression (X j) ell2Basis n u) atTop
        (nhds (X j u))) ∧
      (∀ j (Dom' : Submodule ℂ (ℓ²(ℕ, ℂ))) (A' : Dom' →ₗ[ℂ] ℓ²(ℕ, ℂ)),
        IsShiftInvertC A' (γ j) (X j) →
        Dom' = LinearMap.range (ell2ShiftInvert : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ))) ∧
      (∀ C : ℝ, ∃ x : finiteModeDomain ell2Basis,
        C * ‖(x : ℓ²(ℕ, ℂ))‖ < ‖ell2ExampleMatrix x‖) := by
  refine ⟨fun j => ell2Resolvent (hγ j), ?_, fun j => ell2Resolvent_isShiftInvertC (hγ j), ?_, ?_,
    ?_, ?_, ?_, fun j u => galerkinCompression_tendsto _ ell2Basis u, ?_,
    ell2ExampleMatrix_unbounded⟩
  · intro j u n
    have h1 : ((ell2Resolvent (hγ j) u : ℓ²(ℕ, ℂ)) : ℕ → ℂ) n
        = resCoeff (γ j) n * (u : ℕ → ℂ) n := diagCLMC_apply (resCoeff_norm_le (hγ j)) u n
    rw [h1, resCoeff, one_div, inv_mul_eq_div]
  · intro j
    exact (ell2Resolvent_isShiftInvertC (hγ j)).opNorm_le ell2Example_symmetricOn (hγ j)
  · intro j k u
    exact shiftInvertC_resolvent_identity (ell2Resolvent_isShiftInvertC (hγ j))
      (ell2Resolvent_isShiftInvertC (hγ k)) u
  · intro j k
    exact shiftInvertC_commute (ell2Resolvent_isShiftInvertC (hγ j))
      (ell2Resolvent_isShiftInvertC (hγ k))
  · intro j m
    exact shiftInvertC_comp_one_sub (ell2Resolvent_isShiftInvertC (hγ j))
      (ell2Resolvent_isShiftInvertC (hγ m))
  · intro m v k
    exact sirkDen_rkVec m (fun j => ell2Resolvent_isShiftInvertC (hγ j)) v k
  · intro j Dom' A' hA'
    obtain ⟨hdom, -⟩ := shiftInvertC_determines hA' (ell2Resolvent_isShiftInvertC (hγ j))
    exact hdom

end UnboundedExample

end BookProof.HashimotoShiftInvert
