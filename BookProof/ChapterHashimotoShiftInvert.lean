import Mathlib
import BookProof.ChapterHermiteGalerkinFriedrichs
import BookProof.ChapterComplexShiftCore

/-!
# The shift-invert (Hashimoto) trick: the Galerkin/Friedrichs selection theorem
for **unbounded** Hamiltonians

`BookProof.ChapterHermiteGalerkinFriedrichs` proves that a Galerkin/Rayleigh–Ritz
truncation in a complete (Hermite) basis converges — strongly, and in the strong
resolvent sense — to the positive self-adjoint (Friedrichs) extension of the
matrix it is fed, under a standing hypothesis that the operator is **bounded**
on its domain.

That hypothesis is not a restriction on the *physics* the Hashimoto algorithm
does, because the algorithm never applies `H` itself: it applies the
*shift-inverted* operator `R = (H + γ)⁻¹`.  And `R` is bounded — indeed
`‖R‖ ≤ 1/γ` — for **every** positive symmetric `H`, however unbounded, purely
because of positivity.  This module makes that precise and closes the gap:

* `norm_shiftMap_ge` — the shift bound `‖(A + γ)x‖ ≥ γ‖x‖` for a positive
  symmetric operator.  This is why the *effective* Hamiltonian is bounded even
  when `H` is not.
* `closed_of_selfAdjointCriterion`, `shiftRange_isClosed`, `shiftRange_dense`,
  `shiftMap_surjective` — for a positive self-adjoint operator (in the sense of
  `IsPositiveSelfAdjointExtension`) the shifted operator `A + γ` is a bijection
  of its domain onto the whole space.  No boundedness is used.
* `IsShiftInvert`, `exists_isShiftInvert` — hence the bounded inverse
  `R = (A + γ)⁻¹` exists as a genuine element of `F →L[ℂ] F`, with
  `‖R‖ ≤ γ⁻¹` (`IsShiftInvert.opNorm_le`), self-adjoint
  (`IsShiftInvert.isSelfAdjoint`), positive and injective.
* `IsShiftInvert.dom_eq_range`, `IsShiftInvert.apply_eq`,
  `shiftInvert_determines` — `R` remembers everything: its range is the domain
  of `A`, and `A = R⁻¹ − γ` there.  Two positive self-adjoint operators with the
  same shift-invert are the same operator.
* `galerkinCompression_shiftInvert_tendsto`,
  `galerkinResolvent_shiftInvert_tendsto` — the bounded Galerkin theory of
  `BookProof.ChapterHermiteGalerkinFriedrichs` applies verbatim to `R`.
* `hashimoto_shiftInvert_selects_friedrichs` — the headline, **with no
  boundedness hypothesis anywhere**: for a symmetric positive matrix in a
  complete basis and any positive self-adjoint extension `A` of it (the
  Friedrichs extension being one), the shift-inverted operator `R = (A+γ)⁻¹` is
  bounded, the Galerkin truncations of `R` converge strongly to `R` (this is
  precisely strong resolvent convergence of the truncations to `A`), and `R`
  determines `A` uniquely — so the algorithm selects that extension and no
  other.
* `ell2UnboundedExample` and `unbounded_shiftInvert_example` — the hypotheses
  are satisfied by a genuinely **unbounded** operator: the diagonal operator
  `A eₙ = n eₙ` on `ℓ²(ℕ, ℂ)`, whose shift-invert at `γ = 1` is the bounded
  diagonal operator `eₙ ↦ eₙ/(n+1)`.  The boundedness hypothesis of
  `hermiteGalerkin_selects_friedrichs` fails for this `A`
  (`ell2UnboundedExample_unbounded`), while the theorems here apply.

This module treats one **real positive** shift `γ`, where invertibility of
`A + γ` comes from positivity of `A`.  The shifts the Shift-invert Rational
Krylov method actually uses are complex with non-zero imaginary part (which
makes `γ I − A` invertible for every self-adjoint `A`, positive or not), and
they change from step to step; that generalisation, in the same namespace, is
`BookProof.ChapterHashimotoComplexShifts`, whose
`isShiftInvertC_neg_of_isShiftInvert` relates the two notions.
-/

namespace BookProof.HashimotoShiftInvert

open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

/-! ## Part 1 — the shift bound: why the effective Hamiltonian is bounded -/

section Bound

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

/-- The shifted operator `A + γ` on the domain of `A`. -/
noncomputable def shiftMap (A : Dom →ₗ[ℂ] F) (γ : ℝ) : Dom →ₗ[ℂ] F :=
  A + (γ : ℂ) • Dom.subtype

@[simp] theorem shiftMap_apply (A : Dom →ₗ[ℂ] F) (γ : ℝ) (x : Dom) :
    shiftMap A γ x = A x + (γ : ℂ) • (x : F) := rfl

/-- **The shift bound.**  For a positive operator and a positive shift,
`‖(A + γ)x‖ ≥ γ‖x‖`: the shifted operator is bounded *below*, so its inverse —
the operator the shift-invert algorithm actually applies — is bounded *above*,
no matter how unbounded `A` is. -/
theorem norm_shiftMap_ge {A : Dom →ₗ[ℂ] F} (hpos : ∀ x : Dom, 0 ≤ quadForm A x)
    {γ : ℝ} (x : Dom) :
    γ * ‖(x : F)‖ ≤ ‖shiftMap A γ x‖ := by
  have hxy : (inner ℂ (x : F) (shiftMap A γ x) : ℂ).re = quadForm A x + γ * ‖(x : F)‖ ^ 2 := by
    simp only [shiftMap_apply, inner_add_right, inner_smul_right, Complex.add_re, quadForm]
    rw [inner_self_eq_norm_sq_to_K]
    simp [← Complex.ofReal_pow]
  have h1 : γ * ‖(x : F)‖ ^ 2 ≤ (inner ℂ (x : F) (shiftMap A γ x) : ℂ).re := by
    rw [hxy]; linarith [hpos x]
  have h2 : (inner ℂ (x : F) (shiftMap A γ x) : ℂ).re ≤ ‖(x : F)‖ * ‖shiftMap A γ x‖ :=
    le_trans (Complex.re_le_norm _) (norm_inner_le_norm _ _)
  rcases eq_or_lt_of_le (norm_nonneg (x : F)) with h0 | hpx
  · rw [← h0]
    simp
  · nlinarith

/-- The shifted operator of a positive operator is injective. -/
theorem shiftMap_injective {A : Dom →ₗ[ℂ] F} (hpos : ∀ x : Dom, 0 ≤ quadForm A x)
    {γ : ℝ} (hγ : 0 < γ) : Function.Injective (shiftMap A γ) := by
  intro x y hxy
  have h : γ * ‖((x - y : Dom) : F)‖ ≤ ‖shiftMap A γ (x - y)‖ := norm_shiftMap_ge hpos _
  rw [map_sub, hxy, sub_self, norm_zero] at h
  have hx : ‖((x - y : Dom) : F)‖ = 0 := le_antisymm (by nlinarith) (norm_nonneg _)
  have : ((x - y : Dom) : F) = 0 := by simpa using hx
  have hz : x - y = 0 := Subtype.ext (by simpa using this)
  exact sub_eq_zero.mp hz

