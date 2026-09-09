import Mathlib
import BookProof.ChapterAttentionOutput

/-!
# Chapter "The Coherent State of Attention": decoding is an incremental update

A transformer generating text does not recompute its heads from scratch at every
step: it keeps the keys and values of the tokens it has already seen (the *KV
cache*) and appends one new pair per step.  This module proves that the cached
computation is exact, and identifies the update rule.

Writing `Fin.snoc s sₙ` for the score family with one new key appended and `w` for
the weight the new key receives:

* `newWeight_pos`, `newWeight_lt_one` — the fresh token always takes a strictly
  positive share, never all of it;
* `scoreSoftmax_snoc_castSucc` — every cached key keeps exactly `(1 − w)` times the
  weight it had, so the cached scores never need to be revisited;
* **`headOutput_snoc`** — the headline: the new output is the convex interpolation
  `(1 − w)·o_old + w·v_new` of the cached output and the new value, so a decoder can
  carry one vector forward instead of the whole context;
* `norm_headOutput_snoc_sub_le` — hence a fresh token moves the output by at most
  `w·‖v_new − o_old‖`: late tokens perturb an established summary only in
  proportion to the attention they win;
* `scoreSoftmax_snoc_odds` — appending a token leaves all the odds among the cached
  keys untouched.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionStreaming

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterObservableExpectation BookProof.ChapterAttentionOutput

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-! ## Appending one key -/

/-- The Softmax denominator after appending one key of score `sn`. -/
theorem snoc_denom (beta sn : ℝ) (s : Fin m → ℝ) :
    ∑ l, Real.exp (beta * (Fin.snoc s sn : Fin (m + 1) → ℝ) l)
      = (∑ l, Real.exp (beta * s l)) + Real.exp (beta * sn) := by
  rw [Fin.sum_univ_castSucc]
  simp

theorem snoc_denom_pos (beta sn : ℝ) (s : Fin m → ℝ) :
    0 < (∑ l, Real.exp (beta * s l)) + Real.exp (beta * sn) := by
  have : (0 : ℝ) ≤ ∑ l, Real.exp (beta * s l) :=
    Finset.sum_nonneg fun _ _ => (Real.exp_pos _).le
  linarith [Real.exp_pos (beta * sn)]

/-- The weight the freshly appended key receives. -/
def newWeight (beta sn : ℝ) (s : Fin m → ℝ) : ℝ :=
  scoreSoftmax beta (Fin.snoc s sn) (Fin.last m)

theorem newWeight_eq (beta sn : ℝ) (s : Fin m → ℝ) :
    newWeight beta sn s
      = Real.exp (beta * sn) / ((∑ l, Real.exp (beta * s l)) + Real.exp (beta * sn)) := by
  rw [newWeight, scoreSoftmax, snoc_denom]
  simp

theorem newWeight_pos (beta sn : ℝ) (s : Fin m → ℝ) : 0 < newWeight beta sn s := by
  rw [newWeight_eq]
  exact div_pos (Real.exp_pos _) (snoc_denom_pos beta sn s)

