import Mathlib

/-!
# Chapter *"On the physical parity transformation and antiparticles"*, §*"Majorana spinors in
canonical quantization and antiparticles"*: the **bosonic** canonical commutation variant

This file formalizes the self-contained algebraic content of the **bosonic**
paragraph of the book section *"Majorana spinors in canonical quantization and
antiparticles"* (`book.tex` line ~7700), the companion of the fermionic
Clifford/CAR construction already formalized in `ChapterMajoranaClifford.lean`.

There the book writes, for the canonical quantization of a **real symplectic
space** `V` (with a complex structure `J`, `J² = -1`, so that
`ω(v,w) = ⟪v, J w⟫` is the symplectic product):

> *"For bosons, we have a similar situation, except that a commutation relation
> holds `[a(v), a(w)] = ⟪v, J w⟫ i` instead of `{a(v), a(w)} = ⟪v, w⟫ 1`; a
> symplectic product `⟪v, J w⟫ i` replaces the inner product `⟪v, w⟫ 1` … The
> operators `a(v) = a(v + iJ v) + a(v − iJ v)` are again self-adjoint and
> represent a particle which is its own antiparticle."*

The Weyl / CCR algebra realizing this has **no finite-dimensional
representation** (the trace of a commutator vanishes while the trace of a nonzero
scalar does not), and Mathlib has no ready-made Weyl algebra, so — exactly as the
`GhostCAR` hypothesis structure of `ChapterBRSTNilpotent.lean` does for the
fermionic ghosts — we package the two book relations as a **hypothesis
structure** `BosonicCCR` on an abstract complex `*`-algebra `R`:

* `selfAdjoint` : each field operator `a(v)` is **self-adjoint**
  (`star (a v) = a v`) — *"a particle which is its own antiparticle"*;
* `ccr` : the **canonical commutation relation**
  `a(v)·a(w) − a(w)·a(v) = (i · ⟪v, J w⟫)·1`.

Here `a : V →ₗ[ℝ] R` is the **real-linear** field map (a real representation), and
`R` is a complex `*`-algebra. From these two relations we derive:

* `symplectic_antisymm` / `symplectic_self` — the symplectic form `ω(v,w) = ⟪v,J w⟫`
  built from a skew `J` is **antisymmetric** and **alternating** (`ω(v,v) = 0`);
* `field_commute_self_scalar` — the CCR scalar for `v = w` **vanishes**, i.e. a
  field operator commutes with itself (consistency with `ω(v,v) = 0`);
* `commutator_antiSelfAdjoint` — the commutator `[a(v),a(w)]` is
  **anti-self-adjoint**, which is exactly the self-adjointness constraint on
  `i·ω(v,w)·1` (a real multiple of `i` is anti-self-adjoint);
* `field_comp_selfAdjoint` — **real representations preserve self-adjointness**:
  for *any* real-linear `T : V → V`, `a(T v)` is again self-adjoint
  (the book's `a(v) → a(T v)` with `T` a real operator);
* `ccr_symplectic_invariant` — a **symplectic symmetry** `T` (one preserving
  `ω`) transports the CCR unchanged: `a ∘ T` satisfies the same commutation
  relation;
* `ann` / `cre`, `star_ann` / `star_cre` — the **creation/annihilation split**
  `a(v ± iJv)`: the involution `*` **swaps** annihilation and creation
  (`star (ann v) = cre v`), and `ann_add_cre` recovers the self-adjoint field
  `ann v + cre v = a v + a v`;
* `commutator_field_Jfield` — `[a(v), a(J v)] = -(i · ‖v‖²)·1` (using `J² = -1`);
* `commutator_cre_ann` — the resulting **number-operator CCR**
  `[c(v), a(v)] = (2‖v‖²)·1`, the bosonic analogue of `[a, a†] = 1`.

The C\*-completion (the natural norm) is prose in the book and is not formalized.
-/

open RealInnerProductSpace

namespace BookProof.Bosonic

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V]
variable {R : Type*} [Ring R] [StarRing R] [Algebra ℂ R] [Algebra ℝ R]
  [IsScalarTower ℝ ℂ R] [StarModule ℂ R]

