import Mathlib
import BookProof.ChapterFockInteractionStability

/-!
# Chapter FockFieldPerturbation — an *unbounded* number-changing perturbation

`CONSOLIDATED_PLAN.md`, status update 2026-08-28c, records the exact boundary reached by
`ChapterFockInteractionStability`: a gap survives an arbitrary **bounded** number-changing
perturbation, and the relatively-form-bounded statement
`gap_persists_of_relative_form_bound` is "the shape in which a claim for an unbounded
interaction could be made, but supplying the domination `|v| ≤ a q + b‖·‖²` for the physical
interaction is not done here".

This chapter supplies such a domination for a genuinely unbounded, genuinely
number-changing operator: the **field operator**

  `Φ(f) = a†(f) + a(f)`,

the linear (Yukawa-type) coupling of the Fock field to a one-particle vector `f`.  `Φ(f)` is
not a bounded operator on Fock space (`fieldVec_unbounded`) and it does not commute with the
number operator (`fieldVec_vac`), so neither the bounded corollaries of
`ChapterFockInteractionStability` nor the number-preserving lift of
`ChapterFockNumberPreservingGap` applies to it.

## Deliverables

* `annVec` — the annihilation operator `a(f) = Σ_j conj(f_j) a_j` of a one-particle vector,
  adjoint to the project's `creVec` (`inner_creVec_annVec`);
* `numberQuad` — the number quadratic form `⟪u, N u⟫`, and `numberQuad_eq_sum`:
  `⟪u, N u⟫ = Σ_k ‖a_k u‖²`;
* **`norm_annVec_le`** — the `N^{1/2}` estimate `‖a(f) u‖ ≤ ‖f‖ ⟪u, N u⟫^{1/2}`, by
  Cauchy–Schwarz over the modes;
* **`abs_re_inner_fieldVec_le`** — `|Re⟪u, Φ(f) u⟫| ≤ 2‖f‖ ⟪u, N u⟫^{1/2}‖u‖`;
* **`fieldVec_relative_form_bound`** — the domination the plan asks for:
  `|Re⟪u, Φ(f) u⟫| ≤ (t/μ)·Re⟪u, dΓ(h) u⟫ + (‖f‖²/t)‖u‖²` for every `t > 0`, whenever the
  one-particle Hamiltonian satisfies `h − μ ≥ 0` with `μ > 0`;
* **`fock_gap_of_field_perturbation`** — the conclusion: with a one-particle gap `h ≥ μ` and
  `‖f‖ ≤ μ`, every vacuum-orthogonal finite-particle state has `dΓ(h) + Φ(f)` energy at
  least `(μ − 2‖f‖)‖u‖²`; `fock_gap_of_field_perturbation_pos` records when this is
  strictly positive;
* `fieldVec_unbounded` — `Φ(f)` really is unbounded, so this is not a corollary of the
  bounded theory.

## Honest boundary

`Φ(f)` is linear in the creation/annihilation operators; it changes the particle number by
one.  Yang–Mills interaction terms are cubic and quartic in the field and are *not* covered
by this chapter.  What is proved is that the certificate chain's one-particle gap survives a
concrete unbounded number-changing coupling, quantitatively, with the explicit smallness
condition `2‖f‖ < μ`.  `1.932` remains a certified truncated number; no mass gap of the
physical Hamiltonian is claimed.

Everything is `sorry`-free and introduces no axioms.
-/

noncomputable section

namespace BookProof.FockFieldPerturbation

open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

/-! ## 1. The annihilation operator of a one-particle vector -/

/-- The `ℓ²` norm of a finitely supported one-particle vector. -/
def l2norm (f : ℕ →₀ ℂ) : ℝ := Real.sqrt (∑ j ∈ f.support, ‖f j‖ ^ 2)

/-- **The annihilation operator** `a(f) = Σ_j conj(f_j) a_j` of a one-particle vector `f`,
the adjoint of the project's creation operator `creVec f = a†(f)`. -/
def annVec (f : ℕ →₀ ℂ) : FockAlg →ₗ[ℂ] FockAlg :=
  ∑ j ∈ f.support, ((starRingEnd ℂ) (f j)) • annA j

/-- **The field operator** `Φ(f) = a†(f) + a(f)`. -/
def fieldVec (f : ℕ →₀ ℂ) : FockAlg →ₗ[ℂ] FockAlg := creVec f + annVec f

