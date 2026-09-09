import Mathlib
import BookProof.ChapterNavierStokesIkebeKato

/-!
# A non-commuting Hamiltonian to which the criterion applies

`BookProof.ChapterNavierStokesIkebeKato` proves that a symmetric operator `H` on
the maximal domain of the comparison operator `N` (multiplication by a
non-negative momentum symbol) is essentially self-adjoint on the finite-mode core
as soon as it satisfies the two Faris–Lavine inequalities.  This module verifies
that those hypotheses are met by a genuinely **unbounded** Hamiltonian whose
commutator with `N` does **not** vanish, so the criterion is not applied
vacuously:

`H = N + B`, where `B x = ⟪u, x⟫ w + ⟪w, x⟫ u` is the symmetric rank-`≤ 2`
operator built from two states `u, w` of the maximal domain.

* `rankTwo_symmetric`, `rankTwo_norm_le` — `B` is symmetric and bounded by
  `2‖u‖‖w‖`;
* `pertHam_symmetricOn`, `pertHam_relative_bound`, `pertHam_commForm_bound` — the
  two Faris–Lavine inequalities, the second one because
  `⟪w, N x⟫ = ⟪N w, x⟫` for `w` in the maximal domain, so the commutator form is
  bounded by a multiple of `‖x‖² ≤ ⟪x, N x⟫`;
* `pertHam_essentiallySelfAdjointOn_core` — hence `N + B` is essentially
  self-adjoint on the finite-mode core;
* `exists_commForm_ne_zero` — and the commutator form of the pair really is
  non-zero: with the symbol `c(k) = k + 1` and `u = e₀`, `w = e₁` one has
  `⟪x, i[H, N] x⟫ = −2` at `x = e₀ + i e₁`.
-/

namespace BookProof.NavierStokesFlow

namespace MomentumPerturbation

open LpNat FarisLavine IkebeKato

variable {ι : Type*}

/-! ## The symmetric rank-two perturbation -/

/-- The symmetric rank-`≤ 2` operator `B x = ⟪u, x⟫ w + ⟪w, x⟫ u`. -/
noncomputable def rankTwo (u w : L2I ι) : L2I ι →ₗ[ℂ] L2I ι where
  toFun x := (inner ℂ u x : ℂ) • w + (inner ℂ w x : ℂ) • u
  map_add' x y := by
    simp only [inner_add_right, add_smul]
    abel
  map_smul' a x := by
    simp only [inner_smul_right, smul_smul, RingHom.id_apply, smul_add]

@[simp] theorem rankTwo_apply (u w : L2I ι) (x : L2I ι) :
    rankTwo u w x = (inner ℂ u x : ℂ) • w + (inner ℂ w x : ℂ) • u := rfl

theorem rankTwo_symmetric (u w x y : L2I ι) :
    (inner ℂ (rankTwo u w x) y : ℂ) = inner ℂ x (rankTwo u w y) := by
  simp only [rankTwo_apply, inner_add_left, inner_add_right, inner_smul_left, inner_smul_right]
  rw [inner_conj_symm, inner_conj_symm]
  ring

theorem rankTwo_norm_le (u w x : L2I ι) : ‖rankTwo u w x‖ ≤ 2 * (‖u‖ * ‖w‖) * ‖x‖ := by
  refine le_trans (norm_add_le _ _) ?_
  rw [norm_smul, norm_smul]
  have h1 : ‖(inner ℂ u x : ℂ)‖ ≤ ‖u‖ * ‖x‖ := norm_inner_le_norm u x
  have h2 : ‖(inner ℂ w x : ℂ)‖ ≤ ‖w‖ * ‖x‖ := norm_inner_le_norm w x
  nlinarith [norm_nonneg u, norm_nonneg w, norm_nonneg x,
    mul_nonneg (norm_nonneg u) (norm_nonneg x), mul_nonneg (norm_nonneg w) (norm_nonneg x)]

/-! ## The perturbed Hamiltonian `H = N + B` -/

/-- The perturbed Hamiltonian `H = N + B` on the maximal domain of `N`. -/
noncomputable def pertHam (c : ι → ℝ) (u w : L2I ι) : maxDom c →ₗ[ℂ] L2I ι :=
  diagMax c + (rankTwo u w).comp (maxDom c).subtype

@[simp] theorem pertHam_apply (c : ι → ℝ) (u w : L2I ι) (x : maxDom c) :
    pertHam c u w x = diagMax c x + rankTwo u w (x : L2I ι) := rfl