/-- **Bosonic canonical commutation relations.**  For a real symplectic space
`V` with complex structure `J` (`ω(v,w) = ⟪v, J w⟫`), a real-linear field map
`a : V →ₗ[ℝ] R` into a complex `*`-algebra `R` such that every `a(v)` is
self-adjoint and `[a(v), a(w)] = (i · ⟪v, J w⟫)·1`.  This is the bosonic (Weyl /
CCR) companion of `ChapterMajoranaClifford`'s fermionic Clifford relation. -/
structure BosonicCCR (J : V →ₗ[ℝ] V) (a : V →ₗ[ℝ] R) : Prop where
  /-- Each field operator is **self-adjoint** (the Majorana / own-antiparticle
  property). -/
  selfAdjoint : ∀ v, star (a v) = a v
  /-- The **canonical commutation relation** `[a(v),a(w)] = (i·⟪v,J w⟫)·1`. -/
  ccr : ∀ v w, a v * a w - a w * a v = algebraMap ℂ R (Complex.I * (⟪v, J w⟫ : ℂ))

variable {J : V →ₗ[ℝ] V} {a : V →ₗ[ℝ] R}

/-- The symplectic form `ω(v,w) = ⟪v, J w⟫` induced by a **skew** `J` is
**antisymmetric**: `⟪v, J w⟫ = -⟪w, J v⟫`. -/
theorem symplectic_antisymm (hJ : ∀ v w : V, ⟪J v, w⟫ = -⟪v, J w⟫) (v w : V) :
    (⟪v, J w⟫ : ℝ) = -⟪w, J v⟫ := by
  have h1 : ⟪J v, w⟫ = -⟪v, J w⟫ := hJ v w
  have h2 : ⟪J v, w⟫ = ⟪w, J v⟫ := by rw [real_inner_comm]
  linarith

/-- The symplectic form is **alternating**: `ω(v,v) = ⟪v, J v⟫ = 0`. -/
theorem symplectic_self (hJ : ∀ v w : V, ⟪J v, w⟫ = -⟪v, J w⟫) (v : V) :
    (⟪v, J v⟫ : ℝ) = 0 := by
  have := symplectic_antisymm hJ v v; linarith

omit [StarRing R] [Algebra ℝ R] [IsScalarTower ℝ ℂ R] [StarModule ℂ R] in
/-- The CCR scalar vanishes for `v = w`: a field operator **commutes with
itself**, consistent with `ω(v,v) = 0`. -/
theorem field_commute_self_scalar (hJ : ∀ v w : V, ⟪J v, w⟫ = -⟪v, J w⟫) (v : V) :
    algebraMap ℂ R (Complex.I * (⟪v, J v⟫ : ℂ)) = 0 := by
  rw [symplectic_self hJ v]; simp

omit [IsScalarTower ℝ ℂ R] [StarModule ℂ R] in
/-- The commutator `[a(v),a(w)]` is **anti-self-adjoint**
(`star [a(v),a(w)] = -[a(v),a(w)]`), the self-adjointness constraint satisfied by
`i·ω(v,w)·1` (a real multiple of `i`). -/
theorem commutator_antiSelfAdjoint (h : BosonicCCR J a) (v w : V) :
    star (a v * a w - a w * a v) = -(a v * a w - a w * a v) := by
  rw [star_sub, star_mul, star_mul, h.selfAdjoint, h.selfAdjoint]; abel

omit [IsScalarTower ℝ ℂ R] [StarModule ℂ R] in
/-- **Real representations preserve self-adjointness.**  For any real-linear
`T : V → V`, the transformed field `a(T v)` is again self-adjoint, so the
symmetry action `a(v) → a(T v)` preserves the self-adjointness condition. -/
theorem field_comp_selfAdjoint (h : BosonicCCR J a) (T : V →ₗ[ℝ] V) (v : V) :
    star (a (T v)) = a (T v) := h.selfAdjoint (T v)

omit [IsScalarTower ℝ ℂ R] [StarModule ℂ R] in
/-- **Symplectic symmetries transport the CCR.**  If a real-linear `T` preserves
the symplectic form (`ω(T v, T w) = ω(v, w)`), then the transformed fields
`a ∘ T` satisfy the same canonical commutation relation. -/
theorem ccr_symplectic_invariant (h : BosonicCCR J a) (T : V →ₗ[ℝ] V)
    (hT : ∀ v w : V, (⟪T v, J (T w)⟫ : ℝ) = ⟪v, J w⟫) (v w : V) :
    a (T v) * a (T w) - a (T w) * a (T v)
      = algebraMap ℂ R (Complex.I * (⟪v, J w⟫ : ℂ)) := by
  rw [h.ccr (T v) (T w), hT v w]

