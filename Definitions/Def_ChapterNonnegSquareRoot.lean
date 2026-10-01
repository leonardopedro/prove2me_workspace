import Mathlib


/-!
# The square root of an arbitrary non-negative self-adjoint linear relation

`BookProof.ChapterUnboundedPolar` constructs `|Ā| = (A* Ā)^{1/2}` and
`BookProof.ChapterPositiveSquareRootUnique` shows it is *the* non-negative
self-adjoint square root of `A* Ā`.  Both statements are about the particular
relation `factorRel A = A* Ā`.  This module removes that restriction:

> **Every non-negative self-adjoint linear relation `T` on a complex Hilbert
> space has a unique non-negative self-adjoint square root.**

The construction is the same bounded one, applied to the resolvent
`C = (1 + T)⁻¹ = invCLM hT`, which `ChapterPositiveSquareRootUnique` already
produces as an everywhere-defined positive contraction:

* `sqrtRel hT = {(C^{1/2} y, (1 − C)^{1/2} y) : y}` — formally
  `(1 − C)^{1/2} C^{−1/2} = ((C⁻¹ − 1))^{1/2} = T^{1/2}`;
* it is symmetric, `1 + T^{1/2}` is surjective, hence `T^{1/2}` is self-adjoint
  (`adjPairs_sqrtRel`), and it is non-negative
  (`isNonnegSelfAdjoint_sqrtRel`);
* **`(T^{1/2})² = T`** (`sqrtRel_comp_self`);
* **uniqueness** (`eq_sqrtRel_of_isNonnegSelfAdjoint`): if `S` is non-negative
  self-adjoint with `S S ⊆ T`, then `S = T^{1/2}`.  As in the special case, this
  is obtained from the *bounded* continuous functional calculus alone: with
  `C_S = (1 + S)⁻¹` one has the bounded identity
  `(1 + T)⁻¹ (1 − 2C_S + 2C_S²) = C_S²` (`invCLM_mul_den`), which on
  `spectrum C_S ⊆ [0,1]` says `(1 + T)⁻¹ = g(C_S)` for `g t = t²/(2t² − 2t + 1)`,
  and `g` is inverted there by `ψ r = √r/(√r + √(1−r))`, so
  `C_S = ψ((1 + T)⁻¹)` is determined by `T` alone.

`sqrtRel_unique_nonneg_sqrt` packages existence, the square, and uniqueness, and
`absRel_eq_sqrtRel` identifies the earlier `|Ā|` with `(A* Ā)^{1/2}` in this
sense.  Single-valuedness is inherited: if `T` is an operator, so is `T^{1/2}`
(`sqrtRel_snd_eq_zero_of_fst_eq_zero`).

Two further consequences are recorded.

* **The form of `T`.**  `D(T) ⊆ D(T^{1/2})` (`exists_mem_sqrtRel_of_mem`) and, for
  single-valued `T`, `⟪x, T x⟫ = ‖T^{1/2} x‖²` (`inner_eq_norm_sq_of_mem`,
  `norm_sq_eq_inner_of_mem`).
* **Commutation.**  A bounded operator commuting with `(1 + T)⁻¹` leaves both `T`
  and `T^{1/2}` invariant (`mem_of_commute`, `mem_sqrtRel_of_commute`).
* **The resolvent at every negative real.**  A positive real multiple `c T`
  (`smulRel`) of a non-negative self-adjoint relation is again one
  (`isNonnegSelfAdjoint_smulRel`, via `adjPairs_smulRel`), so the resolvent of
  `a⁻¹ T` gives, for every `a > 0`, an everywhere-defined bounded `(T + a)⁻¹`
  (`invCLMAt`) solving `a x + T x = h` uniquely (`invCLMAt_mem`,
  `invCLMAt_eq_of_mem`, `existsUnique_smul_add_mem`) with `‖(T + a)⁻¹‖ ≤ 1/a`
  (`norm_invCLMAt_le`): the spectrum of `T` misses the negative reals.
-/

namespace BookProof.NonnegSquareRoot

open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

/-! ## The construction -/

/-- `C^{1/2}` for the resolvent `C = (1 + T)⁻¹`. -/
noncomputable def sqrtB (hT : IsNonnegSelfAdjoint T) : F →L[ℂ] F := sqrtOp (invCLM hT)

/-- `(1 − C)^{1/2}` for the resolvent `C = (1 + T)⁻¹`. -/
noncomputable def sqrtC (hT : IsNonnegSelfAdjoint T) : F →L[ℂ] F := coSqrtOp (invCLM hT)

/-- **The square root `T^{1/2}`** of a non-negative self-adjoint linear relation,
as a linear relation: the set of pairs `(C^{1/2} y, (1 − C)^{1/2} y)`, where
`C = (1 + T)⁻¹`. -/
noncomputable def sqrtRel (hT : IsNonnegSelfAdjoint T) : Submodule ℂ (F × F) :=
  LinearMap.range ((sqrtB hT).toLinearMap.prod (sqrtC hT).toLinearMap)























