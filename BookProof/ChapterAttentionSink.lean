import Mathlib
import BookProof.ChapterAttentionOutput
import BookProof.ChapterAttentionEntropy

/-!
# Chapter "The Coherent State of Attention": the attention sink

Trained transformers reliably devote a large share of every head's attention to one
distinguished position — the beginning-of-sequence token — which carries no
information.  This "attention sink" is often described as a pathology; the algebra
of the Born measurement says it is a *gauge*: appending one extra key to a head
rescales all the original weights by one common factor and changes nothing else.

Writing `Fin.cons s₀ s : Fin (m+1) → ℝ` for the score family with the sink
prepended, and `w` for the weight the sink receives:

* `sinkWeight_pos`, `sinkWeight_lt_one` — the sink always takes a strictly positive
  share, never all of it.
* `scoreSoftmax_sink_succ` — **the headline**: every original key keeps exactly
  `(1 − w)` times the weight it had, so `sum_scoreSoftmax_sink_succ` gives the keys
  a total budget of `1 − w`.
* `scoreSoftmax_sink_odds` — the odds between two ordinary keys are untouched, and
  `scoreSoftmax_sink_lt` says each of them is strictly diluted.
* `headOutput_sink` — the output is the two-point average `w·v₀ + (1−w)·o` of the
  sink value and the sink-free output: a sink with value `0` simply shrinks the
  head's output by `1 − w`.
* `shannonEntropy_cons_scaled` and `shannonEntropy_sink` — the entropy chain rule
  for the sink: the head's entropy is the binary entropy of the sink share plus
  `(1 − w)` times the entropy of the ordinary keys.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionSink

open BookProof.ChapterObservableExpectation BookProof.ChapterSoftmaxSharpness
  BookProof.ChapterSoftmaxOrder BookProof.ChapterAttentionEntropy
  BookProof.ChapterAttentionOutput

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-! ## The score family with a sink prepended -/

/-- The Softmax denominator of a head with a sink key of score `s₀` prepended. -/
theorem sink_denom (beta s0 : ℝ) (s : Fin m → ℝ) :
    ∑ l, Real.exp (beta * (Fin.cons s0 s : Fin (m + 1) → ℝ) l)
      = Real.exp (beta * s0) + ∑ l, Real.exp (beta * s l) := by
  rw [Fin.sum_univ_succ]
  simp

/-- The weight the sink key receives. -/
def sinkWeight (beta s0 : ℝ) (s : Fin m → ℝ) : ℝ :=
  scoreSoftmax beta (Fin.cons s0 s) 0

theorem sinkWeight_eq (beta s0 : ℝ) (s : Fin m → ℝ) :
    sinkWeight beta s0 s
      = Real.exp (beta * s0) / (Real.exp (beta * s0) + ∑ l, Real.exp (beta * s l)) := by
  rw [sinkWeight, scoreSoftmax, sink_denom]
  simp

theorem sink_denom_pos (beta s0 : ℝ) (s : Fin m → ℝ) :
    0 < Real.exp (beta * s0) + ∑ l, Real.exp (beta * s l) := by
  have : (0 : ℝ) ≤ ∑ l, Real.exp (beta * s l) :=
    Finset.sum_nonneg fun _ _ => (Real.exp_pos _).le
  linarith [Real.exp_pos (beta * s0)]

/-- The sink always takes a strictly positive share of the attention. -/
theorem sinkWeight_pos (beta s0 : ℝ) (s : Fin m → ℝ) : 0 < sinkWeight beta s0 s := by
  rw [sinkWeight_eq]
  exact div_pos (Real.exp_pos _) (sink_denom_pos beta s0 s)