end Bound

/-! ## Part 2 — for a positive self-adjoint operator the shift is a bijection -/

section Surjective

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}


/-- The range of the shifted operator, as a submodule. -/
noncomputable def shiftRange (A : Dom →ₗ[ℂ] F) (γ : ℝ) : Submodule ℂ F :=
  LinearMap.range (shiftMap A γ)

/-- **The range of `A + γ` is closed** — because `A + γ` is bounded below and
`A` is closed. -/
theorem shiftRange_isClosed {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A)
    (hpos : ∀ x : Dom, 0 ≤ quadForm A x)
    (hsa : ∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)
    {γ : ℝ} (hγ : 0 < γ) : IsClosed ((shiftRange A γ : Submodule ℂ F) : Set F) := by
  refine IsSeqClosed.isClosed ?_
  intro u p hu hup
  choose x hx using hu
  -- the preimages form a Cauchy sequence, by the shift bound
  have hcauchy : CauchySeq (fun n => ((x n : F))) := by
    have hucauchy : CauchySeq u := hup.cauchySeq
    rw [Metric.cauchySeq_iff] at hucauchy ⊢
    intro eps heps
    obtain ⟨N, hN⟩ := hucauchy (γ * eps) (by positivity)
    refine ⟨N, fun m hm n hn => ?_⟩
    have hb : γ * ‖((x m - x n : Dom) : F)‖ ≤ ‖shiftMap A γ (x m - x n)‖ :=
      norm_shiftMap_ge hpos _
    rw [map_sub, hx m, hx n] at hb
    have hlt : ‖u m - u n‖ < γ * eps := by
      have hd := hN m hm n hn
      rwa [dist_eq_norm] at hd
    have hkey : γ * ‖((x m : F)) - ((x n : F))‖ < γ * eps := by
      refine lt_of_le_of_lt ?_ hlt
      simpa using hb
    rw [dist_eq_norm]
    exact lt_of_mul_lt_mul_left hkey hγ.le
  obtain ⟨w, hw⟩ := cauchySeq_tendsto_of_complete hcauchy
  -- and their images under `A` converge too
  have hAconv : Tendsto (fun n => A (x n)) atTop (nhds (p - (γ : ℂ) • w)) := by
    have hval : ∀ n, A (x n) = u n - (γ : ℂ) • ((x n : F)) := by
      intro n
      have hn := hx n
      simp only [shiftMap_apply] at hn
      exact eq_sub_of_add_eq hn
    simp only [hval]
    exact hup.sub (hw.const_smul ((γ : ℂ)))
  obtain ⟨hwmem, hAw⟩ := closed_of_selfAdjointCriterion hsym hsa hw hAconv
  refine ⟨⟨w, hwmem⟩, ?_⟩
  simp only [shiftMap_apply, hAw]
  abel

omit [CompleteSpace F] in
/-- **The range of `A + γ` is dense** — a vector orthogonal to it would be an
eigenvector of `A` with eigenvalue `-γ < 0`, contradicting positivity. -/
theorem shiftRange_orthogonal_eq_bot {A : Dom →ₗ[ℂ] F}
    (hpos : ∀ x : Dom, 0 ≤ quadForm A x)
    (hsa : ∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)
    {γ : ℝ} (hγ : 0 < γ) : (shiftRange A γ)ᗮ = ⊥ := by
  rw [Submodule.eq_bot_iff]
  intro w hw
  have hip : ∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) (-(γ : ℂ) • w) := by
    intro v
    have hmem : shiftMap A γ v ∈ shiftRange A γ := ⟨v, rfl⟩
    have h0 : (inner ℂ (shiftMap A γ v) w : ℂ) = 0 := hw _ hmem
    rw [shiftMap_apply, inner_add_left, inner_smul_left, Complex.conj_ofReal] at h0
    rw [inner_smul_right]
    have hval : (inner ℂ (A v) w : ℂ) = -((γ : ℂ) * inner ℂ ((v : F)) w) := by
      linear_combination h0
    rw [hval]
    ring
  obtain ⟨hwmem, hAw⟩ := hsa w (-(γ : ℂ) • w) hip
  have hquad : quadForm A ⟨w, hwmem⟩ = -γ * ‖w‖ ^ 2 := by
    rw [quadForm, hAw, inner_smul_right, inner_self_eq_norm_sq_to_K]
    simp [← Complex.ofReal_pow]
  have h1 := hpos ⟨w, hwmem⟩
  rw [hquad] at h1
  have hzero : ‖w‖ = 0 := by
    by_contra hne
    have hpw : 0 < ‖w‖ := lt_of_le_of_ne (norm_nonneg w) (Ne.symm hne)
    have hcontr : 0 < γ * ‖w‖ ^ 2 := by positivity
    linarith
  simpa using hzero

/-- **`A + γ` is surjective** for a positive self-adjoint `A` and `γ > 0`:
closed range with trivial orthogonal complement is everything.  Together with
`shiftMap_injective` this says `A + γ` is a bijection of `Dom` onto `F`. -/
theorem shiftMap_surjective {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A)
    (hpos : ∀ x : Dom, 0 ≤ quadForm A x)
    (hsa : ∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)
    {γ : ℝ} (hγ : 0 < γ) : Function.Surjective (shiftMap A γ) := by
  have hclosed : IsClosed ((shiftRange A γ : Submodule ℂ F) : Set F) :=
    shiftRange_isClosed hsym hpos hsa hγ
  haveI : CompleteSpace (shiftRange A γ) := hclosed.completeSpace_coe
  have htop : shiftRange A γ = ⊤ := by
    have h1 := Submodule.orthogonal_orthogonal (shiftRange A γ)
    rw [shiftRange_orthogonal_eq_bot hpos hsa hγ, Submodule.bot_orthogonal_eq_top] at h1
    exact h1.symm
  intro u
  have hmem : u ∈ shiftRange A γ := by rw [htop]; trivial
  exact hmem

end Surjective

/-! ## Part 3 — the shift-inverted operator `R = (A + γ)⁻¹` -/

section ShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

/-- `R` is the **shift-invert** of `A` at shift `γ`: a bounded everywhere-defined
operator that inverts `A + γ` in both directions.  This is the operator the
Hashimoto/SIRK algorithm actually applies — the "effective Hamiltonian". -/
def IsShiftInvert (A : Dom →ₗ[ℂ] F) (γ : ℝ) (R : F →L[ℂ] F) : Prop :=
  (∀ x : Dom, R (shiftMap A γ x) = (x : F)) ∧
    ∀ u : F, ∃ h : R u ∈ Dom, shiftMap A γ ⟨R u, h⟩ = u

