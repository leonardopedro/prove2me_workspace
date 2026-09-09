import Mathlib
import BookProof.ChapterStoneResolvent

/-!
# The Cayley transform of an unbounded self-adjoint operator

`BookProof.ChapterStoneResolvent` builds the resolvents `(A - i l)⁻¹` of a
densely defined self-adjoint operator `A` (the bundle
`UnboundedSelfAdjoint`).  This module uses them to construct the **Cayley
transform**

`V = (A - i)(A + i)⁻¹`,

the standard device that trades an unbounded self-adjoint operator for a
*bounded* — indeed unitary — one, and which is the usual entry point to the
spectral theorem in the unbounded case.

* `cayleyMap` / `cayley` — the transform, first as a linear map and then, after
  `norm_cayleyMap` (isometry) and `cayleyMap_surjective`, as a **unitary**
  `H ≃ₗᵢ[ℂ] H`;
* `cayley_shift` — the defining relation `V (A + i)ψ = (A - i)ψ`;
* `sub_cayley_shift` / `add_cayley_shift` — `(1 - V)(A + i)ψ = 2iψ` and
  `(1 + V)(A + i)ψ = 2Aψ`;
* `one_sub_cayley_injective`, `cayley_apply_ne_self`,
  `range_one_sub_cayley` (`ran(1 - V) = D(A)`) and
  `denseRange_one_sub_cayley` — `1` is not an eigenvalue of `V` and `1 - V` has
  dense range, the two conditions characterising the Cayley transforms of
  self-adjoint operators;
* `op_eq_cayley` / `coe_eq_cayley` — the **reconstruction** `A = i(1 + V)(1 - V)⁻¹`
  in the pointwise form `Aψ = ½(y + Vy)`, `ψ = -(i/2)(y - Vy)` with `y = (A + i)ψ`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open scoped InnerProductSpace
open Filter Topology

namespace BookProof.ChapterCayleyTransform

open BookProof.ChapterUnitaryTransport BookProof.ChapterStoneResolvent

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : UnboundedSelfAdjoint H)

/-! ## `A + i` and `A - i` have the same norm -/

omit [CompleteSpace H] in
/-- The Pythagoras identity makes `‖(A - i)ψ‖` and `‖(A + i)ψ‖` equal: both equal
`‖Aψ‖² + ‖ψ‖²`. -/
theorem norm_shift_one_eq_norm_shift_neg_one (x : T.domain) :
    ‖T.shift 1 x‖ = ‖T.shift (-1) x‖ := by
  have h1 := T.norm_shift_sq 1 x
  have h2 := T.norm_shift_sq (-1) x
  have hsq : ‖T.shift 1 x‖ ^ 2 = ‖T.shift (-1) x‖ ^ 2 := by
    rw [h1, h2]; norm_num
  have hroot := congrArg Real.sqrt hsq
  rwa [Real.sqrt_sq (norm_nonneg _), Real.sqrt_sq (norm_nonneg _)] at hroot

/-! ## The transform -/

/-- The **Cayley transform** `V = (A - i)(A + i)⁻¹`, as a linear map. -/
noncomputable def cayleyMap : H →ₗ[ℂ] H := (T.shift 1).comp (T.res (-1))

theorem cayleyMap_apply (y : H) : cayleyMap T y = T.shift 1 (T.res (-1) y) := rfl

/-- The defining relation of the Cayley transform: `V (A + i)ψ = (A - i)ψ`. -/
theorem cayleyMap_shift (x : T.domain) : cayleyMap T (T.shift (-1) x) = T.shift 1 x := by
  rw [cayleyMap_apply, T.res_shift (by norm_num)]

theorem norm_cayleyMap (y : H) : ‖cayleyMap T y‖ = ‖y‖ := by
  have hy : T.shift (-1) (T.res (-1) y) = y := T.shift_res (by norm_num) y
  rw [cayleyMap_apply, norm_shift_one_eq_norm_shift_neg_one, hy]

theorem cayleyMap_surjective : Function.Surjective (cayleyMap T) := by
  intro z
  refine ⟨T.shift (-1) (T.res 1 z), ?_⟩
  rw [cayleyMap_shift, T.shift_res (by norm_num)]

/-- The Cayley transform of a self-adjoint operator is **unitary**. -/
noncomputable def cayley : H ≃ₗᵢ[ℂ] H :=
  LinearIsometryEquiv.ofSurjective ⟨cayleyMap T, norm_cayleyMap T⟩ (cayleyMap_surjective T)

@[simp] theorem cayley_apply (y : H) : cayley T y = cayleyMap T y := rfl

/-- `V (A + i)ψ = (A - i)ψ`. -/
theorem cayley_shift (x : T.domain) : cayley T (T.shift (-1) x) = T.shift 1 x :=
  cayleyMap_shift T x