theorem pertHam_symmetricOn (c : ι → ℝ) (u w : L2I ι) :
    SymmetricOn (maxDom c) (pertHam c u w) := by
  intro x y
  simp only [pertHam_apply, inner_add_left, inner_add_right]
  rw [diagMax_symmetricOn c x y, rankTwo_symmetric u w (x : L2I ι) (y : L2I ι)]

/-- **The relative bound** `‖H x‖² ≤ 2‖N x‖² + 2M²‖x‖²`, with `M = 2‖u‖‖w‖`. -/
theorem pertHam_relative_bound (c : ι → ℝ) (u w : L2I ι) (x : maxDom c) :
    ‖pertHam c u w x‖ ^ 2
      ≤ 2 * ‖diagMax c x‖ ^ 2 + (2 * (2 * (‖u‖ * ‖w‖)) ^ 2) * ‖(x : L2I ι)‖ ^ 2 := by
  have htri : ‖pertHam c u w x‖ ≤ ‖diagMax c x‖ + ‖rankTwo u w (x : L2I ι)‖ := by
    rw [pertHam_apply]
    exact norm_add_le _ _
  have hB := rankTwo_norm_le u w ((x : L2I ι))
  have hM : (0 : ℝ) ≤ 2 * (‖u‖ * ‖w‖) := by positivity
  nlinarith [norm_nonneg (pertHam c u w x), norm_nonneg (diagMax c x),
    norm_nonneg (rankTwo u w ((x : L2I ι))), norm_nonneg ((x : L2I ι)),
    sq_nonneg (‖diagMax c x‖ - ‖rankTwo u w ((x : L2I ι))‖),
    mul_nonneg hM (norm_nonneg ((x : L2I ι)))]

