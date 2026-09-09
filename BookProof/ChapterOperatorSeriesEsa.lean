import Mathlib
import BookProof.ChapterNavierStokesIkebeKato

/-!
# Summable series of symmetric operators, and the Faris–Lavine bounds

The Faris–Lavine (Nelson commutator) route to essential self-adjointness needs two
inequalities relative to a positive comparison operator `N`: a relative bound
`‖H x‖ ≤ A‖N x‖` and a commutator-form bound `|⟪x, i[H, N]x⟫| ≤ B⟪x, N x⟫`.  Both are
*additive*, and both survive an **infinite sum** of operators as soon as the two
constants are summable.  That is exactly what a second-quantized Hamiltonian with
infinitely many modes is: a sum over the modes (or over pairs of modes) of elementary
operators, each individually controlled by the number operator.

This module isolates that step, once and for all, on `ℓ²(ι)` with the multiplication
comparison operator `N = diagMax c` of
`BookProof.ChapterNavierStokesIkebeKato`.

## What is proved

* `commForm_eq_neg_two_im` — the commutator form is `-2 Im⟪H x, N x⟫`; in particular it
  is additive in `H`.
* `seriesOp` — the sum `∑' k, T k` of a family of operators on the maximal domain of a
  symbol, well defined as soon as the relative bounds are summable.
* `seriesOp_symmetricOn`, `seriesOp_norm_le`, `seriesOp_commForm_le` — the three
  properties pass to the sum, with the summed constants.
* `essentiallySelfAdjointOn_finiteModes_of_bounds` — the packaging of the Faris–Lavine
  criterion in the "relative bound + commutator bound" form used here.
* `essentiallySelfAdjointOn_finiteModes_of_series` — **the instrument**: a summable
  family of symmetric operators, each relatively bounded by the comparison operator and
  with commutator form dominated by it, sums to an operator which is essentially
  self-adjoint on the finite-mode core.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.OperatorSeries

open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat

noncomputable section

/-! ## 1. The commutator form as an imaginary part -/

section CommForm

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

/-- The commutator form `⟪x, i[H, N]x⟫` is `-2 Im⟪H x, N x⟫`. -/
theorem commForm_eq_neg_two_im (H N : D →ₗ[ℂ] F) (x : D) :
    commForm H N x = -2 * (inner ℂ (H x) (N x) : ℂ).im := by
  have hconj : (inner ℂ (N x) (H x) : ℂ) = (starRingEnd ℂ) (inner ℂ (H x) (N x) : ℂ) :=
    (inner_conj_symm (𝕜 := ℂ) _ _).symm
  rw [commForm, hconj]
  set z : ℂ := (inner ℂ (H x) (N x) : ℂ) with hz
  have : Complex.I * (z - (starRingEnd ℂ) z) = -2 * (z.im : ℂ) := by
    rw [Complex.sub_conj]
    push_cast
    rw [mul_comm]
    ring_nf
    rw [Complex.I_sq]
    ring
  rw [this]
  simp

/-- The commutator form is additive in the operator. -/
theorem commForm_add (H₁ H₂ N : D →ₗ[ℂ] F) (x : D) :
    commForm (H₁ + H₂) N x = commForm H₁ N x + commForm H₂ N x := by
  rw [commForm_eq_neg_two_im, commForm_eq_neg_two_im, commForm_eq_neg_two_im]
  have : (H₁ + H₂) x = H₁ x + H₂ x := rfl
  rw [this, inner_add_left]
  simp [Complex.add_im]
  ring

end CommForm

/-! ## 2. The series of operators -/

section Series

variable {ι κ : Type*} {c : ι → ℝ}

variable (T : κ → (maxDom c →ₗ[ℂ] L2I ι)) (a : κ → ℝ)