/-! ## `1 - V` and `1 + V` -/

/-- `(1 - V)(A + i)ψ = 2iψ`. -/
theorem sub_cayley_shift (x : T.domain) :
    T.shift (-1) x - cayley T (T.shift (-1) x) = (2 * Complex.I) • (x : H) := by
  rw [cayley_shift, T.shift_apply, T.shift_apply]
  push_cast
  module

/-- `(1 + V)(A + i)ψ = 2Aψ`. -/
theorem add_cayley_shift (x : T.domain) :
    T.shift (-1) x + cayley T (T.shift (-1) x) = (2 : ℂ) • T.op x := by
  rw [cayley_shift, T.shift_apply, T.shift_apply]
  push_cast
  module

/-- `1 - V` is injective: `1` is not an eigenvalue of the Cayley transform. -/
theorem one_sub_cayley_injective :
    Function.Injective (fun y : H => y - cayley T y) := by
  intro y z hyz
  obtain ⟨x, rfl⟩ : ∃ x : T.domain, T.shift (-1) x = y :=
    ⟨T.res (-1) y, T.shift_res (by norm_num) y⟩
  obtain ⟨w, rfl⟩ : ∃ w : T.domain, T.shift (-1) w = z :=
    ⟨T.res (-1) z, T.shift_res (by norm_num) z⟩
  simp only [sub_cayley_shift] at hyz
  have h2 : (2 * Complex.I : ℂ) ≠ 0 := by simp [Complex.I_ne_zero]
  have hx : (x : H) = (w : H) := by
    have := congrArg (fun v => (2 * Complex.I : ℂ)⁻¹ • v) hyz
    simpa [smul_smul, inv_mul_cancel₀ h2] using this
  rw [Subtype.ext hx]

/-- `1` is not an eigenvalue of `V`. -/
theorem cayley_apply_ne_self {y : H} (hy : y ≠ 0) : cayley T y ≠ y := by
  intro h
  refine hy (one_sub_cayley_injective T (show y - cayley T y = 0 - cayley T 0 by simp [h]))

/-- The range of `1 - V` is exactly the domain of `A`. -/
theorem range_one_sub_cayley :
    Set.range (fun y : H => y - cayley T y) = (T.domain : Set H) := by
  ext v
  constructor
  · rintro ⟨y, rfl⟩
    obtain ⟨x, rfl⟩ : ∃ x : T.domain, T.shift (-1) x = y :=
      ⟨T.res (-1) y, T.shift_res (by norm_num) y⟩
    change T.shift (-1) x - cayley T (T.shift (-1) x) ∈ (T.domain : Set H)
    rw [sub_cayley_shift]
    exact T.domain.smul_mem _ x.2
  · intro hv
    refine ⟨T.shift (-1) ((2 * Complex.I : ℂ)⁻¹ • (⟨v, hv⟩ : T.domain)), ?_⟩
    have h2 : (2 * Complex.I : ℂ) ≠ 0 := by simp [Complex.I_ne_zero]
    change T.shift (-1) ((2 * Complex.I : ℂ)⁻¹ • (⟨v, hv⟩ : T.domain))
        - cayley T (T.shift (-1) ((2 * Complex.I : ℂ)⁻¹ • (⟨v, hv⟩ : T.domain))) = v
    rw [sub_cayley_shift, Submodule.coe_smul, smul_smul, mul_inv_cancel₀ h2, one_smul]

/-- `1 - V` has dense range, because the domain of `A` is dense. -/
theorem denseRange_one_sub_cayley :
    DenseRange (fun y : H => y - cayley T y) := by
  rw [DenseRange, range_one_sub_cayley]
  exact T.denseDomain

/-! ## Reconstruction: `A = i(1 + V)(1 - V)⁻¹` -/

/-- Reconstruction of the operator from its Cayley transform: with
`y = (A + i)ψ` one has `Aψ = ½(y + Vy)`. -/
theorem op_eq_cayley (x : T.domain) :
    T.op x = (2 : ℂ)⁻¹ • (T.shift (-1) x + cayley T (T.shift (-1) x)) := by
  rw [add_cayley_shift, smul_smul]
  norm_num

/-- Reconstruction of the vector: with `y = (A + i)ψ` one has
`ψ = -(i/2)(y - Vy)`, so that `A = i(1 + V)(1 - V)⁻¹`. -/
theorem coe_eq_cayley (x : T.domain) :
    (x : H) = (-(Complex.I / 2)) • (T.shift (-1) x - cayley T (T.shift (-1) x)) := by
  rw [sub_cayley_shift, smul_smul]
  have : (-(Complex.I / 2)) * (2 * Complex.I) = 1 := by
    linear_combination -Complex.I_sq
  rw [this, one_smul]

end BookProof.ChapterCayleyTransform