/-- The **annihilation** operator `a(v + iJ v) = a(v) + i·a(J v)`. -/
noncomputable def ann (a : V →ₗ[ℝ] R) (J : V →ₗ[ℝ] V) (v : V) : R :=
  a v + Complex.I • a (J v)

/-- The **creation** operator `a(v − iJ v) = a(v) − i·a(J v)`. -/
noncomputable def cre (a : V →ₗ[ℝ] R) (J : V →ₗ[ℝ] V) (v : V) : R :=
  a v - Complex.I • a (J v)

omit [IsScalarTower ℝ ℂ R] in
/-- The involution `*` sends **annihilation to creation**:
`star (ann v) = cre v`. -/
theorem star_ann (h : BosonicCCR J a) (v : V) : star (ann a J v) = cre a J v := by
  unfold ann cre
  rw [star_add, star_smul, h.selfAdjoint, h.selfAdjoint]
  simp [sub_eq_add_neg]

omit [IsScalarTower ℝ ℂ R] in
/-- The involution `*` sends **creation to annihilation**:
`star (cre v) = ann v`. -/
theorem star_cre (h : BosonicCCR J a) (v : V) : star (cre a J v) = ann a J v := by
  unfold ann cre
  rw [star_sub, star_smul, h.selfAdjoint, h.selfAdjoint]
  simp [sub_eq_add_neg]

omit [StarRing R] [IsScalarTower ℝ ℂ R] [StarModule ℂ R] in
/-- The self-adjoint field is recovered from the creation/annihilation split:
`ann v + cre v = a v + a v` (the book's `a(v) = a(v+iJv) + a(v−iJv)`). -/
theorem ann_add_cre (v : V) : ann a J v + cre a J v = a v + a v := by
  unfold ann cre; abel

omit [IsScalarTower ℝ ℂ R] [StarModule ℂ R] in
/-- `[a(v), a(J v)] = -(i·‖v‖²)·1` (using the complex structure `J² = -1`). -/
theorem commutator_field_Jfield (h : BosonicCCR J a) (hJsq : ∀ v, J (J v) = -v) (v : V) :
    a v * a (J v) - a (J v) * a v
      = algebraMap ℂ R (-(Complex.I * ((‖v‖ ^ 2 : ℝ) : ℂ))) := by
  rw [h.ccr v (J v), hJsq v]
  congr 1
  rw [inner_neg_right, real_inner_self_eq_norm_sq]
  push_cast; ring

omit [StarRing R] [Algebra ℂ R] [Algebra ℝ R] [IsScalarTower ℝ ℂ R] [StarModule ℂ R] in
/-- Expansion of the commutator of `x ∓ c·y` for a **central** element `c`:
`(x - c·y)(x + c·y) - (x + c·y)(x - c·y) = 2c·(x·y - y·x)`. -/
private theorem central_comm_expand {c x y : R} (hc : ∀ z : R, c * z = z * c) :
    (x - c * y) * (x + c * y) - (x + c * y) * (x - c * y) = (2 * c) * (x * y - y * x) := by
  have hcx : c * x = x * c := hc x
  have e1 : x * (c * y) = c * (x * y) := by rw [← mul_assoc, ← hcx, mul_assoc]
  have e2 : (c * y) * x = c * (y * x) := by rw [mul_assoc]
  noncomm_ring [e1, e2]

omit [IsScalarTower ℝ ℂ R] [StarModule ℂ R] in
/-- The **number-operator CCR**: `[c(v), a(v)] = (2‖v‖²)·1`, the bosonic analogue
of `[a, a†] = 1`.  Here `c(v) = cre a J v` is the creation operator and
`a(v) = ann a J v` the annihilation operator. -/
theorem commutator_cre_ann (h : BosonicCCR J a) (hJsq : ∀ v, J (J v) = -v) (v : V) :
    cre a J v * ann a J v - ann a J v * cre a J v
      = algebraMap ℂ R ((2 * (‖v‖ ^ 2 : ℝ) : ℂ)) := by
  have key := commutator_field_Jfield h hJsq v
  simp only [cre, ann, Algebra.smul_def]
  rw [central_comm_expand (fun z => Algebra.commutes Complex.I z), key,
    show (2 : R) * algebraMap ℂ R Complex.I = algebraMap ℂ R (2 * Complex.I) by
      rw [map_mul, map_ofNat], ← map_mul]
  congr 1
  linear_combination (-2 * ((‖v‖ ^ 2 : ℝ) : ℂ)) * Complex.I_mul_I

end BookProof.Bosonic