/-- The number quadratic form `⟪u, N u⟫`. -/
def numberQuad (u : FockAlg) : ℝ :=
  (inner ℂ (toLp u) (toLp (dGamma numberCol u)) : ℂ).re

theorem annVec_apply (f : ℕ →₀ ℂ) (x : FockAlg) :
    annVec f x = ∑ j ∈ f.support, ((starRingEnd ℂ) (f j)) • annA j x := by
  simp [annVec, LinearMap.sum_apply]

theorem fieldVec_apply (f : ℕ →₀ ℂ) (x : FockAlg) :
    fieldVec f x = creVec f x + annVec f x := rfl

theorem l2norm_nonneg (f : ℕ →₀ ℂ) : 0 ≤ l2norm f := Real.sqrt_nonneg _

theorem l2norm_eq_zero {f : ℕ →₀ ℂ} (h : l2norm f = 0) : f = 0 := by
  classical
  have hsum : ∑ j ∈ f.support, ‖f j‖ ^ 2 = 0 := by
    have hnn : 0 ≤ ∑ j ∈ f.support, ‖f j‖ ^ 2 :=
      Finset.sum_nonneg fun j _ => sq_nonneg _
    exact (Real.sqrt_eq_zero hnn).mp h
  refine Finsupp.ext fun j => ?_
  by_cases hj : j ∈ f.support
  · have hzero : ‖f j‖ ^ 2 = 0 :=
      (Finset.sum_eq_zero_iff_of_nonneg (fun i _ => sq_nonneg _)).mp hsum j hj
    have : ‖f j‖ = 0 := by nlinarith [norm_nonneg (f j)]
    simpa using this
  · simpa using Finsupp.notMem_support_iff.mp hj

/-! ## 2. The number form is the sum of the mode annihilations -/

theorem creVec_numberCol (k : ℕ) (x : FockAlg) : creVec (numberCol k) x = creA k x := by
  rw [numberCol, creVec_diagCol]
  simp