/-- With at least one ordinary key present the sink never takes all the attention. -/
theorem sinkWeight_lt_one (beta s0 : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    sinkWeight beta s0 s < 1 := by
  have hZ : 0 < ∑ l, Real.exp (beta * s l) :=
    Finset.sum_pos (fun _ _ => Real.exp_pos _) ⟨i, Finset.mem_univ i⟩
  rw [sinkWeight_eq, div_lt_one (sink_denom_pos beta s0 s)]
  linarith

/-- The complement of the sink share, i.e. the budget left to the ordinary keys. -/
theorem one_sub_sinkWeight_eq (beta s0 : ℝ) (s : Fin m → ℝ) :
    1 - sinkWeight beta s0 s
      = (∑ l, Real.exp (beta * s l)) / (Real.exp (beta * s0) + ∑ l, Real.exp (beta * s l)) := by
  rw [sinkWeight_eq]
  field_simp
  ring

/-! ## The sink rescales, it does not reorganize -/

/-- **The attention sink is a common rescaling.**  Prepending a sink key multiplies
every ordinary attention weight by the same factor `1 − w`. -/
theorem scoreSoftmax_sink_succ (beta s0 : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (Fin.cons s0 s) j.succ
      = (1 - sinkWeight beta s0 s) * scoreSoftmax beta s j := by
  have hZ : 0 < ∑ l, Real.exp (beta * s l) :=
    Finset.sum_pos (fun _ _ => Real.exp_pos _) ⟨j, Finset.mem_univ j⟩
  rw [one_sub_sinkWeight_eq, scoreSoftmax, scoreSoftmax, sink_denom]
  rw [div_mul_div_comm]
  rw [Fin.cons_succ]
  rw [mul_comm (∑ l, Real.exp (beta * s l)) (Real.exp (beta * s j))]
  rw [mul_div_mul_right _ _ hZ.ne']

/-- Every ordinary key is strictly diluted by the sink. -/
theorem scoreSoftmax_sink_lt (beta s0 : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (Fin.cons s0 s) j.succ < scoreSoftmax beta s j := by
  rw [scoreSoftmax_sink_succ]
  have hw := sinkWeight_pos beta s0 s
  have hp := scoreSoftmax_pos beta s j
  nlinarith

/-- The odds between two ordinary keys are unchanged by the sink. -/
theorem scoreSoftmax_sink_odds (beta s0 : ℝ) (s : Fin m → ℝ) (i j : Fin m) :
    scoreSoftmax beta (Fin.cons s0 s) i.succ * scoreSoftmax beta s j
      = scoreSoftmax beta (Fin.cons s0 s) j.succ * scoreSoftmax beta s i := by
  rw [scoreSoftmax_sink_succ, scoreSoftmax_sink_succ]
  ring

/-- The ordinary keys share a budget of `1 − w`. -/
theorem sum_scoreSoftmax_sink_succ (beta s0 : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    ∑ j : Fin m, scoreSoftmax beta (Fin.cons s0 s) j.succ = 1 - sinkWeight beta s0 s := by
  calc ∑ j : Fin m, scoreSoftmax beta (Fin.cons s0 s) j.succ
      = ∑ j, (1 - sinkWeight beta s0 s) * scoreSoftmax beta s j :=
        Finset.sum_congr rfl fun j _ => scoreSoftmax_sink_succ beta s0 s j
    _ = (1 - sinkWeight beta s0 s) * ∑ j, scoreSoftmax beta s j := by
        rw [Finset.mul_sum]
    _ = 1 - sinkWeight beta s0 s := by
        rw [scoreSoftmax_sum_one beta s i, mul_one]

/-! ## The output of a head with a sink -/

/-- **The output of a head with a sink** is the two-point average of the sink value
and the sink-free output. -/
theorem headOutput_sink (beta s0 : ℝ) (s : Fin m → ℝ) (v0 : E) (v : Fin m → E) :
    headOutput beta (Fin.cons s0 s) (Fin.cons v0 v)
      = sinkWeight beta s0 s • v0 + (1 - sinkWeight beta s0 s) • headOutput beta s v := by
  rw [headOutput_eq_sum, Fin.sum_univ_succ]
  simp only [Fin.cons_zero, Fin.cons_succ]
  congr 1
  calc ∑ j, scoreSoftmax beta (Fin.cons s0 s) j.succ • v j
      = ∑ j, ((1 - sinkWeight beta s0 s) * scoreSoftmax beta s j) • v j :=
        Finset.sum_congr rfl fun j _ => by rw [scoreSoftmax_sink_succ]
    _ = (1 - sinkWeight beta s0 s) • ∑ j, scoreSoftmax beta s j • v j := by
        rw [Finset.smul_sum]
        exact Finset.sum_congr rfl fun j _ => by rw [mul_smul]
    _ = (1 - sinkWeight beta s0 s) • headOutput beta s v := rfl

/-! ## The entropy chain rule for the sink -/

/-- The entropy of a distribution obtained by giving one new outcome the weight `w`
and scaling an old distribution by `1 − w` is the binary entropy of `w` plus
`(1 − w)` times the old entropy. -/
theorem shannonEntropy_cons_scaled {w : ℝ} (hw1 : w < 1) {p : Fin m → ℝ}
    (hp : ∀ j, 0 < p j) (hsum : ∑ j, p j = 1) :
    shannonEntropy (Fin.cons w (fun j => (1 - w) * p j) : Fin (m + 1) → ℝ)
      = (-w * Real.log w - (1 - w) * Real.log (1 - w)) + (1 - w) * shannonEntropy p := by
  have hw1' : 0 < 1 - w := by linarith
  have hterm : ∀ j : Fin m,
      ((1 - w) * p j) * Real.log ((1 - w) * p j)
        = (1 - w) * Real.log (1 - w) * p j + (1 - w) * (p j * Real.log (p j)) := by
    intro j
    rw [Real.log_mul hw1'.ne' (hp j).ne']
    ring
  rw [shannonEntropy, Fin.sum_univ_succ]
  simp only [Fin.cons_zero, Fin.cons_succ]
  rw [Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_add_distrib, ← Finset.mul_sum,
    ← Finset.mul_sum, hsum, mul_one, shannonEntropy]
  ring

/-- **The entropy of a head with a sink.**  It splits into the binary entropy of the
sink share and the entropy the head would have without the sink, discounted by the
budget `1 − w` left to the ordinary keys. -/
theorem shannonEntropy_sink (beta s0 : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    shannonEntropy (scoreSoftmax beta (Fin.cons s0 s))
      = (-sinkWeight beta s0 s * Real.log (sinkWeight beta s0 s)
          - (1 - sinkWeight beta s0 s) * Real.log (1 - sinkWeight beta s0 s))
        + (1 - sinkWeight beta s0 s) * shannonEntropy (scoreSoftmax beta s) := by
  have hcons : (scoreSoftmax beta (Fin.cons s0 s) : Fin (m + 1) → ℝ)
      = Fin.cons (sinkWeight beta s0 s)
          (fun j => (1 - sinkWeight beta s0 s) * scoreSoftmax beta s j) := by
    funext l
    refine Fin.cases ?_ ?_ l
    · simp [sinkWeight]
    · intro j
      simpa using scoreSoftmax_sink_succ beta s0 s j
  rw [hcons]
  exact shannonEntropy_cons_scaled (sinkWeight_lt_one beta s0 s i)
    (fun j => scoreSoftmax_pos beta s j) (scoreSoftmax_sum_one beta s i)

end BookProof.ChapterAttentionSink