/-- With a non-empty cache the fresh token never takes all the attention. -/
theorem newWeight_lt_one (beta sn : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    newWeight beta sn s < 1 := by
  have hZ : 0 < ∑ l, Real.exp (beta * s l) :=
    Finset.sum_pos (fun _ _ => Real.exp_pos _) ⟨i, Finset.mem_univ i⟩
  rw [newWeight_eq, div_lt_one (snoc_denom_pos beta sn s)]
  linarith

theorem one_sub_newWeight_eq (beta sn : ℝ) (s : Fin m → ℝ) :
    1 - newWeight beta sn s
      = (∑ l, Real.exp (beta * s l))
          / ((∑ l, Real.exp (beta * s l)) + Real.exp (beta * sn)) := by
  rw [newWeight_eq]
  field_simp
  ring

/-! ## The cache stays valid -/

/-- **Appending a key rescales the cache.**  Every cached weight is multiplied by
the single factor `1 − w`, so nothing in the cache has to be recomputed. -/
theorem scoreSoftmax_snoc_castSucc (beta sn : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (Fin.snoc s sn) j.castSucc
      = (1 - newWeight beta sn s) * scoreSoftmax beta s j := by
  have hZ : 0 < ∑ l, Real.exp (beta * s l) :=
    Finset.sum_pos (fun _ _ => Real.exp_pos _) ⟨j, Finset.mem_univ j⟩
  rw [one_sub_newWeight_eq, scoreSoftmax, scoreSoftmax, snoc_denom, div_mul_div_comm,
    Fin.snoc_castSucc, mul_comm (∑ l, Real.exp (beta * s l)) (Real.exp (beta * s j)),
    mul_div_mul_right _ _ hZ.ne']

/-- The odds among the cached keys are untouched by the new token. -/
theorem scoreSoftmax_snoc_odds (beta sn : ℝ) (s : Fin m → ℝ) (i j : Fin m) :
    scoreSoftmax beta (Fin.snoc s sn) i.castSucc * scoreSoftmax beta s j
      = scoreSoftmax beta (Fin.snoc s sn) j.castSucc * scoreSoftmax beta s i := by
  rw [scoreSoftmax_snoc_castSucc, scoreSoftmax_snoc_castSucc]
  ring

/-- The cached keys share a budget of `1 − w`. -/
theorem sum_scoreSoftmax_snoc_castSucc (beta sn : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    ∑ j : Fin m, scoreSoftmax beta (Fin.snoc s sn) j.castSucc = 1 - newWeight beta sn s := by
  calc ∑ j : Fin m, scoreSoftmax beta (Fin.snoc s sn) j.castSucc
      = ∑ j, (1 - newWeight beta sn s) * scoreSoftmax beta s j :=
        Finset.sum_congr rfl fun j _ => scoreSoftmax_snoc_castSucc beta sn s j
    _ = (1 - newWeight beta sn s) * ∑ j, scoreSoftmax beta s j := by rw [Finset.mul_sum]
    _ = 1 - newWeight beta sn s := by rw [scoreSoftmax_sum_one beta s i, mul_one]

/-! ## The decoding update rule -/

/-- **HEADLINE — one decoding step is a convex interpolation.**  The head output
after appending a key/value pair is `(1 − w)·o_old + w·v_new`. -/
theorem headOutput_snoc (beta sn : ℝ) (s : Fin m → ℝ) (vn : E) (v : Fin m → E) :
    headOutput beta (Fin.snoc s sn) (Fin.snoc v vn)
      = (1 - newWeight beta sn s) • headOutput beta s v + newWeight beta sn s • vn := by
  rw [headOutput_eq_sum, Fin.sum_univ_castSucc]
  simp only [Fin.snoc_castSucc, Fin.snoc_last]
  congr 1
  calc ∑ j, scoreSoftmax beta (Fin.snoc s sn) j.castSucc • v j
      = ∑ j, ((1 - newWeight beta sn s) * scoreSoftmax beta s j) • v j :=
        Finset.sum_congr rfl fun j _ => by rw [scoreSoftmax_snoc_castSucc]
    _ = (1 - newWeight beta sn s) • ∑ j, scoreSoftmax beta s j • v j := by
        rw [Finset.smul_sum]
        exact Finset.sum_congr rfl fun j _ => by rw [mul_smul]
    _ = (1 - newWeight beta sn s) • headOutput beta s v := rfl

/-- **A fresh token moves the summary only in proportion to the attention it
wins.** -/
theorem norm_headOutput_snoc_sub_le (beta sn : ℝ) (s : Fin m → ℝ) (vn : E) (v : Fin m → E) :
    ‖headOutput beta (Fin.snoc s sn) (Fin.snoc v vn) - headOutput beta s v‖
      = newWeight beta sn s * ‖vn - headOutput beta s v‖ := by
  have hdiff : headOutput beta (Fin.snoc s sn) (Fin.snoc v vn) - headOutput beta s v
      = newWeight beta sn s • (vn - headOutput beta s v) := by
    rw [headOutput_snoc, smul_sub, sub_smul, one_smul]
    abel
  rw [hdiff, norm_smul, Real.norm_eq_abs, abs_of_pos (newWeight_pos beta sn s)]

end BookProof.ChapterAttentionStreaming

end
