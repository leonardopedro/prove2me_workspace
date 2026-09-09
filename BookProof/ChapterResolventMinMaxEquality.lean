import Mathlib
import BookProof.ChapterResolventMinMaxLadder

/-!
# Chapter ResolventMinMaxEquality — the ladder inequality is an **equality** at every rung

`BookProof.ChapterResolventMinMaxLadder` compares the Courant–Fischer ladder of an
unbounded non-negative self-adjoint relation `T` with the ladder of its bounded resolvent
`R = (T + 1)⁻¹` read from the top, and proves

```text
1 / ν_k − 1 ≤ μ_k(T)          (`resolvent_ladder_lower`)
```

for every `k`, with equality at the bottom rung `k = 0`.  Its recorded honest boundary was
that the reverse inequality for `k ≥ 1` "needs spectral projections of `R`, which are not
developed here".  This chapter supplies them — reusing the functional-calculus toolkit of
`BookProof.ChapterMinMaxSpectrum` — and closes the boundary: the ladder of the unbounded
operator is **exactly** the transformed ladder of its resolvent.

## The argument

Fix `c` slightly below `ν_k` and let `q` be the continuous symbol that vanishes below
`c − δ` and equals `1` above `c` (the `cocutoff` of `ChapterMinMaxSpectrum`).  Two spectral
estimates carry the proof, both instances of the order-preservation `cfc_le_iff` of the
functional calculus:

* **on the range of `q(R)`** the operator inequality `(c − δ) R ≤ R²` holds, i.e.
  `(c − δ) ⟪x, Rx⟫ ≤ ‖Rx‖²` (`mul_rayleigh_le_normSq_of_mem_range`) — because `q` vanishes
  where `t < c − δ`;
* **on the kernel of `q(R)`** the Rayleigh quotient of `R` is at most `c`
  (`rayleighVal_le_of_cfc_eq_zero`) — because `t ≤ c + t q(t)` everywhere.

Now either the range of `q(R)` contains a `(k+1)`-dimensional subspace `S₀` — and then
`R S₀` is a `(k+1)`-dimensional subspace of the domain of `T` on which the Rayleigh quotient
of `T` is at most `1/(c − δ) − 1`, by the first estimate — or it does not, and then `q(R)`
kills a unit vector of *every* `(k+1)`-dimensional subspace, so by the second estimate every
competitor has `inf ≤ c`, giving `ν_k ≤ c`, which contradicts the choice of `c`.

## Deliverables

* `stepUp` and its elementary properties — the continuous `0/1` symbol at `[c − δ, c]`.
* `mul_rayleigh_le_normSq_of_mem_range`, `rayleighVal_le_of_cfc_eq_zero` — the two spectral
  estimates.
* `exists_unit_mem_ker_of_no_range_subspace` — the dimension dichotomy.
* **`graphMinmaxLevel_le`** — `graphMinmaxLevel T k ≤ 1 / maxminLevel R k − 1`.
* **`graphMinmaxLevel_eq`** — the ladder correspondence
  `graphMinmaxLevel T k = 1 / maxminLevel R k − 1` at **every** rung, and
  `graphMinmaxLevel_eq_of_spectrum` in terms of the spectrum of `R`.
* **`graphMinmax_gap_eq`** — hence the gap of `T`'s ladder is exactly `1/ν₁ − 1/ν₀`.

## Honest boundary

The statements assume that the rung exists (`graphMinmaxSet T k` is non-empty, which the
resolvent guarantees as soon as the space has dimension `k + 1`) and that the resolvent's
level is strictly positive, `0 < maxminLevel R k`; at `k = 0` positivity is automatic
(`maxminLevel_zero_pos`).  The relation is assumed single-valued, as in the previous
chapter.  Nothing here produces a gap for a particular Hamiltonian.
-/

noncomputable section

namespace BookProof.ResolventLadderEq

open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.MinMaxSpectrum
open BookProof.ResolventLadder
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-! ## 1. The continuous step symbol -/

/-- The continuous symbol that vanishes below `c − δ` and is `1` above `c`. -/
def stepUp (c δ : ℝ) : ℝ → ℝ := cocutoff (c - δ / 2) (δ / 2)

theorem stepUp_continuous (c δ : ℝ) : Continuous (stepUp c δ) := cocutoff_continuous _ _