theorem IsShiftInvert.mem {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (u : F) : R u ∈ Dom := (h.2 u).choose

theorem IsShiftInvert.shift_apply {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (u : F) :
    A ⟨R u, h.mem u⟩ + (γ : ℂ) • R u = u := (h.2 u).choose_spec

/-- The unbounded operator is recovered from its shift-invert: `A = R⁻¹ − γ`. -/
theorem IsShiftInvert.apply_eq {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (u : F) :
    A ⟨R u, h.mem u⟩ = u - (γ : ℂ) • R u :=
  eq_sub_of_add_eq (h.shift_apply u)

/-- **The shift-invert is bounded by `1/γ`.**  This is the whole point: the
operator the algorithm iterates is bounded even though `A` need not be. -/
theorem IsShiftInvert.norm_apply_le {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (hpos : ∀ x : Dom, 0 ≤ quadForm A x) (hγ : 0 < γ) (u : F) :
    ‖R u‖ ≤ γ⁻¹ * ‖u‖ := by
  have hb : γ * ‖((⟨R u, h.mem u⟩ : Dom) : F)‖ ≤ ‖shiftMap A γ ⟨R u, h.mem u⟩‖ :=
    norm_shiftMap_ge hpos _
  rw [show shiftMap A γ ⟨R u, h.mem u⟩ = u from h.shift_apply u] at hb
  rw [inv_mul_eq_div, le_div_iff₀ hγ, mul_comm]
  simpa using hb

theorem IsShiftInvert.opNorm_le {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (hpos : ∀ x : Dom, 0 ≤ quadForm A x) (hγ : 0 < γ) :
    ‖R‖ ≤ γ⁻¹ :=
  R.opNorm_le_bound (by positivity) (h.norm_apply_le hpos hγ)

/-- The shift-invert of a symmetric operator is symmetric, hence (being bounded
and everywhere defined) self-adjoint. -/
theorem IsShiftInvert.isSelfAdjoint [CompleteSpace F] {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (hsym : SymmetricOn Dom A) : IsSelfAdjoint R := by
  refine ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mpr ?_
  intro u v
  have hu : A ⟨R u, h.mem u⟩ + (γ : ℂ) • R u = u := h.shift_apply u
  have hv : A ⟨R v, h.mem v⟩ + (γ : ℂ) • R v = v := h.shift_apply v
  have hcross : (inner ℂ (A ⟨R u, h.mem u⟩) (R v) : ℂ)
      = inner ℂ (R u) (A ⟨R v, h.mem v⟩) := hsym ⟨R u, h.mem u⟩ ⟨R v, h.mem v⟩
  have e1 : (inner ℂ (R u) v : ℂ)
      = inner ℂ (R u) (A ⟨R v, h.mem v⟩) + (γ : ℂ) * inner ℂ (R u) (R v) := by
    conv_lhs => rw [← hv]
    rw [inner_add_right, inner_smul_right]
  have e2 : (inner ℂ u (R v) : ℂ)
      = inner ℂ (A ⟨R u, h.mem u⟩) (R v) + (γ : ℂ) * inner ℂ (R u) (R v) := by
    conv_lhs => rw [← hu]
    rw [inner_add_left, inner_smul_left]
    simp
  change (inner ℂ (R u) v : ℂ) = inner ℂ u (R v)
  rw [e1, e2, hcross]

/-- The shift-invert of a positive operator is positive. -/
theorem IsShiftInvert.inner_nonneg {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (hpos : ∀ x : Dom, 0 ≤ quadForm A x) (hγ : 0 < γ) (u : F) :
    0 ≤ (inner ℂ u (R u) : ℂ).re := by
  have hu : A ⟨R u, h.mem u⟩ + (γ : ℂ) • R u = u := h.shift_apply u
  have key : ∀ (y : F) (hy : y ∈ Dom),
      (inner ℂ (A ⟨y, hy⟩ + (γ : ℂ) • y) y : ℂ).re = quadForm A ⟨y, hy⟩ + γ * ‖y‖ ^ 2 := by
    intro y hy
    have hq : (inner ℂ (A ⟨y, hy⟩) y : ℂ).re = quadForm A ⟨y, hy⟩ := by
      rw [quadForm, ← inner_conj_symm (A ⟨y, hy⟩) y, Complex.conj_re]
    rw [inner_add_left, inner_smul_left, Complex.add_re, hq, inner_self_eq_norm_sq_to_K]
    simp [← Complex.ofReal_pow]
  have hexp := key (R u) (h.mem u)
  rw [hu] at hexp
  rw [hexp]
  have := hpos ⟨R u, h.mem u⟩
  positivity

theorem IsShiftInvert.injective {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) : Function.Injective R := by
  intro u v huv
  have hu : A ⟨R u, h.mem u⟩ + (γ : ℂ) • R u = u := h.shift_apply u
  have hv : A ⟨R v, h.mem v⟩ + (γ : ℂ) • R v = v := h.shift_apply v
  have hsub : (⟨R u, h.mem u⟩ : Dom) = ⟨R v, h.mem v⟩ := Subtype.ext huv
  rw [← hu, ← hv, hsub, huv]

/-- **The domain of `A` is the range of its shift-invert.** -/
theorem IsShiftInvert.dom_eq_range {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) : Dom = LinearMap.range (R : F →ₗ[ℂ] F) := by
  apply le_antisymm
  · intro x hx
    exact ⟨shiftMap A γ ⟨x, hx⟩, h.1 ⟨x, hx⟩⟩
  · rintro _ ⟨u, rfl⟩
    exact h.mem u

/-- **The shift-invert determines the operator.**  Two operators (on possibly
different domains) with the same shift-invert have the same domain and are
equal on it.  So an algorithm that computes `R` has computed `A`; nothing about
the choice of self-adjoint extension is left open. -/
theorem shiftInvert_determines {Dom₁ Dom₂ : Submodule ℂ F} {A₁ : Dom₁ →ₗ[ℂ] F}
    {A₂ : Dom₂ →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h₁ : IsShiftInvert A₁ γ R) (h₂ : IsShiftInvert A₂ γ R) :
    Dom₁ = Dom₂ ∧ ∀ (x : F) (hx₁ : x ∈ Dom₁) (hx₂ : x ∈ Dom₂), A₁ ⟨x, hx₁⟩ = A₂ ⟨x, hx₂⟩ := by
  refine ⟨by rw [h₁.dom_eq_range, h₂.dom_eq_range], ?_⟩
  intro x hx₁ hx₂
  set u : F := shiftMap A₁ γ ⟨x, hx₁⟩ with hu
  have hRu : R u = x := h₁.1 ⟨x, hx₁⟩
  have e₁ : A₁ ⟨R u, h₁.mem u⟩ = u - (γ : ℂ) • R u := h₁.apply_eq u
  have e₂ : A₂ ⟨R u, h₂.mem u⟩ = u - (γ : ℂ) • R u := h₂.apply_eq u
  have c₁ : (⟨R u, h₁.mem u⟩ : Dom₁) = ⟨x, hx₁⟩ := Subtype.ext hRu
  have c₂ : (⟨R u, h₂.mem u⟩ : Dom₂) = ⟨x, hx₂⟩ := Subtype.ext hRu
  rw [c₁] at e₁
  rw [c₂] at e₂
  rw [e₁, e₂]

/-- The shift-invert, when it exists, is unique. -/
theorem isShiftInvert_unique {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R S : F →L[ℂ] F}
    (hR : IsShiftInvert A γ R) (hS : IsShiftInvert A γ S) : R = S := by
  ext u
  have h1 : S (shiftMap A γ ⟨R u, hR.mem u⟩) = R u := hS.1 ⟨R u, hR.mem u⟩
  rw [show shiftMap A γ ⟨R u, hR.mem u⟩ = u from hR.shift_apply u] at h1
  exact h1.symm

/-- **Existence of the shift-invert.**  If `A` is positive and `A + γ` is
surjective, the inverse is a *bounded* everywhere-defined operator. -/
theorem exists_isShiftInvert {A : Dom →ₗ[ℂ] F} (hpos : ∀ x : Dom, 0 ≤ quadForm A x)
    {γ : ℝ} (hγ : 0 < γ) (hsurj : Function.Surjective (shiftMap A γ)) :
    ∃ R : F →L[ℂ] F, IsShiftInvert A γ R := by
  classical
  have hinj : Function.Injective (shiftMap A γ) := shiftMap_injective hpos hγ
  choose g hg using hsurj
  have hgshift : ∀ x : Dom, g (shiftMap A γ x) = x := fun x => hinj (hg _)
  have hadd : ∀ u v : F, ((g (u + v) : Dom) : F) = (g u : F) + (g v : F) := by
    intro u v
    have : shiftMap A γ (g (u + v)) = shiftMap A γ (g u + g v) := by
      rw [hg, map_add, hg, hg]
    exact congrArg Subtype.val (hinj this)
  have hsmul : ∀ (c : ℂ) (u : F), ((g (c • u) : Dom) : F) = c • (g u : F) := by
    intro c u
    have : shiftMap A γ (g (c • u)) = shiftMap A γ (c • g u) := by
      rw [hg, map_smul, hg]
    exact congrArg Subtype.val (hinj this)
  let L : F →ₗ[ℂ] F :=
    { toFun := fun u => (g u : F)
      map_add' := hadd
      map_smul' := by intro c u; simpa using hsmul c u }
  have hbound : ∀ u : F, ‖L u‖ ≤ γ⁻¹ * ‖u‖ := by
    intro u
    have hb : γ * ‖((g u : Dom) : F)‖ ≤ ‖shiftMap A γ (g u)‖ := norm_shiftMap_ge hpos _
    rw [hg u] at hb
    rw [inv_mul_eq_div, le_div_iff₀ hγ, mul_comm]
    exact hb
  refine ⟨L.mkContinuous γ⁻¹ hbound, fun x => ?_, fun u => ?_⟩
  · change ((g (shiftMap A γ x) : Dom) : F) = (x : F)
    rw [hgshift x]
  · refine ⟨(g u).2, ?_⟩
    have hsub : (⟨((g u : Dom) : F), (g u).2⟩ : Dom) = g u := Subtype.ext rfl
    change shiftMap A γ ⟨((g u : Dom) : F), _⟩ = u
    rw [hsub, hg u]

end ShiftInvert

/-! ## Part 3b — the converse: the operator defined by a bounded shift-invert

Running the construction backwards turns a bounded, injective, positive
self-adjoint `R` into the (generally unbounded) operator `A = R⁻¹ − γ` of which
it is the shift-invert.  This is how one exhibits genuinely unbounded examples,
and it shows the notion `IsShiftInvert` is not vacuous. -/

section Converse

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- A preimage under an operator, chosen on its range. -/
noncomputable def preim (R : F →L[ℂ] F) (y : LinearMap.range (R : F →ₗ[ℂ] F)) : F :=
  (LinearMap.mem_range.mp y.2).choose

omit [CompleteSpace F] in
@[simp] theorem preim_spec (R : F →L[ℂ] F) (y : LinearMap.range (R : F →ₗ[ℂ] F)) :
    R (preim R y) = (y : F) := (LinearMap.mem_range.mp y.2).choose_spec

omit [CompleteSpace F] in
theorem preim_eq (R : F →L[ℂ] F) (hinj : Function.Injective R)
    (y : LinearMap.range (R : F →ₗ[ℂ] F)) {u : F} (hu : R u = (y : F)) : preim R y = u :=
  hinj (by rw [preim_spec, hu])

/-- **The operator whose shift-invert is `R`**: `A = R⁻¹ − γ`, defined on the
range of `R`. -/
noncomputable def invShiftOperator (R : F →L[ℂ] F) (hinj : Function.Injective R) (γ : ℝ) :
    LinearMap.range (R : F →ₗ[ℂ] F) →ₗ[ℂ] F where
  toFun y := preim R y - (γ : ℂ) • (y : F)
  map_add' y z := by
    have h : preim R (y + z) = preim R y + preim R z := by
      apply hinj
      rw [preim_spec, map_add, preim_spec, preim_spec]
      rfl
    rw [h]
    push_cast [Submodule.coe_add]
    module
  map_smul' a y := by
    have h : preim R (a • y) = a • preim R y := by
      apply hinj
      rw [preim_spec, map_smul, preim_spec]
      rfl
    simp only [RingHom.id_apply, h]
    push_cast [Submodule.coe_smul]
    module

omit [CompleteSpace F] in
@[simp] theorem invShiftOperator_apply (R : F →L[ℂ] F) (hinj : Function.Injective R) (γ : ℝ)
    (y : LinearMap.range (R : F →ₗ[ℂ] F)) :
    invShiftOperator R hinj γ y = preim R y - (γ : ℂ) • (y : F) := rfl

omit [CompleteSpace F] in
/-- `R` really is the shift-invert of the operator it defines. -/
theorem isShiftInvert_invShiftOperator (R : F →L[ℂ] F) (hinj : Function.Injective R) (γ : ℝ) :
    IsShiftInvert (invShiftOperator R hinj γ) γ R := by
  constructor
  · intro x
    have hx : shiftMap (invShiftOperator R hinj γ) γ x = preim R x := by
      simp [shiftMap_apply]
    rw [hx, preim_spec]
  · intro u
    refine ⟨⟨u, rfl⟩, ?_⟩
    have hpre : preim R ⟨R u, ⟨u, rfl⟩⟩ = u := preim_eq R hinj _ rfl
    simp [shiftMap_apply, hpre]

/-- The operator defined by a self-adjoint `R` is symmetric. -/
theorem invShiftOperator_symmetricOn (R : F →L[ℂ] F) (hinj : Function.Injective R) (γ : ℝ)
    (hR : IsSelfAdjoint R) :
    SymmetricOn (LinearMap.range (R : F →ₗ[ℂ] F)) (invShiftOperator R hinj γ) := by
  have hRsym := ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hR
  intro y z
  have hy : R (preim R y) = (y : F) := preim_spec R y
  have hz : R (preim R z) = (z : F) := preim_spec R z
  have hcross : (inner ℂ (preim R y) (z : F) : ℂ) = inner ℂ (y : F) (preim R z) := by
    rw [← hy, ← hz]
    exact (hRsym (preim R y) (preim R z)).symm
  simp only [invShiftOperator_apply, inner_sub_left, inner_sub_right, inner_smul_left,
    inner_smul_right, Complex.conj_ofReal, hcross]

omit [CompleteSpace F] in
/-- The operator defined by `R` is positive exactly when `R ≤ 1/γ` in the sense
of quadratic forms. -/
theorem invShiftOperator_quadForm_nonneg (R : F →L[ℂ] F) (hinj : Function.Injective R) (γ : ℝ)
    (hposR : ∀ u : F, γ * ‖R u‖ ^ 2 ≤ (inner ℂ (R u) u : ℂ).re)
    (y : LinearMap.range (R : F →ₗ[ℂ] F)) : 0 ≤ quadForm (invShiftOperator R hinj γ) y := by
  have hy : R (preim R y) = (y : F) := preim_spec R y
  have hq : quadForm (invShiftOperator R hinj γ) y
      = (inner ℂ (y : F) (preim R y) : ℂ).re - γ * ‖(y : F)‖ ^ 2 := by
    rw [quadForm, invShiftOperator_apply, inner_sub_right, inner_smul_right, Complex.sub_re,
      inner_self_eq_norm_sq_to_K]
    congr 1
    simp [← Complex.ofReal_pow]
  have hp := hposR (preim R y)
  rw [hy] at hp
  rw [hq]
  linarith

/-- The operator defined by an injective self-adjoint `R` satisfies the
self-adjointness criterion: every vector that behaves like a domain vector is
one. -/
theorem invShiftOperator_selfAdjointCriterion (R : F →L[ℂ] F) (hinj : Function.Injective R)
    (γ : ℝ) (hR : IsSelfAdjoint R) (w u : F)
    (hw : ∀ v : LinearMap.range (R : F →ₗ[ℂ] F),
      (inner ℂ (invShiftOperator R hinj γ v) w : ℂ) = inner ℂ (v : F) u) :
    ∃ h : w ∈ LinearMap.range (R : F →ₗ[ℂ] F), invShiftOperator R hinj γ ⟨w, h⟩ = u := by
  have hRsym := ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mp hR
  have hkey : ∀ z : F, (inner ℂ z (w - (γ : ℂ) • R w - R u) : ℂ) = 0 := by
    intro z
    have hv := hw ⟨R z, ⟨z, rfl⟩⟩
    have hpre : preim R ⟨R z, ⟨z, rfl⟩⟩ = z := preim_eq R hinj _ rfl
    rw [invShiftOperator_apply, hpre] at hv
    have h1 : (inner ℂ (R z) w : ℂ) = inner ℂ z (R w) := hRsym z w
    have h2 : (inner ℂ (R z) u : ℂ) = inner ℂ z (R u) := hRsym z u
    rw [inner_sub_left, inner_smul_left, Complex.conj_ofReal, h1, h2] at hv
    rw [inner_sub_right, inner_sub_right, inner_smul_right]
    rw [hv]
    ring
  have hzero : w - (γ : ℂ) • R w - R u = 0 :=
    inner_self_eq_zero.mp (hkey (w - (γ : ℂ) • R w - R u))
  have hwsum : w = (γ : ℂ) • R w + R u := by
    linear_combination (norm := module) hzero
  have hwval : w = R (u + (γ : ℂ) • w) := by
    rw [map_add, map_smul]
    linear_combination (norm := module) hwsum
  refine ⟨⟨u + (γ : ℂ) • w, hwval.symm⟩, ?_⟩
  have hpre : preim R ⟨w, ⟨u + (γ : ℂ) • w, hwval.symm⟩⟩ = u + (γ : ℂ) • w :=
    preim_eq R hinj _ hwval.symm
  rw [invShiftOperator_apply, hpre]
  module

/-- **The operator defined by a bounded, injective, positive self-adjoint `R` is
a positive self-adjoint extension** of any restriction of it. -/
theorem invShiftOperator_isPositiveSelfAdjointExtension (R : F →L[ℂ] F)
    (hinj : Function.Injective R) (γ : ℝ) (hR : IsSelfAdjoint R)
    (hposR : ∀ u : F, γ * ‖R u‖ ^ 2 ≤ (inner ℂ (R u) u : ℂ).re)
    {D : Submodule ℂ F} (hD : D ≤ LinearMap.range (R : F →ₗ[ℂ] F)) (H : D →ₗ[ℂ] F)
    (hH : ∀ x : D, H x = invShiftOperator R hinj γ ⟨(x : F), hD x.2⟩) :
    IsPositiveSelfAdjointExtension H (invShiftOperator R hinj γ) :=
  ⟨fun x => ⟨hD x.2, (hH x).symm⟩, invShiftOperator_symmetricOn R hinj γ hR,
    invShiftOperator_quadForm_nonneg R hinj γ hposR,
    invShiftOperator_selfAdjointCriterion R hinj γ hR⟩

end Converse

/-! ## Part 4 — the Galerkin theory applies to the effective Hamiltonian -/

section Galerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}

omit [CompleteSpace F] in
/-- **The Galerkin truncations of the effective Hamiltonian converge.**  This is
the bounded theory of `BookProof.ChapterHermiteGalerkinFriedrichs` applied to
`R = (A + γ)⁻¹`; since `R` is the resolvent of `A` at `−γ`, this *is* strong
resolvent convergence of the truncations to the unbounded `A`. -/
theorem galerkinCompression_shiftInvert_tendsto {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (b : HilbertBasis ℕ ℂ F) (u : F) :
    ∃ (x : F) (hx : x ∈ Dom), A ⟨x, hx⟩ + (γ : ℂ) • x = u ∧
      Tendsto (fun m : ℕ => galerkinCompression R b m u) atTop (nhds x) :=
  ⟨R u, h.mem u, h.shift_apply u, galerkinCompression_tendsto R b u⟩

/-- The resolvents of the Galerkin truncations of the effective Hamiltonian
converge to the resolvent of the effective Hamiltonian. -/
theorem galerkinResolvent_shiftInvert_tendsto {A : Dom →ₗ[ℂ] F} {γ : ℝ} {R : F →L[ℂ] F}
    (h : IsShiftInvert A γ R) (hsym : SymmetricOn Dom A) (b : HilbertBasis ℕ ℂ F)
    {z : ℂ} (hz : z.im ≠ 0) (u : F) :
    Tendsto (fun m : ℕ => resolvent (galerkinCompression R b m) z u) atTop
      (nhds (resolvent R z u)) :=
  galerkinResolvent_tendsto (h.isSelfAdjoint hsym) b hz u

end Galerkin

/-! ## Part 5 — the headline: no boundedness hypothesis -/

section Headline

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-- **The Hashimoto/Galerkin algorithm selects the Friedrichs extension, for an
unbounded Hamiltonian.**

Let `H` be the matrix of a symmetric positive Hamiltonian in a complete
orthonormal (Hermite) basis, on the domain of finite linear combinations, and
let `A` be *any* positive self-adjoint extension of it — the Friedrichs
extension in particular.  **No boundedness is assumed of `H` or of `A`.**  Then
for every shift `γ > 0`:

1. the shift-inverted operator `R = (A + γ)⁻¹` exists, is everywhere defined,
   self-adjoint, positive and **bounded**, with `‖R‖ ≤ 1/γ` — this is the
   operator the algorithm iterates;
2. its Galerkin truncations converge to it strongly, and their resolvents
   converge to its resolvent at every non-real spectral parameter;
3. `R` determines `A`: any positive self-adjoint operator with the same
   shift-invert has the same domain and the same values.

So the bounded convergence theory covers the unbounded Hamiltonian, and the
extension the algorithm converges to is the one it was given. -/
theorem hashimoto_shiftInvert_selects_friedrichs (b : HilbertBasis ℕ ℂ F)
    (H : finiteModeDomain b →ₗ[ℂ] F) {Dom : Submodule ℂ F} (A : Dom →ₗ[ℂ] F)
    (hA : IsPositiveSelfAdjointExtension H A) {γ : ℝ} (hγ : 0 < γ) :
    ∃ R : F →L[ℂ] F,
      IsShiftInvert A γ R ∧ ‖R‖ ≤ γ⁻¹ ∧ IsSelfAdjoint R ∧
      (∀ u : F, 0 ≤ (inner ℂ u (R u) : ℂ).re) ∧
      (∀ u : F, Tendsto (fun m : ℕ => galerkinCompression R b m u) atTop (nhds (R u))) ∧
      (∀ z : ℂ, z.im ≠ 0 → ∀ u : F,
        Tendsto (fun m : ℕ => resolvent (galerkinCompression R b m) z u) atTop
          (nhds (resolvent R z u))) ∧
      (∀ (Dom' : Submodule ℂ F) (A' : Dom' →ₗ[ℂ] F), IsShiftInvert A' γ R →
        Dom' = Dom ∧ ∀ (x : F) (hx : x ∈ Dom) (hx' : x ∈ Dom'), A' ⟨x, hx'⟩ = A ⟨x, hx⟩) := by
  obtain ⟨-, hsym, hpos, hsa⟩ := hA
  obtain ⟨R, hR⟩ := exists_isShiftInvert hpos hγ (shiftMap_surjective hsym hpos hsa hγ)
  have hRsa : IsSelfAdjoint R := hR.isSelfAdjoint hsym
  refine ⟨R, hR, hR.opNorm_le hpos hγ, hRsa, hR.inner_nonneg hpos hγ,
    fun u => galerkinCompression_tendsto R b u,
    fun z hz u => galerkinResolvent_tendsto hRsa b hz u, ?_⟩
  intro Dom' A' hA'
  obtain ⟨hdom, hval⟩ := shiftInvert_determines hA' hR
  exact ⟨hdom, fun x hx hx' => hval x hx' hx⟩

end Headline

/-! ## Part 6 — a genuinely unbounded example -/

section Example

open scoped InnerProductSpace ENNReal

/-! ### The diagonal operator on `ℓ²(ℕ, ℂ)` -/

theorem memlp_diagFun {c : ℕ → ℝ} (hc : ∀ n, |c n| ≤ 1) (x : ℓ²(ℕ, ℂ)) :
    Memℓp (fun n => (c n : ℂ) * x n) 2 := by
  have hx : Summable fun n => ‖(x : ℕ → ℂ) n‖ ^ (2 : ℝ≥0∞).toReal :=
    (lp.memℓp x).summable (by norm_num)
  refine memℓp_gen (Summable.of_nonneg_of_le (fun n => by positivity) (fun n => ?_) hx)
  have h1 : ‖(c n : ℂ) * (x : ℕ → ℂ) n‖ = |c n| * ‖(x : ℕ → ℂ) n‖ := by
    simp [Complex.norm_real]
  have hle : |c n| * ‖(x : ℕ → ℂ) n‖ ≤ ‖(x : ℕ → ℂ) n‖ := by
    nlinarith [abs_nonneg (c n), hc n, norm_nonneg ((x : ℕ → ℂ) n)]
  rw [h1, show (2 : ℝ≥0∞).toReal = 2 by norm_num]
  exact Real.rpow_le_rpow (by positivity) hle (by norm_num)

/-- The diagonal (multiplication) operator on `ℓ²(ℕ, ℂ)` with real coefficients
bounded by one, as a linear map. -/
noncomputable def diagLin {c : ℕ → ℝ} (hc : ∀ n, |c n| ≤ 1) : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ) where
  toFun x := ⟨fun n => (c n : ℂ) * x n, memlp_diagFun hc x⟩
  map_add' x y := by
    apply lp.ext; funext n; simp [mul_add]
  map_smul' a x := by
    apply lp.ext; funext n; simp; ring

@[simp] theorem diagLin_apply {c : ℕ → ℝ} (hc : ∀ n, |c n| ≤ 1) (x : ℓ²(ℕ, ℂ)) (n : ℕ) :
    ((diagLin hc x : ℓ²(ℕ, ℂ)) : ℕ → ℂ) n = (c n : ℂ) * x n := rfl

theorem diagLin_norm_le {c : ℕ → ℝ} (hc : ∀ n, |c n| ≤ 1) (x : ℓ²(ℕ, ℂ)) :
    ‖diagLin hc x‖ ≤ ‖x‖ := by
  refine lp.norm_le_of_tsum_le (by norm_num) (norm_nonneg x) ?_
  rw [lp.norm_rpow_eq_tsum (by norm_num : (0 : ℝ) < (2 : ℝ≥0∞).toReal) x]
  refine Summable.tsum_le_tsum (fun n => ?_)
    ((memlp_diagFun hc x).summable (by norm_num)) ((lp.memℓp x).summable (by norm_num))
  have h1 : ‖((diagLin hc x : ℓ²(ℕ, ℂ)) : ℕ → ℂ) n‖ = |c n| * ‖(x : ℕ → ℂ) n‖ := by
    rw [diagLin_apply]; simp [Complex.norm_real]
  have hle : |c n| * ‖(x : ℕ → ℂ) n‖ ≤ ‖(x : ℕ → ℂ) n‖ := by
    nlinarith [abs_nonneg (c n), hc n, norm_nonneg ((x : ℕ → ℂ) n)]
  rw [h1, show (2 : ℝ≥0∞).toReal = 2 by norm_num]
  exact Real.rpow_le_rpow (by positivity) hle (by norm_num)

/-- The diagonal operator as a bounded operator, of norm at most one. -/
noncomputable def diagCLM {c : ℕ → ℝ} (hc : ∀ n, |c n| ≤ 1) : ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ) :=
  (diagLin hc).mkContinuous 1 (by simpa using diagLin_norm_le hc)

@[simp] theorem diagCLM_apply {c : ℕ → ℝ} (hc : ∀ n, |c n| ≤ 1) (x : ℓ²(ℕ, ℂ)) (n : ℕ) :
    ((diagCLM hc x : ℓ²(ℕ, ℂ)) : ℕ → ℂ) n = (c n : ℂ) * x n := rfl

theorem diagCLM_norm_apply_le {c : ℕ → ℝ} (hc : ∀ n, |c n| ≤ 1) (x : ℓ²(ℕ, ℂ)) :
    ‖diagCLM hc x‖ ≤ ‖x‖ := diagLin_norm_le hc x

theorem diagCLM_symmetric {c : ℕ → ℝ} (hc : ∀ n, |c n| ≤ 1) (x y : ℓ²(ℕ, ℂ)) :
    (inner ℂ (diagCLM hc x) y : ℂ) = inner ℂ x (diagCLM hc y) := by
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  congr 1
  funext n
  rw [diagCLM_apply, diagCLM_apply]
  simp [RCLike.inner_apply, map_mul]
  ring

theorem diagCLM_isSelfAdjoint {c : ℕ → ℝ} (hc : ∀ n, |c n| ≤ 1) :
    IsSelfAdjoint (diagCLM hc) :=
  ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric.mpr (diagCLM_symmetric hc)

theorem diagCLM_injective {c : ℕ → ℝ} (hc : ∀ n, |c n| ≤ 1) (hne : ∀ n, c n ≠ 0) :
    Function.Injective (diagCLM hc) := by
  intro x y hxy
  apply lp.ext
  funext n
  have h := congrArg (fun z : ℓ²(ℕ, ℂ) => (z : ℕ → ℂ) n) hxy
  simp only [diagCLM_apply] at h
  have hc0 : (c n : ℂ) ≠ 0 := by exact_mod_cast hne n
  exact mul_left_cancel₀ hc0 h

/-! ### The unbounded example: `A eₙ = n eₙ` on `ℓ²(ℕ, ℂ)` -/

/-- The coefficients `1/(n+1)` of the shift-inverted operator. -/
noncomputable def invCoeff (n : ℕ) : ℝ := 1 / (n + 1)

theorem invCoeff_pos (n : ℕ) : 0 < invCoeff n := by
  have : (0:ℝ) < (n : ℝ) + 1 := by positivity
  simpa [invCoeff] using this

theorem invCoeff_le_one (n : ℕ) : invCoeff n ≤ 1 := by
  have h1 : (1:ℝ) ≤ (n : ℝ) + 1 := by
    have : (0:ℝ) ≤ (n : ℝ) := Nat.cast_nonneg n
    linarith
  rw [invCoeff, div_le_one (by positivity)]
  exact h1

theorem invCoeff_abs_le_one (n : ℕ) : |invCoeff n| ≤ 1 := by
  rw [abs_of_pos (invCoeff_pos n)]
  exact invCoeff_le_one n

theorem invCoeff_ne_zero (n : ℕ) : invCoeff n ≠ 0 := ne_of_gt (invCoeff_pos n)

/-- **The effective (shift-inverted) Hamiltonian of the example**: the bounded
diagonal operator `eₙ ↦ eₙ/(n+1)`. -/
noncomputable def ell2ShiftInvert : ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ) := diagCLM invCoeff_abs_le_one

theorem ell2ShiftInvert_injective : Function.Injective ell2ShiftInvert :=
  diagCLM_injective invCoeff_abs_le_one invCoeff_ne_zero

theorem ell2ShiftInvert_isSelfAdjoint : IsSelfAdjoint ell2ShiftInvert :=
  diagCLM_isSelfAdjoint invCoeff_abs_le_one

/-- The square root coefficients, used to see that `R ≤ 1`. -/
noncomputable def sqrtInvCoeff (n : ℕ) : ℝ := Real.sqrt (invCoeff n)

theorem sqrtInvCoeff_abs_le_one (n : ℕ) : |sqrtInvCoeff n| ≤ 1 := by
  have h0 : 0 ≤ sqrtInvCoeff n := Real.sqrt_nonneg _
  rw [abs_of_nonneg h0, sqrtInvCoeff]
  rw [show (1:ℝ) = Real.sqrt 1 by simp]
  exact Real.sqrt_le_sqrt (invCoeff_le_one n)

theorem ell2ShiftInvert_eq_sq (x : ℓ²(ℕ, ℂ)) :
    ell2ShiftInvert x = diagCLM sqrtInvCoeff_abs_le_one (diagCLM sqrtInvCoeff_abs_le_one x) := by
  apply lp.ext
  funext n
  rw [ell2ShiftInvert, diagCLM_apply, diagCLM_apply, diagCLM_apply, ← mul_assoc]
  congr 1
  rw [← Complex.ofReal_mul]
  norm_cast
  rw [sqrtInvCoeff, Real.mul_self_sqrt (invCoeff_pos n).le]

/-- **The shift-inverted operator is `≤ 1`**, which is what makes the associated
unbounded operator positive. -/
theorem ell2ShiftInvert_le_one (v : ℓ²(ℕ, ℂ)) :
    (1 : ℝ) * ‖ell2ShiftInvert v‖ ^ 2 ≤ (inner ℂ (ell2ShiftInvert v) v : ℂ).re := by
  set S := diagCLM sqrtInvCoeff_abs_le_one with hS
  have hsq : ell2ShiftInvert v = S (S v) := ell2ShiftInvert_eq_sq v
  have hinner : (inner ℂ (ell2ShiftInvert v) v : ℂ) = inner ℂ (S v) (S v) := by
    rw [hsq]
    exact diagCLM_symmetric sqrtInvCoeff_abs_le_one (S v) v
  have hre : (inner ℂ (ell2ShiftInvert v) v : ℂ).re = ‖S v‖ ^ 2 := by
    rw [hinner, inner_self_eq_norm_sq_to_K]
    simp [← Complex.ofReal_pow]
  have hnorm : ‖ell2ShiftInvert v‖ ≤ ‖S v‖ := by
    rw [hsq]
    exact diagCLM_norm_apply_le sqrtInvCoeff_abs_le_one (S v)
  rw [hre, one_mul]
  nlinarith [norm_nonneg (ell2ShiftInvert v), norm_nonneg (S v)]

/-- **The unbounded Hamiltonian of the example**: `A = R⁻¹ − 1`, i.e. `A eₙ = n eₙ`,
on the domain `range R = {x : ∑ (n+1)²|xₙ|² < ∞}`. -/
noncomputable def ell2UnboundedExample :
    LinearMap.range (ell2ShiftInvert : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ)) →ₗ[ℂ] ℓ²(ℕ, ℂ) :=
  invShiftOperator ell2ShiftInvert ell2ShiftInvert_injective 1

theorem ell2UnboundedExample_isShiftInvert :
    IsShiftInvert ell2UnboundedExample 1 ell2ShiftInvert :=
  isShiftInvert_invShiftOperator ell2ShiftInvert ell2ShiftInvert_injective 1

/-- The `k`-th basis vector of `ℓ²(ℕ, ℂ)` is in the range of `R`: indeed
`R ((k+1) eₖ) = eₖ`. -/
theorem ell2ShiftInvert_smul_single (k : ℕ) :
    ell2ShiftInvert (((k : ℂ) + 1) • lp.single 2 k (1 : ℂ)) = lp.single 2 k (1 : ℂ) := by
  apply lp.ext
  funext n
  rw [ell2ShiftInvert, diagCLM_apply]
  by_cases hn : n = k
  · subst hn
    have hne : ((n : ℂ) + 1) ≠ 0 := by
      rw [show ((n : ℂ) + 1) = (((n + 1 : ℕ) : ℂ)) by push_cast; ring]
      exact_mod_cast Nat.succ_ne_zero n
    have hcoe : ((invCoeff n : ℝ) : ℂ) = ((n : ℂ) + 1)⁻¹ := by
      rw [invCoeff]
      push_cast
      rw [one_div]
    simp only [lp.coeFn_smul, Pi.smul_apply, lp.single_apply, Pi.single_eq_same, hcoe,
      smul_eq_mul, mul_one]
    field_simp
  · simp [lp.single_apply, Pi.single_eq_of_ne hn]

theorem ell2Basis_apply (k : ℕ) : (ell2Basis k : ℓ²(ℕ, ℂ)) = lp.single 2 k (1 : ℂ) :=
  lp.ext_iff.mpr (congrArg Subtype.val (HilbertBasis.repr_self ell2Basis k))

theorem ell2Basis_mem_range (k : ℕ) :
    (ell2Basis k : ℓ²(ℕ, ℂ))
      ∈ LinearMap.range (ell2ShiftInvert : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ)) :=
  ⟨((k : ℂ) + 1) • lp.single 2 k (1 : ℂ), by
    rw [ell2Basis_apply]; exact ell2ShiftInvert_smul_single k⟩

/-- The finite-mode (Hermite-type) domain sits inside the domain of the
unbounded operator, so the algorithm's matrix elements are all defined. -/
theorem finiteModeDomain_le_range :
    finiteModeDomain ell2Basis
      ≤ LinearMap.range (ell2ShiftInvert : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ)) := by
  rw [finiteModeDomain, Submodule.span_le]
  rintro _ ⟨k, rfl⟩
  exact ell2Basis_mem_range k

/-- **The matrix the algorithm is given**: the unbounded operator restricted to
finite linear combinations of basis vectors. -/
noncomputable def ell2ExampleMatrix : finiteModeDomain ell2Basis →ₗ[ℂ] ℓ²(ℕ, ℂ) :=
  ell2UnboundedExample.comp (Submodule.inclusion finiteModeDomain_le_range)

/-- **The example is a positive self-adjoint (Friedrichs) extension of its
matrix** — with no boundedness anywhere. -/
theorem ell2Example_isPositiveSelfAdjointExtension :
    IsPositiveSelfAdjointExtension ell2ExampleMatrix ell2UnboundedExample :=
  invShiftOperator_isPositiveSelfAdjointExtension ell2ShiftInvert ell2ShiftInvert_injective 1
    ell2ShiftInvert_isSelfAdjoint ell2ShiftInvert_le_one finiteModeDomain_le_range
    ell2ExampleMatrix (fun _ => rfl)

theorem norm_single_one (k : ℕ) : ‖(lp.single 2 k (1 : ℂ) : ℓ²(ℕ, ℂ))‖ = 1 := by
  rw [lp.norm_single (by norm_num)]
  simp

/-- **The example really is unbounded**: the matrix elements the algorithm is
fed satisfy no bound `‖Hx‖ ≤ C‖x‖`, because `H eₖ = k eₖ`.  So the boundedness
hypothesis of `hermiteGalerkin_selects_friedrichs` fails here, while the
shift-invert theorems apply. -/
theorem ell2ExampleMatrix_unbounded (C : ℝ) :
    ∃ x : finiteModeDomain ell2Basis, C * ‖(x : ℓ²(ℕ, ℂ))‖ < ‖ell2ExampleMatrix x‖ := by
  obtain ⟨k, hk⟩ := exists_nat_gt C
  have hmem : (lp.single 2 k (1 : ℂ) : ℓ²(ℕ, ℂ)) ∈ finiteModeDomain ell2Basis := by
    rw [← ell2Basis_apply]
    exact Submodule.subset_span ⟨k, rfl⟩
  refine ⟨⟨lp.single 2 k (1 : ℂ), hmem⟩, ?_⟩
  have hrange : (lp.single 2 k (1 : ℂ) : ℓ²(ℕ, ℂ))
      ∈ LinearMap.range (ell2ShiftInvert : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ)) :=
    finiteModeDomain_le_range hmem
  have hpre : preim ell2ShiftInvert ⟨lp.single 2 k (1 : ℂ), hrange⟩
      = ((k : ℂ) + 1) • lp.single 2 k (1 : ℂ) :=
    preim_eq _ ell2ShiftInvert_injective _ (ell2ShiftInvert_smul_single k)
  have hval : ell2ExampleMatrix ⟨lp.single 2 k (1 : ℂ), hmem⟩
      = (k : ℂ) • lp.single 2 k (1 : ℂ) := by
    change ell2UnboundedExample ⟨lp.single 2 k (1 : ℂ), hrange⟩ = _
    rw [ell2UnboundedExample, invShiftOperator_apply, hpre]
    push_cast
    module
  rw [hval, norm_smul, norm_single_one]
  simp only [mul_one, Complex.norm_natCast]
  exact hk

/-- **The Hashimoto/Galerkin selection theorem for a genuinely unbounded
Hamiltonian.**  For the operator `A eₙ = n eₙ` on `ℓ²(ℕ, ℂ)` — unbounded, by the
last clause — with shift `γ = 1`:

* the effective (shift-inverted) Hamiltonian `R = (A+1)⁻¹` is a bounded
  self-adjoint operator of norm at most one;
* its Galerkin truncations, and their resolvents, converge strongly to it;
* `R` determines the domain (and hence the operator): no other self-adjoint
  operator has the same shift-invert.

So the bounded convergence theory of the Galerkin truncation does reach the
unbounded Hamiltonian, through the shift-invert. -/
theorem hashimoto_shiftInvert_unbounded_example :
    IsShiftInvert ell2UnboundedExample 1 ell2ShiftInvert ∧
    ‖ell2ShiftInvert‖ ≤ 1 ∧ IsSelfAdjoint ell2ShiftInvert ∧
    (∀ u : ℓ²(ℕ, ℂ), Tendsto
      (fun m : ℕ => galerkinCompression ell2ShiftInvert ell2Basis m u) atTop
        (nhds (ell2ShiftInvert u))) ∧
    (∀ z : ℂ, z.im ≠ 0 → ∀ u : ℓ²(ℕ, ℂ), Tendsto
      (fun m : ℕ => resolvent (galerkinCompression ell2ShiftInvert ell2Basis m) z u) atTop
        (nhds (resolvent ell2ShiftInvert z u))) ∧
    (∀ (Dom' : Submodule ℂ (ℓ²(ℕ, ℂ))) (A' : Dom' →ₗ[ℂ] ℓ²(ℕ, ℂ)),
      IsShiftInvert A' 1 ell2ShiftInvert →
      Dom' = LinearMap.range (ell2ShiftInvert : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ))) ∧
    (∀ C : ℝ, ∃ x : finiteModeDomain ell2Basis,
      C * ‖(x : ℓ²(ℕ, ℂ))‖ < ‖ell2ExampleMatrix x‖) := by
  obtain ⟨R, hR, hnorm, hsa, -, hstrong, hres, huniq⟩ :=
    hashimoto_shiftInvert_selects_friedrichs ell2Basis ell2ExampleMatrix ell2UnboundedExample
      ell2Example_isPositiveSelfAdjointExtension (γ := 1) one_pos
  have hReq : R = ell2ShiftInvert :=
    isShiftInvert_unique hR ell2UnboundedExample_isShiftInvert
  subst hReq
  refine ⟨hR, by simpa only [inv_one] using hnorm, hsa, hstrong, hres, ?_,
    ell2ExampleMatrix_unbounded⟩
  intro Dom' A' hA'
  exact (huniq Dom' A' hA').1

end Example

end BookProof.HashimotoShiftInvert
