import Mathlib
import BookProof.ChapterAttentionOutput

/-!
# Chapter "The Coherent State of Attention": the residual stream

Every block of a transformer writes its output *into* the stream rather than
replacing it: `x ↦ x + f x`.  This module proves the two structural facts that make
the residual form work, for an arbitrary block `f` on a normed space.

* `norm_residual_sub_self` and `norm_residual_sub_self_le` — a block moves the
  stream by exactly `‖f x‖`, and an attention head whose values are bounded by `C`
  moves it by at most `C`: the head is a *perturbation* of the identity, never a
  replacement.
* `norm_sub_residual_ge` and `residual_injective` — **the headline**: if the block
  is a contraction (`L < 1`), the residual map is injective, indeed expansive by the
  factor `1 - L`.  Nothing in the stream is ever overwritten: the layer's input can
  always be recovered from its output.
* `norm_residual_sub_le` — the matching upper bound `(1 + L)`; so a residual layer is
  bi-Lipschitz, and `norm_iterate_residual_sub_le` bounds the total drift of a stack
  of `n` blocks by `n · C`.  Depth moves the stream linearly, not exponentially.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterResidualStream

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterAttentionOutput

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E]

/-- One **residual block**: the stream `x` plus the block's output `f x`. -/
def residual (f : E → E) (x : E) : E := x + f x

/-! ## A block is a perturbation of the identity -/

theorem norm_residual_sub_self (f : E → E) (x : E) : ‖residual f x - x‖ = ‖f x‖ := by
  rw [residual]
  simp

/-- An attention head whose values all have norm at most `C` moves the residual
stream by at most `C`. -/
theorem norm_residual_sub_self_le [NormedSpace ℝ E] (beta : ℝ) (s : Fin m → ℝ)
    {v : Fin m → E} {C : ℝ} (hv : ∀ j, ‖v j‖ ≤ C) (i : Fin m) (x : E) :
    ‖residual (fun _ => headOutput beta s v) x - x‖ ≤ C := by
  rw [norm_residual_sub_self]
  exact norm_headOutput_le beta s hv i

/-! ## A contractive block never overwrites the stream -/

/-- **The residual stream is expansive.**  If the block is `L`-Lipschitz with
`L < 1`, two distinct streams stay at least `(1 - L)` times as far apart. -/
theorem norm_sub_residual_ge {f : E → E} {L : ℝ}
    (hf : ∀ x y, ‖f x - f y‖ ≤ L * ‖x - y‖) (x y : E) :
    (1 - L) * ‖x - y‖ ≤ ‖residual f x - residual f y‖ := by
  have hrw : residual f x - residual f y = (x - y) + (f x - f y) := by
    rw [residual, residual]
    abel
  have h1 : ‖x - y‖ ≤ ‖(x - y) + (f x - f y)‖ + ‖f x - f y‖ := by
    simpa using norm_sub_le ((x - y) + (f x - f y)) (f x - f y)
  have h2 := hf x y
  rw [hrw]
  linarith

/-- **A contractive block is invertible on the stream.**  No information written
into the residual stream by earlier layers can be destroyed by a later one. -/
theorem residual_injective {f : E → E} {L : ℝ} (hL : L < 1)
    (hf : ∀ x y, ‖f x - f y‖ ≤ L * ‖x - y‖) :
    Function.Injective (residual f) := by
  intro x y hxy
  have h := norm_sub_residual_ge hf x y
  rw [hxy, sub_self, norm_zero] at h
  have hx : ‖x - y‖ ≤ 0 := by
    by_contra hpos
    push_neg at hpos
    nlinarith
  have : x - y = 0 := by
    exact norm_eq_zero.mp (le_antisymm hx (norm_nonneg _))
  exact sub_eq_zero.mp this

/-- The matching upper bound: a residual layer is `(1 + L)`-Lipschitz. -/
theorem norm_residual_sub_le {f : E → E} {L : ℝ}
    (hf : ∀ x y, ‖f x - f y‖ ≤ L * ‖x - y‖) (x y : E) :
    ‖residual f x - residual f y‖ ≤ (1 + L) * ‖x - y‖ := by
  have hrw : residual f x - residual f y = (x - y) + (f x - f y) := by
    rw [residual, residual]
    abel
  have h1 : ‖(x - y) + (f x - f y)‖ ≤ ‖x - y‖ + ‖f x - f y‖ := norm_add_le _ _
  have h2 := hf x y
  rw [hrw]
  linarith

/-! ## The drift of a deep stack -/

/-- **Depth moves the stream linearly.**  After `n` residual blocks, each writing at
most `C`, the stream has drifted by at most `n · C`. -/
theorem norm_iterate_residual_sub_le {f : E → E} {C : ℝ} (hf : ∀ x, ‖f x‖ ≤ C) (n : ℕ)
    (x : E) :
    ‖(residual f)^[n] x - x‖ ≤ n * C := by
  induction n with
  | zero => simp
  | succ n ih =>
      have hstep : (residual f)^[n + 1] x = residual f ((residual f)^[n] x) := by
        rw [Function.iterate_succ_apply']
      have hsplit : (residual f)^[n + 1] x - x
          = (residual f ((residual f)^[n] x) - (residual f)^[n] x)
            + ((residual f)^[n] x - x) := by
        rw [hstep]
        abel
      have h1 : ‖residual f ((residual f)^[n] x) - (residual f)^[n] x‖ ≤ C := by
        rw [norm_residual_sub_self]
        exact hf _
      calc ‖(residual f)^[n + 1] x - x‖
          ≤ ‖residual f ((residual f)^[n] x) - (residual f)^[n] x‖
            + ‖(residual f)^[n] x - x‖ := by
            rw [hsplit]
            exact norm_add_le _ _
        _ ≤ C + n * C := add_le_add h1 ih
        _ = (n + 1 : ℕ) * C := by push_cast; ring

end BookProof.ChapterResidualStream
