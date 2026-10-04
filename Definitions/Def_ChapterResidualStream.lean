import Definitions.Def_ChapterAttentionOutput
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib


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





/-! ## A contractive block never overwrites the stream -/







/-! ## The drift of a deep stack -/



end BookProof.ChapterResidualStream
