import Mathlib
import BookProof.ChapterH5

/-!
# Chapter SirkMultiShift — the multi-shift forward-sequence span identity

`CONSOLIDATED_PLAN.md` §12.2, **Gap 4b**: `ChapterH5` covers the *single*-shift
inversion-free shortcut (`krylov_no_inversion_eq_standard`: the sequence
`wₖ = (H̄ − γI)wₖ₋₁` spans the standard Krylov subspace).  The SIRK/Hashimoto
numerics use a *sequence of distinct complex shifts* `z₁, z₂, …`, i.e. the
forward sequence

  `w₀ = v₀`,  `wₖ₊₁ = (H̄ − zₖ I) wₖ`,

and the identity that the plan records as missing is

  `span{w₀, w₁, …, w_{m−1}} = Kry m(H̄, v₀)`.

That identity is proved here, together with the general principle behind it.

## Deliverables

* `triangularSpan_eq_krylovSpan` — the **general triangular criterion**: any
  family `u : ℕ → E` with `uᵢ − H^i v ∈ Kry i(H, v)` spans exactly the Krylov
  flag, `span{uᵢ | i < m} = Kry m(H, v)` for every `m`.  This isolates the only
  property a "forward sequence" needs: the change of basis from `{H^i v}` is
  unitriangular.
* `multiShiftSeq` — the multi-shift forward sequence `wₖ₊₁ = (H − zₖ I) wₖ`, for
  an arbitrary shift sequence `z : ℕ → K` (no distinctness, no non-vanishing, no
  field-characteristic hypothesis).
* `multiShiftSeq_sub_pow_mem` — the degree-lowering core: `wᵢ − H^i v ∈ Kry i`.
* `krylov_multiShift_eq_standard` — **headline (Gap 4b)**:
  `span{wᵢ | i < m} = Kry m(H, v)`.
* `krylov_multiShift_span_eq_of_shifts` — hence the span does not depend on the
  shift sequence at all: two different shift schedules produce the same
  subspace, so the numerics' choice of `{z_j}` changes the basis but never the
  Krylov space that is compressed.
* `multiShiftSeq_const` — the single-shift sequence of `ChapterH5` is the
  constant-schedule instance.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterSirkMultiShift

open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

/-! ## 1. The general triangular criterion -/

/-- The span of the first `m` members of a family `u : ℕ → E`. -/
def seqSpan (u : ℕ → E) (m : ℕ) : Submodule K E :=
  Submodule.span K {x | ∃ i < m, x = u i}

theorem mem_seqSpan (u : ℕ → E) {i m : ℕ} (hi : i < m) :
    u i ∈ seqSpan (K := K) u m :=
  Submodule.subset_span ⟨i, hi, rfl⟩

theorem seqSpan_mono (u : ℕ → E) {m n : ℕ} (hmn : m ≤ n) :
    seqSpan (K := K) u m ≤ seqSpan (K := K) u n :=
  Submodule.span_mono fun _ ⟨i, hi, hx⟩ => ⟨i, lt_of_lt_of_le hi hmn, hx⟩

variable {H : E →ₗ[K] E} {v : E}

/-- Every member of a triangular family lies in the Krylov flag. -/
theorem seqSpan_le_krylovSpan (u : ℕ → E)
    (hu : ∀ i, u i - (H ^ i) v ∈ krylovSpan H v i) (m : ℕ) :
    seqSpan (K := K) u m ≤ krylovSpan H v m := by
  refine Submodule.span_le.mpr ?_
  rintro x ⟨i, hi, rfl⟩
  have hsplit : u i = (u i - (H ^ i) v) + (H ^ i) v := by abel
  rw [hsplit]
  exact Submodule.add_mem _
    (krylovSpan_mono (le_of_lt hi) (hu i))
    (pow_apply_mem_krylovSpan hi)

/-- The converse inclusion, by strong induction on the exponent: `H^i v` is
recovered from `u i` and the strictly lower part of the flag. -/
theorem pow_mem_seqSpan (u : ℕ → E)
    (hu : ∀ i, u i - (H ^ i) v ∈ krylovSpan H v i) (i : ℕ) :
    (H ^ i) v ∈ seqSpan (K := K) u (i + 1) := by
  induction i using Nat.strong_induction_on with
  | _ i ih =>
    have hlow : krylovSpan H v i ≤ seqSpan (K := K) u (i + 1) := by
      refine Submodule.span_le.mpr ?_
      rintro x ⟨j, hj, rfl⟩
      exact seqSpan_mono u (by omega) (ih j hj)
    have h1 : u i ∈ seqSpan (K := K) u (i + 1) := mem_seqSpan u (Nat.lt_succ_self i)
    have h2 : u i - (H ^ i) v ∈ seqSpan (K := K) u (i + 1) := hlow (hu i)
    have : (H ^ i) v = u i - (u i - (H ^ i) v) := by abel
    rw [this]
    exact Submodule.sub_mem _ h1 h2