/-! ## `T^{1/2}` is a non-negative self-adjoint relation -/













/-! ## `(T^{1/2})² = T` -/



/-! ## Uniqueness -/









/-! ## Single-valuedness is inherited -/





/-! ## The form of `T`: `⟪x, T x⟫ = ‖T^{1/2} x‖²` -/







/-! ## Commutation -/





/-! ## The resolvent at every negative real: `T + a` is boundedly invertible for `a > 0` -/

/-- Scaling of the second coordinate, `(x, z) ↦ (x, c z)`. -/
def smulSnd (c : ℝ) : (F × F) →ₗ[ℂ] (F × F) :=
  (LinearMap.fst ℂ F F).prod ((c : ℂ) • LinearMap.snd ℂ F F)



/-- The scaled relation `c T = {(x, c z) : (x, z) ∈ T}`, for a real scalar `c`. -/
def smulRel (c : ℝ) (T : Submodule ℂ (F × F)) : Submodule ℂ (F × F) := T.map (smulSnd c)

omit [CompleteSpace F] in
theorem mem_smulRel_iff {c : ℝ} (hc : c ≠ 0) {p : F × F} :
    p ∈ smulRel c T ↔ (p.1, ((c : ℂ))⁻¹ • p.2) ∈ T := by
  have hc' : (c : ℂ) ≠ 0 := by exact_mod_cast hc
  constructor
  · rintro ⟨q, hq, rfl⟩
    convert hq using 2
    rw [smulSnd_apply, smul_smul, inv_mul_cancel₀ hc', one_smul]
  · intro hp
    refine ⟨(p.1, ((c : ℂ))⁻¹ • p.2), hp, ?_⟩
    simp [smul_smul, mul_inv_cancel₀ hc']

omit [CompleteSpace F] in
theorem mem_smulRel {c : ℝ} {p : F × F} (hp : p ∈ T) : (p.1, (c : ℂ) • p.2) ∈ smulRel c T :=
  ⟨p, hp, rfl⟩

omit [CompleteSpace F] in
/-- The adjoint of a real multiple of a relation is that multiple of the adjoint. -/
theorem adjPairs_smulRel {c : ℝ} (hc : c ≠ 0) :
    adjPairs (smulRel c T) = smulRel c (adjPairs T) := by
  have hc' : (c : ℂ) ≠ 0 := by exact_mod_cast hc
  ext p
  rw [mem_smulRel_iff hc]
  constructor
  · intro hp q hq
    have h := hp _ (mem_smulRel (c := c) hq)
    simp only [inner_smul_left, inner_smul_right, Complex.conj_ofReal] at h ⊢
    field_simp at h ⊢
    linear_combination h
  · intro hp q hq
    obtain ⟨r, hr, rfl⟩ := hq
    have h := hp r hr
    simp only [smulSnd_apply, inner_smul_left, inner_smul_right, Complex.conj_ofReal] at h ⊢
    field_simp at h ⊢
    linear_combination h

omit [CompleteSpace F] in
/-- A positive multiple of a non-negative self-adjoint relation is again one. -/
theorem isNonnegSelfAdjoint_smulRel (hT : IsNonnegSelfAdjoint T) {c : ℝ} (hc : 0 < c) :
    IsNonnegSelfAdjoint (smulRel c T) where
  adj := by rw [adjPairs_smulRel hc.ne', hT.adj]
  nonneg := by
    rintro p ⟨q, hq, rfl⟩
    have h := hT.nonneg q hq
    simp only [smulSnd_apply, inner_smul_right, Complex.mul_re, Complex.ofReal_re,
      Complex.ofReal_im, zero_mul, sub_zero]
    positivity

section Shift

variable {a : ℝ}

omit [CompleteSpace F] in
/-- The non-negative self-adjoint relation `a⁻¹ T`, whose resolvent computes that of
`T + a`. -/
theorem isNonnegSelfAdjoint_invSmulRel (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) :
    IsNonnegSelfAdjoint (smulRel a⁻¹ T) :=
  isNonnegSelfAdjoint_smulRel hT (inv_pos.2 ha)

/-- **`(T + a)⁻¹` for `a > 0`**, an everywhere-defined bounded operator. -/
noncomputable def invCLMAt (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) : F →L[ℂ] F :=
  ((a : ℂ))⁻¹ • invCLM (isNonnegSelfAdjoint_invSmulRel hT ha)











end Shift

/-! ## The earlier `|Ā|` is `(A* Ā)^{1/2}` in this sense -/

variable {D : Submodule ℂ F}





end BookProof.NonnegSquareRoot