/-- **The commutator form bound.**  For `u, w` in the maximal domain the identity
`⟪u, N x⟫ = ⟪N u, x⟫` turns the commutator form into an expression bounded by a
multiple of `‖x‖²`, which for a symbol `≥ 1` is at most `⟪x, N x⟫`. -/
theorem pertHam_commForm_bound (c : ι → ℝ) (hc : ∀ k, 1 ≤ c k) (u w : maxDom c)
    (x : maxDom c) :
    |commForm (pertHam c (u : L2I ι) (w : L2I ι)) (diagMax c) x|
      ≤ (2 * (‖(u : L2I ι)‖ * ‖diagMax c w‖ + ‖(w : L2I ι)‖ * ‖diagMax c u‖))
        * quadForm (diagMax c) x := by
  have hdiag : (inner ℂ (diagMax c x) (diagMax c x) : ℂ).im = 0 := by
    simpa using inner_self_im (𝕜 := ℂ) ((diagMax c x))
  have hsplit : (inner ℂ (pertHam c (u : L2I ι) (w : L2I ι) x) (diagMax c x) : ℂ).im
      = (inner ℂ (rankTwo (u : L2I ι) (w : L2I ι) (x : L2I ι)) (diagMax c x) : ℂ).im := by
    rw [pertHam_apply, inner_add_left, Complex.add_im, hdiag, zero_add]
  have hu : (inner ℂ ((u : L2I ι)) (diagMax c x) : ℂ) = inner ℂ (diagMax c u) ((x : L2I ι)) :=
    (diagMax_symmetricOn c u x).symm
  have hw : (inner ℂ ((w : L2I ι)) (diagMax c x) : ℂ) = inner ℂ (diagMax c w) ((x : L2I ι)) :=
    (diagMax_symmetricOn c w x).symm
  have hexp : (inner ℂ (rankTwo (u : L2I ι) (w : L2I ι) (x : L2I ι)) (diagMax c x) : ℂ)
      = (starRingEnd ℂ) (inner ℂ ((u : L2I ι)) ((x : L2I ι)) : ℂ)
          * inner ℂ (diagMax c w) ((x : L2I ι))
        + (starRingEnd ℂ) (inner ℂ ((w : L2I ι)) ((x : L2I ι)) : ℂ)
          * inner ℂ (diagMax c u) ((x : L2I ι)) := by
    simp only [rankTwo_apply, inner_add_left, inner_smul_left]
    rw [hu, hw]
  have hbound : ‖(inner ℂ (rankTwo (u : L2I ι) (w : L2I ι) (x : L2I ι)) (diagMax c x) : ℂ)‖
      ≤ (‖(u : L2I ι)‖ * ‖diagMax c w‖ + ‖(w : L2I ι)‖ * ‖diagMax c u‖)
        * ‖(x : L2I ι)‖ ^ 2 := by
    rw [hexp]
    refine le_trans (norm_add_le _ _) ?_
    rw [norm_mul, norm_mul, RCLike.norm_conj, RCLike.norm_conj]
    have h1 : ‖(inner ℂ ((u : L2I ι)) ((x : L2I ι)) : ℂ)‖ ≤ ‖(u : L2I ι)‖ * ‖(x : L2I ι)‖ :=
      norm_inner_le_norm _ _
    have h2 : ‖(inner ℂ (diagMax c w) ((x : L2I ι)) : ℂ)‖ ≤ ‖diagMax c w‖ * ‖(x : L2I ι)‖ :=
      norm_inner_le_norm _ _
    have h3 : ‖(inner ℂ ((w : L2I ι)) ((x : L2I ι)) : ℂ)‖ ≤ ‖(w : L2I ι)‖ * ‖(x : L2I ι)‖ :=
      norm_inner_le_norm _ _
    have h4 : ‖(inner ℂ (diagMax c u) ((x : L2I ι)) : ℂ)‖ ≤ ‖diagMax c u‖ * ‖(x : L2I ι)‖ :=
      norm_inner_le_norm _ _
    nlinarith [norm_nonneg (inner ℂ ((u : L2I ι)) ((x : L2I ι)) : ℂ),
      norm_nonneg (inner ℂ (diagMax c w) ((x : L2I ι)) : ℂ),
      norm_nonneg (inner ℂ ((w : L2I ι)) ((x : L2I ι)) : ℂ),
      norm_nonneg (inner ℂ (diagMax c u) ((x : L2I ι)) : ℂ),
      norm_nonneg ((x : L2I ι)), norm_nonneg ((u : L2I ι)), norm_nonneg ((w : L2I ι)),
      norm_nonneg (diagMax c w), norm_nonneg (diagMax c u),
      mul_nonneg (norm_nonneg ((u : L2I ι))) (norm_nonneg ((x : L2I ι))),
      mul_nonneg (norm_nonneg (diagMax c w)) (norm_nonneg ((x : L2I ι))),
      mul_nonneg (norm_nonneg ((w : L2I ι))) (norm_nonneg ((x : L2I ι))),
      mul_nonneg (norm_nonneg (diagMax c u)) (norm_nonneg ((x : L2I ι)))]
  have hquad : ‖(x : L2I ι)‖ ^ 2 ≤ quadForm (diagMax c) x :=
    diagMax_quadForm_ge_norm_sq c hc x
  have him : |(inner ℂ (rankTwo (u : L2I ι) (w : L2I ι) (x : L2I ι)) (diagMax c x) : ℂ).im|
      ≤ (‖(u : L2I ι)‖ * ‖diagMax c w‖ + ‖(w : L2I ι)‖ * ‖diagMax c u‖)
        * ‖(x : L2I ι)‖ ^ 2 :=
    le_trans (Complex.abs_im_le_norm _) hbound
  have hcnn : (0 : ℝ) ≤ ‖(u : L2I ι)‖ * ‖diagMax c w‖ + ‖(w : L2I ι)‖ * ‖diagMax c u‖ := by
    positivity
  rw [commForm_eq, hsplit, abs_mul]
  have habs : |(-2 : ℝ)| = 2 := by norm_num
  rw [habs]
  nlinarith [him, hquad, hcnn, sq_nonneg ‖(x : L2I ι)‖]

/-- **The perturbed Hamiltonian is essentially self-adjoint on the finite-mode
core.**  `H = N + B` is unbounded (as soon as the symbol is), does not commute
with `N`, and is covered by the criterion of
`BookProof.NavierStokesFlow.IkebeKato`. -/
theorem pertHam_essentiallySelfAdjointOn_core (c : ι → ℝ) (hc : ∀ k, 1 ≤ c k)
    (u w : maxDom c) :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((pertHam c (u : L2I ι) (w : L2I ι)).comp
        (Submodule.inclusion (finiteModes_le_maxDom c))) := by
  refine essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds c
    (fun k => le_trans zero_le_one (hc k)) (pertHam c (u : L2I ι) (w : L2I ι))
    2 (2 * (2 * (‖(u : L2I ι)‖ * ‖(w : L2I ι)‖)) ^ 2)
    (2 * (‖(u : L2I ι)‖ * ‖diagMax c w‖ + ‖(w : L2I ι)‖ * ‖diagMax c u‖))
    (pertHam_symmetricOn c _ _) (by positivity)
    (pertHam_relative_bound c _ _) (pertHam_commForm_bound c hc u w)

