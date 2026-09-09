import Mathlib
import BookProof.ChapterH4

/-!
# Chapter H5 — the inversion-free Krylov shortcut (plan Part F.1, roadmap §9.1)

`QFM.tex` §9.1 describes the dimensional reduction used by the Krylov–Hashimoto
generator.  The standard polynomial Krylov subspace is

  `Kry m(H̄, v₀) = span{v₀, H̄v₀, …, H̄^{m−1}v₀}`,

while the *rational* construction would need to solve `(γI − H̄)y = v` at every
step.  The observation of §9.1 is that pre-conditioning the seed removes the
inversion entirely: applying the resolvent to `v = (γI − H̄)^{m} v₀` merely
*lowers the polynomial degree*, and the shifted sequence
`wₖ = (H̄ − γI)wₖ₋₁`, `w₀ = v₀`, spans exactly the standard Krylov subspace.

## Deliverables

* `krylovSpan` and `krylov_subspace_span` — `Kry m(H̄, v₀)` is exactly the span of
  `{H̄^i v₀ | i < m}`, together with the basic monotonicity
  (`krylovSpan_mono`) and the invariance-step `krylovSpan_map_le`;
* `shift_pow_sub_pow_mem` — the degree-lowering core: `(H̄ − γI)^m v₀` differs
  from `H̄^m v₀` by an element of `Kry m(H̄, v₀)` (the shift only adds lower-order
  terms);
* `krylovSpan_shift_eq` — hence the shifted and unshifted Krylov subspaces
  coincide: `Kry m(H̄ − γI, v₀) = Kry m(H̄, v₀)`;
* `inversion_free_seed` — for the pre-conditioned seed `v = (γI − H̄)^{m+1} v₀`
  the resolvent image is `(γI − H̄)^{m} v₀`: applying `(γI − H̄)⁻¹` drops the
  polynomial degree by one, so no linear system is ever solved;
* `generator_bounded_of_rankOneProjector` — `H̄` is bounded: a rank-one projector
  contributes operator norm `≤ 1` and the diagonal part its own norm;
* `krylov_no_inversion_eq_standard` — **headline**: the inversion-free sequence
  `wₖ = (H̄ − γI)wₖ₋₁`, `w₀ = v₀` spans the full Krylov subspace
  `Kry m(H̄, v₀)`.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterH5

section Krylov

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

/-- The **Krylov subspace** `Kry m(H, v) = span{v, Hv, …, H^{m−1}v}`. -/
def krylovSpan (H : E →ₗ[K] E) (v : E) (m : ℕ) : Submodule K E :=
  Submodule.span K {x | ∃ i < m, x = (H ^ i) v}

variable {H : E →ₗ[K] E} {v : E}

/-- **F.1 (definition unfolded).**  `Kry m(H, v)` is exactly the span of the
first `m` powers of `H` applied to `v`. -/
theorem krylov_subspace_span (H : E →ₗ[K] E) (v : E) (m : ℕ) :
    krylovSpan H v m = Submodule.span K {x | ∃ i < m, x = (H ^ i) v} := rfl

theorem pow_apply_mem_krylovSpan {i m : ℕ} (hi : i < m) :
    (H ^ i) v ∈ krylovSpan H v m :=
  Submodule.subset_span ⟨i, hi, rfl⟩

theorem krylovSpan_mono {m n : ℕ} (hmn : m ≤ n) :
    krylovSpan H v m ≤ krylovSpan H v n :=
  Submodule.span_mono fun _ ⟨i, hi, hx⟩ => ⟨i, lt_of_lt_of_le hi hmn, hx⟩

theorem krylovSpan_zero : krylovSpan H v 0 = ⊥ := by
  rw [krylovSpan]
  convert Submodule.span_empty (R := K) (M := E)
  ext x
  simp