theorem stepUp_eq_zero {c δ t : ℝ} (hδ : 0 < δ) (h : t ≤ c - δ) : stepUp c δ t = 0 := by
  have h1 : t ≤ c - δ / 2 - δ / 2 := by linarith
  rw [stepUp, cocutoff, cutoff_eq_one (by linarith) h1, sub_self]

theorem stepUp_eq_one {c δ t : ℝ} (hδ : 0 < δ) (h : c ≤ t) : stepUp c δ t = 1 := by
  have h1 : c - δ / 2 + δ / 2 ≤ t := by linarith
  rw [stepUp, cocutoff, cutoff_eq_zero (by linarith) h1, sub_zero]

theorem stepUp_nonneg (c δ t : ℝ) : 0 ≤ stepUp c δ t := by
  have h : cutoff (c - δ / 2) (δ / 2) t ≤ 1 := min_le_left _ _
  rw [stepUp, cocutoff]
  linarith

theorem stepUp_le_one (c δ t : ℝ) : stepUp c δ t ≤ 1 := by
  have h : 0 ≤ cutoff (c - δ / 2) (δ / 2) t := le_min (by norm_num) (le_max_left _ _)
  rw [stepUp, cocutoff]
  linarith

/-! ## 2. The two spectral estimates -/

/-- **On the range of `q(A)` the operator inequality `c A ≤ A²` holds.**  Concretely,
`c ⟪x, Ax⟫ ≤ ‖Ax‖²` for every `x` in the range of `cfc q A`, whenever
`c (t q(t)²) ≤ (t q(t))²` on the spectrum. -/
theorem mul_rayleigh_le_normSq_of_mem_range (A : F →L[ℂ] F) (hA : IsSelfAdjoint A)
    (q : ℝ → ℝ) (hq : Continuous q) (c : ℝ)
    (hbd : ∀ μ ∈ spectrum ℝ A, c * (μ * (q μ * q μ)) ≤ (μ * q μ) * (μ * q μ)) (y : F) :
    c * rayleighVal A (cfc q A y) ≤ ‖A (cfc q A y)‖ ^ 2 := by
  have hAB : cfc (fun t => c * (t * (q t * q t))) A
      ≤ cfc (fun t => (t * q t) * (t * q t)) A :=
    (cfc_le_iff _ _ A (by fun_prop) (by fun_prop) hA).mpr hbd
  have hkey := re_inner_mono_of_le hAB y
  have hL : (inner ℂ y ((cfc (fun t => c * (t * (q t * q t))) A) y) : ℂ).re
      = c * rayleighVal A (cfc q A y) := by
    rw [cfc_const_mul _ _ A (by fun_prop)]
    have h2 : (inner ℂ y ((c • cfc (fun t => t * (q t * q t)) A) y) : ℂ)
        = (c : ℂ) * inner ℂ y ((cfc (fun t => t * (q t * q t)) A) y) := by
      simp [ContinuousLinearMap.smul_apply]
    rw [h2, ← inner_range_eq A hA q hq y, Complex.re_ofReal_mul, rayleighVal]
  have hcfc : cfc (fun t : ℝ => t * q t) A = A * cfc q A := by
    rw [cfc_mul (fun t : ℝ => t) q A (by fun_prop) hq.continuousOn, cfc_id' ℝ A]
  have hR : (inner ℂ y ((cfc (fun t => (t * q t) * (t * q t)) A) y) : ℂ).re
      = ‖A (cfc q A y)‖ ^ 2 := by
    have h := norm_range_eq A (fun t : ℝ => t * q t) (by fun_prop) y
    rw [hcfc] at h
    rw [← h, Complex.ofReal_re]
    rfl
  rw [hL, hR] at hkey
  exact hkey

/-- **On the kernel of `q(A)` the Rayleigh quotient of `A` is at most `c`**, whenever
`t ≤ c + t q(t)` on the spectrum. -/
theorem rayleighVal_le_of_cfc_eq_zero (A : F →L[ℂ] F) (hA : IsSelfAdjoint A)
    (q : ℝ → ℝ) (hq : Continuous q) (c : ℝ)
    (hbd : ∀ μ ∈ spectrum ℝ A, μ ≤ c + μ * q μ) {x : F} (hx : cfc q A x = 0) :
    rayleighVal A x ≤ c * ‖x‖ ^ 2 := by
  have hle : cfc (fun t : ℝ => t) A ≤ cfc (fun t : ℝ => c + t * q t) A :=
    (cfc_le_iff _ _ A (by fun_prop) (by fun_prop) hA).mpr hbd
  rw [cfc_id' ℝ A, cfc_add A (fun _ : ℝ => c) (fun t : ℝ => t * q t) (by fun_prop) (by fun_prop),
    cfc_mul (fun t : ℝ => t) q A (by fun_prop) hq.continuousOn, cfc_id' ℝ A,
    cfc_const (R := ℝ) c A] at hle
  have hkey := re_inner_mono_of_le hle x
  have hval : ((algebraMap ℝ (F →L[ℂ] F)) c + A * cfc q A) x = (c : ℂ) • x := by
    simp [Algebra.algebraMap_eq_smul_one, hx]
  rw [hval, inner_smul_right, inner_self_eq_norm_sq_to_K] at hkey
  simpa [rayleighVal, ← Complex.ofReal_pow, ← Complex.ofReal_mul] using hkey

/-! ## 3. The dimension dichotomy -/

omit [CompleteSpace F] in
/-- If the range of a bounded operator contains no `(k+1)`-dimensional subspace, then the
operator kills a unit vector of **every** `(k+1)`-dimensional subspace. -/
theorem exists_unit_mem_ker_of_no_range_subspace (P : F →L[ℂ] F) {k : ℕ}
    (hex : ¬ ∃ S₀ : Submodule ℂ F,
      Module.finrank ℂ S₀ = k + 1 ∧ (S₀ : Set F) ⊆ Set.range P)
    {W : Submodule ℂ F} (hW : Module.finrank ℂ W = k + 1) :
    ∃ x ∈ W, ‖x‖ = 1 ∧ P x = 0 := by
  classical
  by_contra hcon
  push_neg at hcon
  -- no unit vector of `W` is killed, hence no non-zero vector is
  have hinj : Function.Injective ((P : F →ₗ[ℂ] F).domRestrict W) := by
    rw [← LinearMap.ker_eq_bot]
    refine (Submodule.eq_bot_iff _).mpr ?_
    rintro ⟨x, hxW⟩ hx
    have hPx : P x = 0 := by simpa using hx
    by_contra hne
    have hx0 : x ≠ 0 := by
      intro h
      exact hne (Subtype.ext (by simpa using h))
    have hnorm : ‖x‖ ≠ 0 := norm_ne_zero_iff.mpr hx0
    have hmem : (‖x‖⁻¹ : ℂ) • x ∈ W := W.smul_mem _ hxW
    have hunit : ‖(‖x‖⁻¹ : ℂ) • x‖ = 1 := by
      rw [norm_smul]
      simp [hnorm]
    have := hcon _ hmem hunit
    exact this (by rw [ContinuousLinearMap.map_smul, hPx, smul_zero])
  refine hex ⟨W.map (P : F →ₗ[ℂ] F), ?_, ?_⟩
  · have hrange : LinearMap.range ((P : F →ₗ[ℂ] F).domRestrict W) = W.map (P : F →ₗ[ℂ] F) :=
      LinearMap.range_domRestrict _ _
    rw [← hrange, LinearMap.finrank_range_of_inj hinj, hW]
  · rintro x hx
    obtain ⟨w, -, rfl⟩ := Submodule.mem_map.mp hx
    exact ⟨w, rfl⟩

/-! ## 4. The reverse ladder inequality -/

variable {T : Submodule ℂ (F × F)}

/-- **The reverse ladder inequality**: the min–max level of the unbounded relation is at
most the transformed level of its resolvent. -/
theorem graphMinmaxLevel_le (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (k : ℕ)
    (hne : (graphMinmaxSet T k).Nonempty)
    (hpos : 0 < maxminLevel (res hT) k) :
    graphMinmaxLevel T k ≤ 1 / maxminLevel (res hT) k - 1 := by
  classical
  set R : F →L[ℂ] F := res hT with hRdef
  set ν : ℝ := maxminLevel R k with hνdef
  have hRsa : IsSelfAdjoint R := res_isSelfAdjoint hT
  refine le_of_forall_pos_le_add fun η hη => ?_
  -- the parameters
  set ε : ℝ := min (ν / 3) (η * ν ^ 2 / 3) with hεdef
  have hεpos : 0 < ε := lt_min (by linarith) (by positivity)
  have hεν : ε ≤ ν / 3 := min_le_left _ _
  have hεη : ε ≤ η * ν ^ 2 / 3 := min_le_right _ _
  set c : ℝ := ν - ε with hcdef
  set δ : ℝ := ε / 2 with hδdef
  have hδpos : 0 < δ := by positivity
  have hc' : c - δ = ν - 3 * ε / 2 := by rw [hcdef, hδdef]; ring
  have hc'pos : 0 < c - δ := by rw [hc']; linarith
  have hcpos : 0 < c := by rw [hcdef]; linarith
  set q : ℝ → ℝ := stepUp c δ with hqdef
  have hqc : Continuous q := stepUp_continuous c δ
  have hq0 : ∀ t : ℝ, t ≤ c - δ → q t = 0 := fun t ht => stepUp_eq_zero hδpos ht
  have hq1 : ∀ t : ℝ, c ≤ t → q t = 1 := fun t ht => stepUp_eq_one hδpos ht
  have hqnn : ∀ t : ℝ, 0 ≤ q t := fun t => stepUp_nonneg c δ t
  set P : F →L[ℂ] F := cfc q R with hPdef
  by_cases hex : ∃ S₀ : Submodule ℂ F,
      Module.finrank ℂ S₀ = k + 1 ∧ (S₀ : Set F) ⊆ Set.range P
  · -- the spectral subspace above `c` is big enough: it supplies a competitor
    obtain ⟨S₀, hS₀rank, hS₀range⟩ := hex
    have hspec : ∀ μ ∈ spectrum ℝ R,
        (c - δ) * (μ * (q μ * q μ)) ≤ (μ * q μ) * (μ * q μ) := by
      intro μ _
      rcases eq_or_ne (q μ) 0 with h0 | h0
      · rw [h0]; ring_nf; rfl
      · have hμ : c - δ < μ := by
          by_contra hcon
          exact h0 (stepUp_eq_zero hδpos (by linarith [not_lt.mp hcon]))
        have hμ0 : 0 < μ := lt_trans hc'pos hμ
        have hsq : 0 ≤ q μ * q μ := mul_self_nonneg _
        nlinarith
    -- the competitor subspace inside the domain of `T`
    have hinjR : Function.Injective R := res_injective hT hsv
    have hmaprank : Module.finrank ℂ (S₀.map (R : F →ₗ[ℂ] F)) = k + 1 := by
      have hequiv : S₀ ≃ₗ[ℂ] (S₀.map (R : F →ₗ[ℂ] F)) :=
        Submodule.equivMapOfInjective _ hinjR S₀
      rw [← hequiv.finrank_eq, hS₀rank]
    have hdom : InDomain T (S₀.map (R : F →ₗ[ℂ] F)) := by
      rintro y hy
      obtain ⟨w, -, rfl⟩ := Submodule.mem_map.mp hy
      exact ⟨w - R w, res_mem hT w⟩
    have hvals : ∀ t ∈ graphRayleighSet T (S₀.map (R : F →ₗ[ℂ] F)), t ≤ 1 / (c - δ) - 1 := by
      rintro t ⟨y, z, hyz, hyS, hy1, rfl⟩
      obtain ⟨x, hxS₀, hxy⟩ := Submodule.mem_map.mp hyS
      have hy : R x = y := hxy
      have hz : z = x - y := by
        refine graph_unique hsv hyz ?_
        rw [← hy]
        exact res_mem hT x
      obtain ⟨w, hw⟩ := hS₀range hxS₀
      have hbound := mul_rayleigh_le_normSq_of_mem_range R hRsa q hqc (c - δ) hspec w
      rw [← hPdef, hw, hy, hy1] at hbound
      have hray : rayleighVal R x ≤ 1 / (c - δ) := by
        rw [le_div_iff₀ hc'pos]
        nlinarith [hbound]
      have hinner : (inner ℂ y z : ℂ).re = rayleighVal R x - 1 := by
        rw [hz, inner_sub_right, Complex.sub_re, inner_self_eq_norm_sq_to_K, hy1]
        have hyx : (inner ℂ y x : ℂ).re = rayleighVal R x := by
          rw [rayleighVal, ← hy, ← inner_conj_symm, Complex.conj_re]
        rw [hyx]
        norm_num
      rw [hinner]
      linarith
    have hsetne : (graphRayleighSet T (S₀.map (R : F →ₗ[ℂ] F))).Nonempty :=
      graphRayleighSet_nonempty (by rw [hmaprank]; omega) hdom
    have hsup : graphRayleighSup T (S₀.map (R : F →ₗ[ℂ] F)) ≤ 1 / (c - δ) - 1 :=
      csSup_le hsetne hvals
    have hlow : graphMinmaxLevel T k ≤ graphRayleighSup T (S₀.map (R : F →ₗ[ℂ] F)) :=
      csInf_le (graphMinmaxSet_bddBelow hT k) ⟨_, hmaprank, hdom, rfl⟩
    -- arithmetic: `1/(ν − 3ε/2) ≤ 1/ν + η`
    have harith : 1 / (c - δ) ≤ 1 / ν + η := by
      rw [hc', div_add' _ _ _ (ne_of_gt hpos), div_le_div_iff₀ (by rw [← hc']; exact hc'pos) hpos]
      nlinarith
    linarith
  · -- otherwise the resolvent's level would be at most `c`
    exfalso
    have hspec2 : ∀ μ ∈ spectrum ℝ R, μ ≤ c + μ * q μ := by
      intro μ _
      rcases le_or_gt μ c with hμ | hμ
      · have hnn : 0 ≤ μ * q μ := by
          rcases le_or_gt 0 μ with h | h
          · exact mul_nonneg h (hqnn μ)
          · rw [hq0 μ (by linarith), mul_zero]
        linarith
      · rw [hq1 μ hμ.le, mul_one]
        linarith
    have hle : ν ≤ c := by
      have hmaxne : (maxminSet R k).Nonempty := by
        obtain ⟨t, S, hrank, -, -⟩ := hne
        exact ⟨rayleighInfOn R S, S, hrank, rfl⟩
      refine csSup_le hmaxne ?_
      rintro t ⟨W, hWrank, rfl⟩
      obtain ⟨x, hxW, hx1, hx0⟩ :=
        exists_unit_mem_ker_of_no_range_subspace P hex hWrank
      have hx0' : cfc q R x = 0 := by rw [← hPdef]; exact hx0
      have hray := rayleighVal_le_of_cfc_eq_zero R hRsa q hqc c hspec2 hx0'
      rw [hx1] at hray
      refine csInf_le_of_le (rayleighSetOn_bddBelow R W) (b := rayleighVal R x)
        ⟨x, hxW, hx1, rfl⟩ ?_
      simpa using hray
    rw [hcdef] at hle
    linarith

/-! ## 5. The ladder correspondence -/

/-- **The ladder correspondence.**  Every rung of the Courant–Fischer ladder of the
unbounded non-negative self-adjoint relation `T` is the transformed rung of the ladder of
its bounded resolvent, read from the top. -/
theorem graphMinmaxLevel_eq (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (k : ℕ)
    (hne : (graphMinmaxSet T k).Nonempty)
    (hpos : 0 < maxminLevel (res hT) k) :
    graphMinmaxLevel T k = 1 / maxminLevel (res hT) k - 1 :=
  le_antisymm (graphMinmaxLevel_le hT hsv k hne hpos) (resolvent_ladder_lower hT hsv k hne)

/-- **The gap of the ladder of `T` is exactly the transformed gap of the resolvent's.** -/
theorem graphMinmax_gap_eq [Nontrivial F] (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0)
    (hne : (graphMinmaxSet T 1).Nonempty)
    (hpos : 0 < maxminLevel (res hT) 1) :
    graphMinmaxLevel T 1 - graphMinmaxLevel T 0
      = 1 / maxminLevel (res hT) 1 - 1 / maxminLevel (res hT) 0 := by
  rw [graphMinmaxLevel_eq hT hsv 1 hne hpos, graphMinmaxLevel_zero_eq hT hsv]
  ring

end BookProof.ResolventLadderEq

end