/-! ## The commutator really does not vanish -/

section Witness

/-- The symbol `c(k) = k + 1`: unbounded, and `≥ 1`. -/
def linSymbol : ℕ → ℝ := fun k => (k : ℝ) + 1

theorem linSymbol_ge_one (k : ℕ) : 1 ≤ linSymbol k := by
  simp only [linSymbol]
  linarith [Nat.cast_nonneg (α := ℝ) k]

/-- The two states of the perturbation, and the test state. -/
noncomputable def eState (k : ℕ) : L2I ℕ := lp.single 2 k (1 : ℂ)

theorem eState_mem_maxDom (k : ℕ) : eState k ∈ maxDom linSymbol :=
  finiteModes_le_maxDom linSymbol (lpSingle_mem_lpFiniteModes k (1 : ℂ))

noncomputable def testState : L2I ℕ := lp.single 2 0 (1 : ℂ) + lp.single 2 1 Complex.I

theorem testState_mem_maxDom : testState ∈ maxDom linSymbol :=
  finiteModes_le_maxDom linSymbol
    (Submodule.add_mem _ (lpSingle_mem_lpFiniteModes 0 (1 : ℂ))
      (lpSingle_mem_lpFiniteModes 1 Complex.I))

theorem testState_coe_zero : (testState : ℕ → ℂ) 0 = 1 := by
  simp [testState, lp.single_apply]

theorem testState_coe_one : (testState : ℕ → ℂ) 1 = Complex.I := by
  simp [testState, lp.single_apply]

/-- **The commutator form of the pair `(H, N)` is not identically zero.**  With
`c(k) = k + 1`, `u = e₀`, `w = e₁` and `x = e₀ + i e₁` one finds
`⟪x, i[H, N] x⟫ = −2`; the essential self-adjointness of
`pertHam_essentiallySelfAdjointOn_core` is therefore a genuine application of the
Faris–Lavine criterion and not the commuting case in disguise. -/
theorem commForm_witness_eq_neg_two :
    commForm (pertHam linSymbol (eState 0) (eState 1)) (diagMax linSymbol)
      ⟨testState, testState_mem_maxDom⟩ = -2 := by
  classical
  set x : maxDom linSymbol := ⟨testState, testState_mem_maxDom⟩ with hx
  have hxu : (inner ℂ (eState 0) ((x : L2I ℕ)) : ℂ) = 1 := by
    rw [hx]
    simp only [eState]
    rw [lp.inner_single_left]
    simp [testState_coe_zero]
  have hxw : (inner ℂ (eState 1) ((x : L2I ℕ)) : ℂ) = Complex.I := by
    rw [hx]
    simp only [eState]
    rw [lp.inner_single_left]
    simp [testState_coe_one]
  have hNu : (inner ℂ (eState 0) (diagMax linSymbol x) : ℂ) = 1 := by
    simp only [eState]
    rw [lp.inner_single_left]
    simp only [RCLike.inner_apply, map_one]
    rw [diagMax_coe]
    simp [hx, testState_coe_zero, linSymbol]
  have hNw : (inner ℂ (eState 1) (diagMax linSymbol x) : ℂ) = 2 * Complex.I := by
    simp only [eState]
    rw [lp.inner_single_left]
    simp only [RCLike.inner_apply, map_one]
    rw [diagMax_coe]
    simp [hx, testState_coe_one, linSymbol]
    ring
  have hdiag : (inner ℂ (diagMax linSymbol x) (diagMax linSymbol x) : ℂ).im = 0 := by
    simpa using inner_self_im (𝕜 := ℂ) ((diagMax linSymbol x))
  have hexp : (inner ℂ (pertHam linSymbol (eState 0) (eState 1) x)
      (diagMax linSymbol x) : ℂ) = (inner ℂ (diagMax linSymbol x) (diagMax linSymbol x) : ℂ)
        + ((starRingEnd ℂ) (inner ℂ (eState 0) ((x : L2I ℕ)) : ℂ)
            * inner ℂ (eState 1) (diagMax linSymbol x)
          + (starRingEnd ℂ) (inner ℂ (eState 1) ((x : L2I ℕ)) : ℂ)
            * inner ℂ (eState 0) (diagMax linSymbol x)) := by
    rw [pertHam_apply, inner_add_left]
    congr 1
    simp only [rankTwo_apply, inner_add_left, inner_smul_left]
  rw [commForm_eq, hexp, Complex.add_im, hdiag, zero_add, hxu, hxw, hNu, hNw]
  simp
  norm_num