/-- **`⟪u, N u⟫ = Σ_k ‖a_k u‖²`** over any finite set of modes containing those of `u`. -/
theorem numberQuad_eq_sum {u : FockAlg} {K : Finset ℕ} (hK : modes u ⊆ K) :
    numberQuad u = ∑ k ∈ K, ‖toLp (annA k u)‖ ^ 2 := by
  have hsum : dGamma numberCol u = ∑ k ∈ K, creA k (annA k u) := by
    rw [dGamma_eq_sum numberCol hK]
    exact Finset.sum_congr rfl fun k _ => creVec_numberCol k _
  have htoLp : toLp (∑ k ∈ K, creA k (annA k u)) = ∑ k ∈ K, toLp (creA k (annA k u)) := by
    rw [← toLpL_apply, map_sum]
    rfl
  rw [numberQuad, hsum, htoLp, inner_sum, Complex.re_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [inner_creA_right, inner_self_eq_norm_sq_to_K]
  norm_cast

theorem numberQuad_nonneg (u : FockAlg) : 0 ≤ numberQuad u := by
  rw [numberQuad_eq_sum (K := modes u) subset_rfl]
  exact Finset.sum_nonneg fun k _ => sq_nonneg _

/-- Every partial sum of the mode annihilations is bounded by the number form. -/
theorem sum_sq_annA_le (u : FockAlg) (S : Finset ℕ) :
    ∑ k ∈ S, ‖toLp (annA k u)‖ ^ 2 ≤ numberQuad u := by
  classical
  rw [numberQuad_eq_sum (K := S ∪ modes u) Finset.subset_union_right]
  exact Finset.sum_le_sum_of_subset_of_nonneg Finset.subset_union_left
    fun _ _ _ => sq_nonneg _

/-! ## 3. The `N^{1/2}` estimate -/

/-- **The `N^{1/2}` estimate** `‖a(f) u‖ ≤ ‖f‖ ⟪u, N u⟫^{1/2}`, by Cauchy–Schwarz over the
modes.  This is the estimate that makes an unbounded field operator relatively form
bounded. -/
theorem norm_annVec_le (f : ℕ →₀ ℂ) (u : FockAlg) :
    ‖toLp (annVec f u)‖ ≤ l2norm f * Real.sqrt (numberQuad u) := by
  classical
  have hexp : toLp (annVec f u)
      = ∑ j ∈ f.support, ((starRingEnd ℂ) (f j)) • toLp (annA j u) := by
    rw [annVec_apply, ← toLpL_apply, map_sum]
    exact Finset.sum_congr rfl fun j _ => by rw [map_smul, toLpL_apply]
  rw [hexp]
  calc ‖∑ j ∈ f.support, ((starRingEnd ℂ) (f j)) • toLp (annA j u)‖
      ≤ ∑ j ∈ f.support, ‖((starRingEnd ℂ) (f j)) • toLp (annA j u)‖ := norm_sum_le _ _
    _ = ∑ j ∈ f.support, ‖f j‖ * ‖toLp (annA j u)‖ := by
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [norm_smul]
        simp
    _ ≤ Real.sqrt (∑ j ∈ f.support, ‖f j‖ ^ 2)
          * Real.sqrt (∑ j ∈ f.support, ‖toLp (annA j u)‖ ^ 2) :=
        Real.sum_mul_le_sqrt_mul_sqrt _ _ _
    _ ≤ l2norm f * Real.sqrt (numberQuad u) :=
        mul_le_mul_of_nonneg_left (Real.sqrt_le_sqrt (sum_sq_annA_le u f.support))
          (l2norm_nonneg f)

/-- `a(f)` is adjoint to `a†(f)`: `⟪u, a†(f) v⟫ = ⟪a(f) u, v⟫`. -/
theorem inner_creVec_annVec (f : ℕ →₀ ℂ) (u v : FockAlg) :
    (inner ℂ (toLp u) (toLp (creVec f v)) : ℂ) = inner ℂ (toLp (annVec f u)) (toLp v) := by
  classical
  have hc : toLp (creVec f v) = ∑ j ∈ f.support, (f j) • toLp (creA j v) := by
    rw [creVec_apply, ← toLpL_apply, map_sum]
    exact Finset.sum_congr rfl fun j _ => by rw [map_smul, toLpL_apply]
  have ha : toLp (annVec f u)
      = ∑ j ∈ f.support, ((starRingEnd ℂ) (f j)) • toLp (annA j u) := by
    rw [annVec_apply, ← toLpL_apply, map_sum]
    exact Finset.sum_congr rfl fun j _ => by rw [map_smul, toLpL_apply]
  rw [hc, ha, inner_sum, sum_inner]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [inner_smul_right, inner_smul_left, inner_creA_right]
  simp

/-- **The field form estimate** `|Re⟪u, Φ(f) u⟫| ≤ 2‖f‖ ⟪u, N u⟫^{1/2}‖u‖`. -/
theorem abs_re_inner_fieldVec_le (f : ℕ →₀ ℂ) (u : FockAlg) :
    |(inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re|
      ≤ 2 * l2norm f * Real.sqrt (numberQuad u) * ‖toLp u‖ := by
  have hsplit : (inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ)
      = inner ℂ (toLp u) (toLp (creVec f u)) + inner ℂ (toLp u) (toLp (annVec f u)) := by
    have hadd := map_add toLpL (creVec f u) (annVec f u)
    simp only [toLpL_apply] at hadd
    rw [fieldVec_apply, hadd, inner_add_right]
  have hbound : ‖toLp (annVec f u)‖ * ‖toLp u‖
      ≤ l2norm f * Real.sqrt (numberQuad u) * ‖toLp u‖ :=
    mul_le_mul_of_nonneg_right (norm_annVec_le f u) (norm_nonneg _)
  have h1 : |(inner ℂ (toLp u) (toLp (creVec f u)) : ℂ).re|
      ≤ l2norm f * Real.sqrt (numberQuad u) * ‖toLp u‖ := by
    rw [inner_creVec_annVec]
    calc |(inner ℂ (toLp (annVec f u)) (toLp u) : ℂ).re|
        ≤ ‖(inner ℂ (toLp (annVec f u)) (toLp u) : ℂ)‖ := Complex.abs_re_le_norm _
      _ ≤ ‖toLp (annVec f u)‖ * ‖toLp u‖ := norm_inner_le_norm _ _
      _ ≤ _ := hbound
  have h2 : |(inner ℂ (toLp u) (toLp (annVec f u)) : ℂ).re|
      ≤ l2norm f * Real.sqrt (numberQuad u) * ‖toLp u‖ := by
    calc |(inner ℂ (toLp u) (toLp (annVec f u)) : ℂ).re|
        ≤ ‖(inner ℂ (toLp u) (toLp (annVec f u)) : ℂ)‖ := Complex.abs_re_le_norm _
      _ ≤ ‖toLp u‖ * ‖toLp (annVec f u)‖ := norm_inner_le_norm _ _
      _ = ‖toLp (annVec f u)‖ * ‖toLp u‖ := mul_comm _ _
      _ ≤ _ := hbound
  rw [hsplit, Complex.add_re]
  calc |(inner ℂ (toLp u) (toLp (creVec f u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (annVec f u)) : ℂ).re|
      ≤ |(inner ℂ (toLp u) (toLp (creVec f u)) : ℂ).re|
        + |(inner ℂ (toLp u) (toLp (annVec f u)) : ℂ).re| := abs_add_le _ _
    _ ≤ 2 * l2norm f * Real.sqrt (numberQuad u) * ‖toLp u‖ := by linarith

/-! ## 4. The relative form bound -/

/-- The elementary Young inequality behind the relative bound. -/
theorem two_mul_sqrt_le {c n N t : ℝ} (hN : 0 ≤ N) (ht : 0 < t) :
    2 * c * Real.sqrt N * n ≤ t * N + c ^ 2 / t * n ^ 2 := by
  have key : ∀ s : ℝ, 2 * c * s * n ≤ t * s ^ 2 + c ^ 2 / t * n ^ 2 := by
    intro s
    rw [← sub_nonneg]
    have hid : t * s ^ 2 + c ^ 2 / t * n ^ 2 - 2 * c * s * n
        = (t * s - c * n) ^ 2 / t := by
      field_simp
      ring
    rw [hid]
    positivity
  have h := key (Real.sqrt N)
  rwa [Real.sq_sqrt hN] at h

/-- The one-particle gap `h − μ ≥ 0` bounds the number form by the free energy:
`μ⟪u, N u⟫ ≤ Re⟪u, dΓ(h) u⟫`. -/
theorem number_le_dGamma_quadForm {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ}
    (hgap : IsPosCol (shiftCol col mu)) (u : FockAlg) :
    mu * numberQuad u ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re := by
  have hsplit : (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ)
      = inner ℂ (toLp u) (toLp (dGamma (shiftCol col mu) u))
        + ((mu : ℝ) : ℂ) * inner ℂ (toLp u) (toLp (dGamma numberCol u)) := by
    have hcol : dGamma col u
        = dGamma (shiftCol col mu) u + ((mu : ℝ) : ℂ) • dGamma numberCol u := by
      rw [dGamma_shiftCol, sub_add_cancel]
    have hadd : ∀ a b : FockAlg, toLp (a + b) = toLp a + toLp b := fun a b =>
      map_add toLpL a b
    have hsmul : ∀ (c : ℂ) (a : FockAlg), toLp (c • a) = c • toLp a := fun c a =>
      map_smul toLpL c a
    rw [hcol, hadd, hsmul, inner_add_right, inner_smul_right]
  rw [hsplit, Complex.add_re, Complex.re_ofReal_mul]
  have h1 : 0 ≤ (inner ℂ (toLp u) (toLp (dGamma (shiftCol col mu) u)) : ℂ).re :=
    inner_dGamma_nonneg hgap u
  have h2 : numberQuad u = (inner ℂ (toLp u) (toLp (dGamma numberCol u)) : ℂ).re := rfl
  rw [h2]
  linarith

/-- **The domination the plan asks for.**  With a one-particle gap `h ≥ μ > 0`, the field
form is relatively bounded by the free form: for every `t > 0`,
`|Re⟪u, Φ(f) u⟫| ≤ (t/μ)·Re⟪u, dΓ(h) u⟫ + (‖f‖²/t)‖u‖²`.

No boundedness and no number preservation of `Φ(f)` is used — it has neither. -/
theorem fieldVec_relative_form_bound {col : ℕ → (ℕ →₀ ℂ)} {mu t : ℝ} (hmu : 0 < mu)
    (ht : 0 < t) (hgap : IsPosCol (shiftCol col mu)) (f : ℕ →₀ ℂ) (u : FockAlg) :
    |(inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re|
      ≤ t / mu * (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
        + l2norm f ^ 2 / t * ‖toLp u‖ ^ 2 := by
  have h1 := abs_re_inner_fieldVec_le f u
  have h2 := two_mul_sqrt_le (c := l2norm f) (n := ‖toLp u‖) (N := numberQuad u) (t := t)
    (numberQuad_nonneg u) ht
  have h3 := number_le_dGamma_quadForm hgap u
  have h4 : t * numberQuad u
      ≤ t / mu * (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re := by
    rw [div_mul_eq_mul_div, le_div_iff₀ hmu]
    nlinarith [ht.le]
  linarith

/-! ## 5. The gap under the unbounded perturbation -/

/-- **The gap survives an unbounded number-changing perturbation.**  With the one-particle
gap `h − μ ≥ 0`, `μ > 0`, and a coupling vector with `‖f‖ ≤ μ`, every vacuum-orthogonal
finite-particle state has `dΓ(h) + Φ(f)` energy at least `(μ − 2‖f‖)‖u‖²`. -/
theorem fock_gap_of_field_perturbation {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ} (hmu : 0 < mu)
    (hgap : IsPosCol (shiftCol col mu)) {f : ℕ →₀ ℂ} (hf : l2norm f ≤ mu)
    {u : FockAlg} (h0 : u 0 = 0) :
    (mu - 2 * l2norm f) * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
        + (inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re := by
  have hc : 0 ≤ l2norm f := l2norm_nonneg f
  have hn : 0 ≤ ‖toLp u‖ := norm_nonneg _
  have hNq : 0 ≤ numberQuad u := numberQuad_nonneg u
  have hD := number_le_dGamma_quadForm hgap u
  have hnum : ‖toLp u‖ ^ 2 ≤ numberQuad u := number_quadForm_ge h0
  have hPhi := (abs_le.mp (abs_re_inner_fieldVec_le f u)).1
  have hs : Real.sqrt (numberQuad u) ^ 2 = numberQuad u := Real.sq_sqrt hNq
  have hs0 : 0 ≤ Real.sqrt (numberQuad u) := Real.sqrt_nonneg _
  have hsn : ‖toLp u‖ ≤ Real.sqrt (numberQuad u) := by nlinarith
  have hkey : (mu - 2 * l2norm f) * ‖toLp u‖ ^ 2
      ≤ mu * numberQuad u - 2 * l2norm f * Real.sqrt (numberQuad u) * ‖toLp u‖ := by
    have hfac : 0 ≤ (Real.sqrt (numberQuad u) - ‖toLp u‖) *
        (mu * (Real.sqrt (numberQuad u) + ‖toLp u‖) - 2 * l2norm f * ‖toLp u‖) := by
      have h1 : 0 ≤ Real.sqrt (numberQuad u) - ‖toLp u‖ := by linarith
      have h2 : 0 ≤ mu * (Real.sqrt (numberQuad u) + ‖toLp u‖) - 2 * l2norm f * ‖toLp u‖ := by
        nlinarith
      exact mul_nonneg h1 h2
    nlinarith
  linarith

/-- The surviving gap is strictly positive exactly when the coupling is quantitatively
smaller than half the one-particle gap. -/
theorem fock_gap_of_field_perturbation_pos {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ} (hmu : 0 < mu)
    (hgap : IsPosCol (shiftCol col mu)) {f : ℕ →₀ ℂ} (hf : 2 * l2norm f < mu)
    {u : FockAlg} (h0 : u 0 = 0) :
    0 < mu - 2 * l2norm f ∧
      (mu - 2 * l2norm f) * ‖toLp u‖ ^ 2
        ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re := by
  refine ⟨by linarith, fock_gap_of_field_perturbation hmu hgap ?_ h0⟩
  have := l2norm_nonneg f
  linarith

/-! ## 6. The perturbation is genuinely unbounded and genuinely number-changing -/

/-- `Φ(f)` moves the vacuum into the one-particle sector: it does not preserve the particle
number. -/
theorem fieldVec_vac (k : ℕ) :
    fieldVec (Finsupp.single k 1) vac = Finsupp.single (Finsupp.single k 1) (1 : ℂ) := by
  classical
  have hup : up k (0 : Conf) = Finsupp.single k 1 := by
    refine Finsupp.ext fun i => ?_
    rcases eq_or_ne i k with h | h
    · subst h; simp [up]
    · rw [up_of_ne _ h]
      simp [h]
  have hsupp : (Finsupp.single k (1 : ℂ)).support = {k} :=
    Finsupp.support_single_ne_zero k one_ne_zero
  rw [fieldVec_apply, creVec_apply, annVec_apply, hsupp]
  simp [vac, hup]

/-- **`Φ(f)` is not a bounded operator.**  For the coupling `f = e_k` the `n`-quantum states
are unit vectors whose images have norm `√(2n+1)`. -/
theorem fieldVec_unbounded (k : ℕ) (C : ℝ) :
    ∃ u : FockAlg, ‖toLp u‖ = 1 ∧ C ≤ ‖toLp (fieldVec (Finsupp.single k 1) u)‖ := by
  classical
  obtain ⟨n, hn⟩ := exists_nat_gt (C ^ 2)
  set al : Conf := Finsupp.single k n with hal
  set u : FockAlg := Finsupp.single al 1 with hu
  have halk : al k = n := by simp [hal]
  have husupp : u.support = {al} := Finsupp.support_single_ne_zero al one_ne_zero
  have hval : u al = 1 := by simp [hu]
  have hu1 : ‖toLp u‖ = 1 := by
    have h : ‖toLp u‖ ^ 2 = 1 := by
      rw [norm_toLp_sq, husupp, Finset.sum_singleton, hval]
      simp
    have hx : (0 : ℝ) ≤ ‖toLp u‖ := norm_nonneg _
    have hfac : (‖toLp u‖ - 1) * (‖toLp u‖ + 1) = 0 := by nlinarith
    rcases mul_eq_zero.mp hfac with h1 | h2
    · linarith
    · linarith
  refine ⟨u, hu1, ?_⟩
  set v : FockAlg := fieldVec (Finsupp.single k (1 : ℂ)) u with hv
  have hsupp : (Finsupp.single k (1 : ℂ)).support = {k} :=
    Finsupp.support_single_ne_zero k one_ne_zero
  have hvsplit : v = creA k u + annA k u := by
    rw [hv, fieldVec_apply, creVec_apply, annVec_apply, hsupp]
    simp
  have hupk : (up k al) k = n + 1 := by rw [up_self, halk]
  have hne : up k (up k al) ≠ al := by
    intro hcontra
    have := congrArg (fun β : Conf => β k) hcontra
    simp only [up_self, halk] at this
    omega
  have hcoord : v (up k al) = ((Real.sqrt ((n : ℝ) + 1) : ℝ) : ℂ) := by
    rw [hvsplit, Finsupp.add_apply, creA_apply, annA_apply, dn_up, hupk]
    have h2 : u (up k (up k al)) = 0 := by
      simp [hu, Ne.symm hne]
    rw [hval, h2, mul_zero, add_zero, mul_one]
    push_cast
    ring_nf
  have hcoordne : v (up k al) ≠ 0 := by
    rw [hcoord]
    have : (0 : ℝ) < Real.sqrt ((n : ℝ) + 1) := Real.sqrt_pos.mpr (by positivity)
    simpa using ne_of_gt this
  have hmem : up k al ∈ v.support := Finsupp.mem_support_iff.mpr hcoordne
  have hge : (n : ℝ) + 1 ≤ ‖toLp v‖ ^ 2 := by
    rw [norm_toLp_sq]
    have hterm : ‖v (up k al)‖ ^ 2 = (n : ℝ) + 1 := by
      rw [hcoord]
      rw [Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (Real.sqrt_nonneg _),
        Real.sq_sqrt (by positivity)]
    calc (n : ℝ) + 1 = ‖v (up k al)‖ ^ 2 := hterm.symm
      _ ≤ ∑ β ∈ v.support, ‖v β‖ ^ 2 :=
          Finset.single_le_sum (f := fun β => ‖v β‖ ^ 2) (fun _ _ => sq_nonneg _) hmem
  have hvn : (0 : ℝ) ≤ ‖toLp v‖ := norm_nonneg _
  nlinarith [sq_nonneg C]

/-! ## 7. Axiom audit -/

section Audit

#print axioms norm_annVec_le
#print axioms abs_re_inner_fieldVec_le
#print axioms number_le_dGamma_quadForm
#print axioms fieldVec_relative_form_bound
#print axioms fock_gap_of_field_perturbation
#print axioms fock_gap_of_field_perturbation_pos
#print axioms fieldVec_vac
#print axioms fieldVec_unbounded

end Audit

end BookProof.FockFieldPerturbation

end