/-- Applying `H` moves `Kry m` into `Kry (m+1)`: the Krylov flag is an
`H`-invariance filtration. -/
theorem krylovSpan_map_le (m : ℕ) :
    Submodule.map H (krylovSpan H v m) ≤ krylovSpan H v (m + 1) := by
  rw [Submodule.map_le_iff_le_comap, krylovSpan]
  refine Submodule.span_le.mpr ?_
  rintro x ⟨i, hi, rfl⟩
  have : H ((H ^ i) v) = (H ^ (i + 1)) v := by
    rw [pow_succ']
    rfl
  have hx : H ((H ^ i) v) ∈ krylovSpan H v (m + 1) := by
    rw [this]
    exact pow_apply_mem_krylovSpan (Nat.succ_lt_succ hi)
  exact hx

/-- **The degree-lowering core.**  Shifting the generator by `γI` changes
`H^m v` only by lower-order Krylov terms: `(H − γI)^m v − H^m v ∈ Kry m(H, v)`. -/
theorem shift_pow_sub_pow_mem (H : E →ₗ[K] E) (γ : K) (v : E) (m : ℕ) :
    (((H - γ • 1) ^ m) v) - ((H ^ m) v) ∈ krylovSpan H v m := by
  induction m with
  | zero => simp
  | succ m ih =>
    set A : E →ₗ[K] E := H - γ • 1 with hA
    have hAstep : ((A ^ (m + 1)) v) = A ((A ^ m) v) := by
      rw [pow_succ']; rfl
    have hHstep : ((H ^ (m + 1)) v) = H ((H ^ m) v) := by
      rw [pow_succ']; rfl
    set w : E := ((A ^ m) v) - ((H ^ m) v) with hw
    have hwmem : w ∈ krylovSpan H v m := ih
    have hAeq : A ((A ^ m) v) = H ((H ^ m) v) + (H w - γ • ((A ^ m) v)) := by
      have hAapply : ∀ y : E, A y = H y - γ • y := by
        intro y; rw [hA]; simp
      rw [hAapply, hw]
      simp only [map_sub]
      abel
    rw [hAstep, hHstep, hAeq]
    have h1 : H w ∈ krylovSpan H v (m + 1) :=
      krylovSpan_map_le m ⟨w, hwmem, rfl⟩
    have h2 : ((A ^ m) v) ∈ krylovSpan H v (m + 1) := by
      have : ((A ^ m) v) = w + ((H ^ m) v) := by rw [hw]; abel
      rw [this]
      exact Submodule.add_mem _
        (krylovSpan_mono (Nat.le_succ m) hwmem)
        (pow_apply_mem_krylovSpan (Nat.lt_succ_self m))
    have : H ((H ^ m) v) + (H w - γ • ((A ^ m) v)) - H ((H ^ m) v)
        = H w - γ • ((A ^ m) v) := by abel
    rw [this]
    exact Submodule.sub_mem _ h1 (Submodule.smul_mem _ _ h2)

theorem krylovSpan_shift_le (H : E →ₗ[K] E) (γ : K) (v : E) (m : ℕ) :
    krylovSpan (H - γ • 1) v m ≤ krylovSpan H v m := by
  rw [krylovSpan]
  refine Submodule.span_le.mpr ?_
  rintro x ⟨i, hi, rfl⟩
  have hsplit : (((H - γ • 1) ^ i) v)
      = ((((H - γ • 1) ^ i) v) - ((H ^ i) v)) + ((H ^ i) v) := by abel
  rw [hsplit]
  exact Submodule.add_mem _
    (krylovSpan_mono (le_of_lt hi) (shift_pow_sub_pow_mem H γ v i))
    (pow_apply_mem_krylovSpan hi)

/-- **The shift does not change the Krylov subspace.**  `Kry m(H − γI, v)` and
`Kry m(H, v)` are the same subspace: shifting by a multiple of the identity is a
triangular change of the Krylov basis. -/
theorem krylovSpan_shift_eq (H : E →ₗ[K] E) (γ : K) (v : E) (m : ℕ) :
    krylovSpan (H - γ • 1) v m = krylovSpan H v m := by
  refine le_antisymm (krylovSpan_shift_le H γ v m) ?_
  have hback : (H - γ • 1) - (-γ) • (1 : E →ₗ[K] E) = H := by
    rw [neg_smul, sub_neg_eq_add, sub_add_cancel]
  have := krylovSpan_shift_le (H - γ • 1) (-γ) v m
  rwa [hback] at this

/-! ## The inversion-free seed -/

/-- **The pre-conditioned seed removes the inversion.**  If `R` is a left inverse
of the shifted generator `S = γI − H̄` and the seed is pre-conditioned as
`v = S^{m+1} v₀`, then `R v = S^{m} v₀`: applying the resolvent only *lowers the
polynomial degree*, so the rational Krylov sequence with uniform shifts never
solves a linear system. -/
theorem inversion_free_seed (S R : E →ₗ[K] E) (v₀ : E) (m : ℕ)
    (hR : R.comp S = LinearMap.id) :
    R ((S ^ (m + 1)) v₀) = (S ^ m) v₀ := by
  have hstep : ((S ^ (m + 1)) v₀) = S ((S ^ m) v₀) := by
    rw [pow_succ']; rfl
  rw [hstep]
  exact congrArg (fun f : E →ₗ[K] E => f ((S ^ m) v₀)) hR

/-! ## The inversion-free sequence -/

/-- The **inversion-free Krylov sequence** `w₀ = v₀`, `wₖ₊₁ = (H − γI)wₖ`: it uses
only applications of the generator, never a solve. -/
def noInversionSeq (H : E →ₗ[K] E) (γ : K) (v : E) : ℕ → E
  | 0 => v
  | (k + 1) => (H - γ • 1) (noInversionSeq H γ v k)

theorem noInversionSeq_eq (H : E →ₗ[K] E) (γ : K) (v : E) (k : ℕ) :
    noInversionSeq H γ v k = (((H - γ • 1) ^ k) v) := by
  induction k with
  | zero => simp [noInversionSeq]
  | succ k ih =>
    rw [noInversionSeq, ih, pow_succ']
    rfl

/-- **Headline (F.1).**  The inversion-free sequence `wₖ = (H̄ − γI)wₖ₋₁`,
`w₀ = v₀`, spans exactly the standard Krylov subspace `Kry m(H̄, v₀)` — the
rational construction with uniform shifts is recovered without ever inverting
`γI − H̄`. -/
theorem krylov_no_inversion_eq_standard (H : E →ₗ[K] E) (γ : K) (v : E) (m : ℕ) :
    Submodule.span K {x | ∃ i < m, x = noInversionSeq H γ v i} = krylovSpan H v m := by
  have hset : {x : E | ∃ i < m, x = noInversionSeq H γ v i}
      = {x : E | ∃ i < m, x = (((H - γ • 1) ^ i) v)} := by
    ext x
    constructor
    · rintro ⟨i, hi, rfl⟩; exact ⟨i, hi, noInversionSeq_eq H γ v i⟩
    · rintro ⟨i, hi, rfl⟩; exact ⟨i, hi, (noInversionSeq_eq H γ v i).symm⟩
  rw [hset]
  exact krylovSpan_shift_eq H γ v m

end Krylov

/-! ## Boundedness of the generator -/

section Bounded

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- The rank-one operator `x ↦ ⟪u, x⟫ u`. -/
def rankOneProj (u : E) : E →L[ℂ] E := (innerSL ℂ u).smulRight u

theorem norm_rankOneProj_le (u : E) : ‖rankOneProj u‖ ≤ ‖u‖ * ‖u‖ := by
  rw [rankOneProj, ContinuousLinearMap.norm_smulRight_apply, innerSL_apply_norm]

/-- **The Krylov generator is bounded.**  The Mehler projector contributes a
rank-one term of operator norm `≤ 1` (for a unit vector `u`) and the number
operators a diagonal term `D`, so `H̄ = P + D` is bounded by `1 + ‖D‖`.  This is
what justifies the finite-dimensional Krylov reduction. -/
theorem generator_bounded_of_rankOneProjector (u : E) (hu : ‖u‖ = 1) (D : E →L[ℂ] E) :
    ‖rankOneProj u + D‖ ≤ 1 + ‖D‖ := by
  refine le_trans (norm_add_le _ _) ?_
  have h := norm_rankOneProj_le u
  rw [hu] at h
  simpa using add_le_add_right (by simpa using h) ‖D‖

end Bounded

end BookProof.ChapterH5

end