theorem norm_eState (k : ℕ) : ‖eState k‖ = 1 := by
  have h : ‖(eState k : L2I ℕ)‖ = ‖(1 : ℂ)‖ := lp.norm_single (by norm_num) k 1
  simpa using h

theorem diagMax_eState (k : ℕ) :
    (diagMax linSymbol ⟨eState k, eState_mem_maxDom k⟩ : L2I ℕ)
      = ((linSymbol k : ℂ)) • eState k := by
  classical
  refine lp.ext (funext fun j => ?_)
  rw [diagMax_coe]
  simp only [eState, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, lp.single_apply, Pi.single_apply]
  by_cases hjk : j = k
  · subst hjk; simp
  · simp [hjk]

/-- The perturbed Hamiltonian is genuinely **unbounded**: essential
self-adjointness here is not a boundedness phenomenon. -/
theorem pertHam_not_bounded :
    ¬ ∃ C : ℝ, ∀ x : maxDom linSymbol,
      ‖pertHam linSymbol (eState 0) (eState 1) x‖ ≤ C * ‖(x : L2I ℕ)‖ := by
  rintro ⟨C, hC⟩
  obtain ⟨k, hk⟩ := exists_nat_gt (C + 2)
  have hx := hC ⟨eState k, eState_mem_maxDom k⟩
  have hnorm : ‖((⟨eState k, eState_mem_maxDom k⟩ : maxDom linSymbol) : L2I ℕ)‖ = 1 :=
    norm_eState k
  rw [hnorm, mul_one, pertHam_apply] at hx
  have hlow : ‖(diagMax linSymbol ⟨eState k, eState_mem_maxDom k⟩ : L2I ℕ)‖
      ≤ ‖(diagMax linSymbol ⟨eState k, eState_mem_maxDom k⟩ : L2I ℕ)
          + rankTwo (eState 0) (eState 1) (eState k)‖
        + ‖rankTwo (eState 0) (eState 1) (eState k)‖ := by
    calc ‖(diagMax linSymbol ⟨eState k, eState_mem_maxDom k⟩ : L2I ℕ)‖
        = ‖((diagMax linSymbol ⟨eState k, eState_mem_maxDom k⟩ : L2I ℕ)
            + rankTwo (eState 0) (eState 1) (eState k))
            - rankTwo (eState 0) (eState 1) (eState k)‖ := by
          rw [add_sub_cancel_right]
      _ ≤ ‖(diagMax linSymbol ⟨eState k, eState_mem_maxDom k⟩ : L2I ℕ)
            + rankTwo (eState 0) (eState 1) (eState k)‖
          + ‖rankTwo (eState 0) (eState 1) (eState k)‖ := norm_sub_le _ _
  have hdiagnorm : ‖(diagMax linSymbol ⟨eState k, eState_mem_maxDom k⟩ : L2I ℕ)‖
      = (k : ℝ) + 1 := by
    rw [diagMax_eState, norm_smul, norm_eState, mul_one]
    simp only [linSymbol, Complex.norm_real, Real.norm_eq_abs]
    exact abs_of_nonneg (by positivity)
  have hpert : ‖rankTwo (eState 0) (eState 1) (eState k)‖ ≤ 2 := by
    have h := rankTwo_norm_le (eState 0) (eState 1) (eState k)
    rw [norm_eState, norm_eState, norm_eState] at h
    linarith
  rw [hdiagnorm] at hlow
  linarith

/-- In particular the pair `(H, N)` does not commute in the form sense. -/
theorem exists_commForm_ne_zero :
    ∃ x : maxDom linSymbol,
      commForm (pertHam linSymbol (eState 0) (eState 1)) (diagMax linSymbol) x ≠ 0 :=
  ⟨⟨testState, testState_mem_maxDom⟩, by rw [commForm_witness_eq_neg_two]; norm_num⟩

end Witness

end MomentumPerturbation

end BookProof.NavierStokesFlow