/-- Summability of the family `k ↦ T k x`, from the summable relative bounds. -/
theorem summable_apply
    (hnorm : ∀ (k : κ) (x : maxDom c), ‖(T k x : L2I ι)‖ ≤ a k * ‖(diagMax c x : L2I ι)‖)
    (ha : Summable a) (x : maxDom c) : Summable fun k => (T k x : L2I ι) := by
  refine Summable.of_norm_bounded (g := fun k => a k * ‖(diagMax c x : L2I ι)‖) ?_ ?_
  · exact ha.mul_right _
  · intro k; exact hnorm k x

/-- **The sum of a summable family of operators.** -/
def seriesOp
    (hnorm : ∀ (k : κ) (x : maxDom c), ‖(T k x : L2I ι)‖ ≤ a k * ‖(diagMax c x : L2I ι)‖)
    (ha : Summable a) : maxDom c →ₗ[ℂ] L2I ι where
  toFun x := ∑' k, (T k x : L2I ι)
  map_add' x y := by
    have hx := summable_apply T a hnorm ha x
    have hy := summable_apply T a hnorm ha y
    have hxy : ∀ k, (T k (x + y) : L2I ι) = (T k x : L2I ι) + (T k y : L2I ι) := by
      intro k; rw [map_add]
    simp only [hxy]
    exact Summable.tsum_add hx hy
  map_smul' r x := by
    have hx := summable_apply T a hnorm ha x
    have hxy : ∀ k, (T k (r • x) : L2I ι) = r • (T k x : L2I ι) := by
      intro k; rw [map_smul]
    simp only [hxy, RingHom.id_apply]
    exact tsum_const_smul'' r

variable {T} {a}

theorem seriesOp_apply
    (hnorm : ∀ (k : κ) (x : maxDom c), ‖(T k x : L2I ι)‖ ≤ a k * ‖(diagMax c x : L2I ι)‖)
    (ha : Summable a) (x : maxDom c) :
    (seriesOp T a hnorm ha x : L2I ι) = ∑' k, (T k x : L2I ι) := rfl

theorem seriesOp_hasSum
    (hnorm : ∀ (k : κ) (x : maxDom c), ‖(T k x : L2I ι)‖ ≤ a k * ‖(diagMax c x : L2I ι)‖)
    (ha : Summable a) (x : maxDom c) :
    HasSum (fun k => (T k x : L2I ι)) (seriesOp T a hnorm ha x) :=
  (summable_apply T a hnorm ha x).hasSum

/-- The sum of symmetric operators is symmetric. -/
theorem seriesOp_symmetricOn
    (hnorm : ∀ (k : κ) (x : maxDom c), ‖(T k x : L2I ι)‖ ≤ a k * ‖(diagMax c x : L2I ι)‖)
    (ha : Summable a) (hsym : ∀ k, SymmetricOn (maxDom c) (T k)) :
    SymmetricOn (maxDom c) (seriesOp T a hnorm ha) := by
  intro x y
  have h1 : HasSum (fun k => (inner ℂ (T k x : L2I ι) (y : L2I ι) : ℂ))
      (inner ℂ (seriesOp T a hnorm ha x : L2I ι) (y : L2I ι)) := by
    have h := (innerSL ℂ (y : L2I ι)).hasSum (seriesOp_hasSum hnorm ha x)
    have h2 := h.star
    simpa [inner_conj_symm] using h2
  have h2 : HasSum (fun k => (inner ℂ (x : L2I ι) (T k y : L2I ι) : ℂ))
      (inner ℂ (x : L2I ι) (seriesOp T a hnorm ha y : L2I ι)) :=
    (innerSL ℂ (x : L2I ι)).hasSum (seriesOp_hasSum hnorm ha y)
  have hEq : ∀ k, (inner ℂ (T k x : L2I ι) (y : L2I ι) : ℂ)
      = (inner ℂ (x : L2I ι) (T k y : L2I ι) : ℂ) := fun k => hsym k x y
  simp only [hEq] at h1
  exact h1.unique h2