/-- **The general triangular criterion.**  A family whose change of basis from
the Krylov powers is unitriangular spans exactly the Krylov flag. -/
theorem triangularSpan_eq_krylovSpan (u : ℕ → E)
    (hu : ∀ i, u i - (H ^ i) v ∈ krylovSpan H v i) (m : ℕ) :
    seqSpan (K := K) u m = krylovSpan H v m := by
  refine le_antisymm (seqSpan_le_krylovSpan u hu m) ?_
  refine Submodule.span_le.mpr ?_
  rintro x ⟨i, hi, rfl⟩
  exact seqSpan_mono u (by omega) (pow_mem_seqSpan u hu i)

/-! ## 2. The multi-shift forward sequence -/

/-- The **multi-shift forward sequence** `w₀ = v`, `wₖ₊₁ = (H − zₖ I) wₖ`: the
inversion-free construction with a *schedule* of shifts, as used by the SIRK
numerics. -/
def multiShiftSeq (H : E →ₗ[K] E) (z : ℕ → K) (v : E) : ℕ → E
  | 0 => v
  | (k + 1) => (H - z k • 1) (multiShiftSeq H z v k)

@[simp] theorem multiShiftSeq_zero (H : E →ₗ[K] E) (z : ℕ → K) (v : E) :
    multiShiftSeq H z v 0 = v := rfl

theorem multiShiftSeq_succ (H : E →ₗ[K] E) (z : ℕ → K) (v : E) (k : ℕ) :
    multiShiftSeq H z v (k + 1) = H (multiShiftSeq H z v k) - z k • multiShiftSeq H z v k := by
  change (H - z k • 1) (multiShiftSeq H z v k) = _
  simp

/-- **The degree-lowering core, multi-shift form.**  Applying the shifted
generators only adds lower-order Krylov terms: `wᵢ − H^i v ∈ Kry i(H, v)`. -/
theorem multiShiftSeq_sub_pow_mem (H : E →ₗ[K] E) (z : ℕ → K) (v : E) (k : ℕ) :
    multiShiftSeq H z v k - (H ^ k) v ∈ krylovSpan H v k := by
  induction k with
  | zero => simp
  | succ k ih =>
    have hHstep : ((H ^ (k + 1)) v) = H ((H ^ k) v) := by rw [pow_succ']; rfl
    set d : E := multiShiftSeq H z v k - (H ^ k) v with hd
    have hdmem : d ∈ krylovSpan H v k := ih
    have hwmem : multiShiftSeq H z v k ∈ krylovSpan H v (k + 1) := by
      have : multiShiftSeq H z v k = d + (H ^ k) v := by rw [hd]; abel
      rw [this]
      exact Submodule.add_mem _
        (krylovSpan_mono (Nat.le_succ k) hdmem)
        (pow_apply_mem_krylovSpan (Nat.lt_succ_self k))
    have hHd : H d ∈ krylovSpan H v (k + 1) := krylovSpan_map_le k ⟨d, hdmem, rfl⟩
    have hrw : multiShiftSeq H z v (k + 1) - (H ^ (k + 1)) v
        = H d - z k • multiShiftSeq H z v k := by
      rw [multiShiftSeq_succ, hHstep, hd, map_sub]
      abel
    rw [hrw]
    exact Submodule.sub_mem _ hHd (Submodule.smul_mem _ _ hwmem)

/-- **Headline (Gap 4b).**  The multi-shift forward sequence
`w₀ = v₀`, `wₖ₊₁ = (H̄ − zₖ I) wₖ` spans exactly the standard Krylov subspace
`Kry m(H̄, v₀)`, for an arbitrary schedule of shifts. -/
theorem krylov_multiShift_eq_standard (H : E →ₗ[K] E) (z : ℕ → K) (v : E) (m : ℕ) :
    Submodule.span K {x | ∃ i < m, x = multiShiftSeq H z v i} = krylovSpan H v m :=
  triangularSpan_eq_krylovSpan (H := H) (v := v) (multiShiftSeq H z v)
    (multiShiftSeq_sub_pow_mem H z v) m

/-- **Shift-schedule independence.**  Two different schedules of shifts produce
the same subspace: the choice of `{z_j}` changes the basis in which the reduced
generator is written, never the space that is compressed. -/
theorem krylov_multiShift_span_eq_of_shifts (H : E →ₗ[K] E) (z z' : ℕ → K) (v : E) (m : ℕ) :
    Submodule.span K {x | ∃ i < m, x = multiShiftSeq H z v i}
      = Submodule.span K {x | ∃ i < m, x = multiShiftSeq H z' v i} := by
  rw [krylov_multiShift_eq_standard, krylov_multiShift_eq_standard]

/-- The single-shift sequence of `ChapterH5` is the constant-schedule instance of
the multi-shift one. -/
theorem multiShiftSeq_const (H : E →ₗ[K] E) (γ : K) (v : E) (k : ℕ) :
    multiShiftSeq H (fun _ => γ) v k = noInversionSeq H γ v k := by
  induction k with
  | zero => rfl
  | succ k ih => rw [multiShiftSeq, ih]; rfl

end BookProof.ChapterSirkMultiShift