/-- The relative bound passes to the sum, with the summed constant. -/
theorem seriesOp_norm_le
    (hnorm : ∀ (k : κ) (x : maxDom c), ‖(T k x : L2I ι)‖ ≤ a k * ‖(diagMax c x : L2I ι)‖)
    (ha : Summable a) (x : maxDom c) :
    ‖(seriesOp T a hnorm ha x : L2I ι)‖ ≤ (∑' k, a k) * ‖(diagMax c x : L2I ι)‖ := by
  have hnormsum : Summable fun k => ‖(T k x : L2I ι)‖ :=
    Summable.of_nonneg_of_le (fun k => norm_nonneg _) (fun k => hnorm k x) (ha.mul_right _)
  calc ‖(seriesOp T a hnorm ha x : L2I ι)‖ = ‖∑' k, (T k x : L2I ι)‖ := rfl
    _ ≤ ∑' k, ‖(T k x : L2I ι)‖ := norm_tsum_le_tsum_norm hnormsum
    _ ≤ ∑' k, a k * ‖(diagMax c x : L2I ι)‖ :=
        Summable.tsum_le_tsum (fun k => hnorm k x) hnormsum (ha.mul_right _)
    _ = (∑' k, a k) * ‖(diagMax c x : L2I ι)‖ := by rw [tsum_mul_right]

/-- The commutator-form bound passes to the sum, with the summed constant. -/
theorem seriesOp_commForm_le
    (hnorm : ∀ (k : κ) (x : maxDom c), ‖(T k x : L2I ι)‖ ≤ a k * ‖(diagMax c x : L2I ι)‖)
    (ha : Summable a) {b : κ → ℝ} (hb : Summable b)
    (hcomm : ∀ (k : κ) (x : maxDom c),
      |commForm (T k) (diagMax c) x| ≤ b k * quadForm (diagMax c) x)
    (hq : ∀ x : maxDom c, 0 ≤ quadForm (diagMax c) x) (x : maxDom c) :
    |commForm (seriesOp T a hnorm ha) (diagMax c) x| ≤ (∑' k, b k) * quadForm (diagMax c) x := by
  classical
  set N := diagMax c
  set q : ℝ := quadForm N x with hqdef
  have hq0 : 0 ≤ q := hq x
  -- the inner products sum
  have h1 : HasSum (fun k => (inner ℂ (T k x : L2I ι) (N x : L2I ι) : ℂ))
      (inner ℂ (seriesOp T a hnorm ha x : L2I ι) (N x : L2I ι)) := by
    have h := (innerSL ℂ (N x : L2I ι)).hasSum (seriesOp_hasSum hnorm ha x)
    have h2 := h.star
    simpa [inner_conj_symm] using h2
  have him : HasSum (fun k => (inner ℂ (T k x : L2I ι) (N x : L2I ι) : ℂ).im)
      ((inner ℂ (seriesOp T a hnorm ha x : L2I ι) (N x : L2I ι) : ℂ).im) :=
    (Complex.hasSum_im h1)
  -- each imaginary part is half the commutator form
  have hhalf : ∀ k, |(inner ℂ (T k x : L2I ι) (N x : L2I ι) : ℂ).im| ≤ b k * (q / 2) := by
    intro k
    have h := hcomm k x
    rw [commForm_eq_neg_two_im] at h
    rw [abs_mul] at h
    simp only [abs_neg, abs_two] at h
    linarith [h]
  have hsummable : Summable fun k => |(inner ℂ (T k x : L2I ι) (N x : L2I ι) : ℂ).im| := by
    refine Summable.of_nonneg_of_le (fun k => abs_nonneg _) hhalf ?_
    exact hb.mul_right (q / 2)
  have hbound : |(inner ℂ (seriesOp T a hnorm ha x : L2I ι) (N x : L2I ι) : ℂ).im|
      ≤ ∑' k, b k * (q / 2) := by
    calc |(inner ℂ (seriesOp T a hnorm ha x : L2I ι) (N x : L2I ι) : ℂ).im|
        = |∑' k, (inner ℂ (T k x : L2I ι) (N x : L2I ι) : ℂ).im| := by rw [him.tsum_eq]
      _ ≤ ∑' k, |(inner ℂ (T k x : L2I ι) (N x : L2I ι) : ℂ).im| := by
          have h := norm_tsum_le_tsum_norm
            (f := fun k => (inner ℂ (T k x : L2I ι) (N x : L2I ι) : ℂ).im)
            (by simpa [Real.norm_eq_abs] using hsummable)
          simpa [Real.norm_eq_abs] using h
      _ ≤ ∑' k, b k * (q / 2) :=
          Summable.tsum_le_tsum hhalf hsummable (hb.mul_right (q / 2))
  have hrw : ∑' k, b k * (q / 2) = (∑' k, b k) * q / 2 := by
    rw [hb.tsum_mul_right]; ring
  rw [commForm_eq_neg_two_im, abs_mul]
  simp only [abs_neg, abs_two]
  rw [hrw] at hbound
  linarith [hbound]

end Series

/-! ## 3. The Faris–Lavine payoff -/

section Payoff

variable {ι : Type*} {c : ι → ℝ}

/-- **Essential self-adjointness on the finite-mode core from a relative bound and a
commutator bound.**  A repackaging of
`BookProof.NavierStokesFlow.IkebeKato.essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds`
with the relative bound in unsquared form. -/
theorem essentiallySelfAdjointOn_finiteModes_of_bounds (c : ι → ℝ) (hc : ∀ k, 0 ≤ c k)
    (H : maxDom c →ₗ[ℂ] L2I ι) (A B : ℝ) (hB : 0 ≤ B) (hsym : SymmetricOn (maxDom c) H)
    (hA : ∀ x : maxDom c, ‖(H x : L2I ι)‖ ≤ A * ‖(diagMax c x : L2I ι)‖)
    (hcomm : ∀ x : maxDom c, |commForm H (diagMax c) x| ≤ B * quadForm (diagMax c) x) :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      (H.comp (Submodule.inclusion (finiteModes_le_maxDom c))) := by
  refine essentiallySelfAdjointOn_finiteModes_of_farisLavine_bounds c hc H (A ^ 2) 0 B
    hsym hB ?_ hcomm
  intro x
  have h := hA x
  have h0 : 0 ≤ ‖(H x : L2I ι)‖ := norm_nonneg _
  have hn : 0 ≤ ‖(diagMax c x : L2I ι)‖ := norm_nonneg _
  nlinarith [h, h0, hn, sq_nonneg (A * ‖(diagMax c x : L2I ι)‖)]

/-- **The instrument.**  A summable family of symmetric operators on the maximal domain
of a non-negative symbol, each relatively bounded by the comparison operator and each with
commutator form dominated by it, sums to an operator which is essentially self-adjoint on
the finite-mode core. -/
theorem essentiallySelfAdjointOn_finiteModes_of_series {κ : Type*} (c : ι → ℝ)
    (hc : ∀ k, 0 ≤ c k) (T : κ → (maxDom c →ₗ[ℂ] L2I ι)) (a b : κ → ℝ)
    (hnorm : ∀ (k : κ) (x : maxDom c), ‖(T k x : L2I ι)‖ ≤ a k * ‖(diagMax c x : L2I ι)‖)
    (ha : Summable a) (hb : Summable b) (hb0 : ∀ k, 0 ≤ b k)
    (hsym : ∀ k, SymmetricOn (maxDom c) (T k))
    (hcomm : ∀ (k : κ) (x : maxDom c),
      |commForm (T k) (diagMax c) x| ≤ b k * quadForm (diagMax c) x) :
    EssentiallySelfAdjointOn (lpFiniteModes ι)
      ((seriesOp T a hnorm ha).comp (Submodule.inclusion (finiteModes_le_maxDom c))) := by
  refine essentiallySelfAdjointOn_finiteModes_of_bounds c hc _ (∑' k, a k) (∑' k, b k)
    (tsum_nonneg hb0) (seriesOp_symmetricOn hnorm ha hsym) (seriesOp_norm_le hnorm ha) ?_
  intro x
  exact seriesOp_commForm_le hnorm ha hb hcomm (fun y => diagMax_quadForm_nonneg c hc y) x

end Payoff

end

end BookProof.OperatorSeries
