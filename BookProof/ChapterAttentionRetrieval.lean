import Mathlib
import BookProof.ChapterAttentionOutput
import BookProof.ChapterCoherentGeometry

/-!
# Chapter "The Coherent State of Attention": quantitative retrieval

`ChapterSoftmaxSharpness` and `ChapterAttentionOutput` describe the
winner-takes-all behaviour of a head as a *limit* (`β → ∞`).  A memory that only
works in the limit is no memory at all, so this module replaces those limits by
explicit, non-asymptotic bounds at a fixed inverse temperature.

The single hypothesis is a **score margin**: the retrieved key `j` beats every
other key by at least `δ`.  Then

* `scoreSoftmax_le_exp_neg_margin` — every distractor carries weight at most
  `e^{-βδ}`;
* `one_sub_scoreSoftmax_le_of_margin` — the total weight leaking off the target is
  at most `(m-1)·e^{-βδ}`;
* `scoreSoftmax_ge_of_margin` — the target's own weight is at least
  `1/(1 + (m-1)e^{-βδ})`;
* `norm_headOutput_sub_le_of_margin` — **the head is an associative memory with
  exponentially small error**: the output differs from the stored value `v j` by
  at most `2C(m-1)e^{-βδ}`.

Two complements sharpen the picture.  `scoreSoftmax_ge_of_spread` is a *lower*
bound valid with no margin at all: at a finite temperature no key is ever
completely ignored (`p j ≥ e^{-βD}/m` for a score spread `D`), so attention is
never exactly sparse.  `bornWeight_ge_of_dist_margin` transports the retrieval
bound to the coherent-state picture of `ChapterCoherentGeometry`, where the margin
is a gap in *squared distance* between the query and the keys.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionRetrieval

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterSoftmaxBorn BookProof.ChapterObservableExpectation
  BookProof.ChapterAttentionOutput BookProof.ChapterCoherentGeometry

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-! ## The partition function, bounded by its largest term -/

/-- The partition function dominates any single term. -/
theorem exp_le_denom (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    Real.exp (beta * s j) ≤ ∑ l, Real.exp (beta * s l) :=
  Finset.single_le_sum (f := fun l => Real.exp (beta * s l))
    (fun _ _ => (Real.exp_pos _).le) (Finset.mem_univ j)

/-- The cardinality of the distractor set, as a real number. -/
theorem card_erase_cast (j : Fin m) :
    ((Finset.univ.erase j).card : ℝ) = (m : ℝ) - 1 := by
  have hm : 1 ≤ m := j.pos
  rw [Finset.card_erase_of_mem (Finset.mem_univ j), Finset.card_univ, Fintype.card_fin,
    Nat.cast_sub hm, Nat.cast_one]

/-! ## Retrieval under a score margin -/

/-- **A distractor is exponentially suppressed.**  If the key `j` beats `l` by a
margin `δ`, then `l` carries attention at most `e^{-βδ}`. -/
theorem scoreSoftmax_le_exp_neg_margin {beta delta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    {j l : Fin m} (h : s l + delta ≤ s j) :
    scoreSoftmax beta s l ≤ Real.exp (-(beta * delta)) := by
  have hZ : Real.exp (beta * s j) ≤ ∑ i, Real.exp (beta * s i) := exp_le_denom beta s j
  have hpos : (0 : ℝ) < Real.exp (beta * s j) := Real.exp_pos _
  have hstep : scoreSoftmax beta s l ≤ Real.exp (beta * s l) / Real.exp (beta * s j) :=
    div_le_div_of_nonneg_left (Real.exp_pos _).le hpos hZ
  have hexp : Real.exp (beta * s l) / Real.exp (beta * s j)
      = Real.exp (beta * s l - beta * s j) := (Real.exp_sub _ _).symm
  have hle : beta * s l - beta * s j ≤ -(beta * delta) := by
    have : beta * delta ≤ beta * (s j - s l) := by
      have hd : delta ≤ s j - s l := by linarith
      exact mul_le_mul_of_nonneg_left hd hb
    nlinarith
  calc scoreSoftmax beta s l ≤ Real.exp (beta * s l - beta * s j) := by rw [← hexp]; exact hstep
    _ ≤ Real.exp (-(beta * delta)) := Real.exp_le_exp.2 hle

/-- **The attention leaking off the target is exponentially small.** -/
theorem one_sub_scoreSoftmax_le_of_margin {beta delta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (j : Fin m) (hmargin : ∀ l, l ≠ j → s l + delta ≤ s j) :
    1 - scoreSoftmax beta s j ≤ ((m : ℝ) - 1) * Real.exp (-(beta * delta)) := by
  have hsum : ∑ l, scoreSoftmax beta s l = 1 := scoreSoftmax_sum_one beta s j
  have hsplit : ∑ l ∈ Finset.univ.erase j, scoreSoftmax beta s l
      = 1 - scoreSoftmax beta s j := by
    have := Finset.add_sum_erase Finset.univ (fun l => scoreSoftmax beta s l)
      (Finset.mem_univ j)
    rw [hsum] at this
    linarith
  have hterm : ∀ l ∈ Finset.univ.erase j,
      scoreSoftmax beta s l ≤ Real.exp (-(beta * delta)) := fun l hl =>
    scoreSoftmax_le_exp_neg_margin hb s (hmargin l (Finset.mem_erase.1 hl).1)
  have hbound := Finset.sum_le_card_nsmul (Finset.univ.erase j)
    (fun l => scoreSoftmax beta s l) (Real.exp (-(beta * delta))) hterm
  rw [nsmul_eq_mul, card_erase_cast j, hsplit] at hbound
  exact hbound

/-- **The target keeps almost all the attention.** -/
theorem scoreSoftmax_ge_of_margin {beta delta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (j : Fin m) (hmargin : ∀ l, l ≠ j → s l + delta ≤ s j) :
    1 - ((m : ℝ) - 1) * Real.exp (-(beta * delta)) ≤ scoreSoftmax beta s j := by
  have := one_sub_scoreSoftmax_le_of_margin hb s j hmargin
  linarith

/-- The sharp form of `scoreSoftmax_ge_of_margin`: the target's weight is at least
`1/(1 + (m-1)e^{-βδ})`, which is a genuine probability for every `β ≥ 0`. -/
theorem scoreSoftmax_ge_inv_of_margin {beta delta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (j : Fin m) (hmargin : ∀ l, l ≠ j → s l + delta ≤ s j) :
    1 / (1 + ((m : ℝ) - 1) * Real.exp (-(beta * delta))) ≤ scoreSoftmax beta s j := by
  set c : ℝ := Real.exp (-(beta * delta)) with hc
  have hcpos : 0 < c := Real.exp_pos _
  have hcard : (0 : ℝ) ≤ (m : ℝ) - 1 := by
    have hm : 1 ≤ m := j.pos
    have : (1 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
    linarith
  have hEpos : (0 : ℝ) < Real.exp (beta * s j) := Real.exp_pos _
  -- the partition function is at most `exp (β s j) * (1 + (m-1) c)`
  have hZ : ∑ l, Real.exp (beta * s l) ≤ Real.exp (beta * s j) * (1 + ((m : ℝ) - 1) * c) := by
    have hsplit : ∑ l, Real.exp (beta * s l)
        = Real.exp (beta * s j) + ∑ l ∈ Finset.univ.erase j, Real.exp (beta * s l) :=
      (Finset.add_sum_erase Finset.univ (fun l => Real.exp (beta * s l))
        (Finset.mem_univ j)).symm
    have hterm : ∀ l ∈ Finset.univ.erase j,
        Real.exp (beta * s l) ≤ Real.exp (beta * s j) * c := by
      intro l hl
      have h := hmargin l (Finset.mem_erase.1 hl).1
      have hle : beta * s l ≤ beta * s j + -(beta * delta) := by
        have hd : delta ≤ s j - s l := by linarith
        have := mul_le_mul_of_nonneg_left hd hb
        nlinarith
      calc Real.exp (beta * s l) ≤ Real.exp (beta * s j + -(beta * delta)) :=
            Real.exp_le_exp.2 hle
        _ = Real.exp (beta * s j) * c := by rw [Real.exp_add, hc]
    have hbound := Finset.sum_le_card_nsmul (Finset.univ.erase j)
      (fun l => Real.exp (beta * s l)) (Real.exp (beta * s j) * c) hterm
    rw [nsmul_eq_mul, card_erase_cast j] at hbound
    rw [hsplit]
    nlinarith
  have hden : (0 : ℝ) < 1 + ((m : ℝ) - 1) * c := by positivity
  have hZpos : (0 : ℝ) < ∑ l, Real.exp (beta * s l) := scoreSoftmax_denom_pos beta s j
  rw [scoreSoftmax, div_le_div_iff₀ hden hZpos]
  linarith

/-! ## The head as an associative memory -/

/-- **The attention head is an associative memory with exponentially small
error.**  Under a score margin `δ` the output is within `2C(m-1)e^{-βδ}` of the
stored value `v j`. -/
theorem norm_headOutput_sub_le_of_margin {beta delta C : ℝ} (hb : 0 ≤ beta)
    (s : Fin m → ℝ) (v : Fin m → E) (j : Fin m)
    (hmargin : ∀ l, l ≠ j → s l + delta ≤ s j) (hv : ∀ l, ‖v l‖ ≤ C) :
    ‖headOutput beta s v - v j‖ ≤ 2 * C * (((m : ℝ) - 1) * Real.exp (-(beta * delta))) := by
  have hC : 0 ≤ C := le_trans (norm_nonneg _) (hv j)
  have hsum : ∑ l, scoreSoftmax beta s l = 1 := scoreSoftmax_sum_one beta s j
  have hdiff : headOutput beta s v - v j = ∑ l, scoreSoftmax beta s l • (v l - v j) := by
    rw [headOutput_eq_sum]
    rw [Finset.sum_congr rfl (fun l _ => smul_sub (scoreSoftmax beta s l) (v l) (v j)),
      Finset.sum_sub_distrib, ← Finset.sum_smul, hsum, one_smul]
  have hterm : ∀ l ∈ Finset.univ.erase j,
      ‖scoreSoftmax beta s l • (v l - v j)‖ ≤ 2 * C * Real.exp (-(beta * delta)) := by
    intro l hl
    have hpl : scoreSoftmax beta s l ≤ Real.exp (-(beta * delta)) :=
      scoreSoftmax_le_exp_neg_margin hb s (hmargin l (Finset.mem_erase.1 hl).1)
    have hvl : ‖v l - v j‖ ≤ 2 * C := by
      calc ‖v l - v j‖ ≤ ‖v l‖ + ‖v j‖ := norm_sub_le _ _
        _ ≤ C + C := add_le_add (hv l) (hv j)
        _ = 2 * C := by ring
    have hnn : (0 : ℝ) ≤ scoreSoftmax beta s l := scoreSoftmax_nonneg beta s l
    rw [norm_smul, Real.norm_eq_abs, abs_of_nonneg hnn]
    calc scoreSoftmax beta s l * ‖v l - v j‖
        ≤ Real.exp (-(beta * delta)) * (2 * C) := by
          apply mul_le_mul hpl hvl (norm_nonneg _) (Real.exp_pos _).le
      _ = 2 * C * Real.exp (-(beta * delta)) := by ring
  have hzero : scoreSoftmax beta s j • (v j - v j) = 0 := by simp
  have hsplit : ∑ l, scoreSoftmax beta s l • (v l - v j)
      = ∑ l ∈ Finset.univ.erase j, scoreSoftmax beta s l • (v l - v j) := by
    rw [← Finset.add_sum_erase Finset.univ (fun l => scoreSoftmax beta s l • (v l - v j))
      (Finset.mem_univ j), hzero, zero_add]
  rw [hdiff, hsplit]
  calc ‖∑ l ∈ Finset.univ.erase j, scoreSoftmax beta s l • (v l - v j)‖
      ≤ ∑ l ∈ Finset.univ.erase j, ‖scoreSoftmax beta s l • (v l - v j)‖ :=
        norm_sum_le _ _
    _ ≤ ((Finset.univ.erase j).card : ℝ) * (2 * C * Real.exp (-(beta * delta))) := by
        simpa [nsmul_eq_mul] using
          Finset.sum_le_card_nsmul (Finset.univ.erase j)
            (fun l => ‖scoreSoftmax beta s l • (v l - v j)‖)
            (2 * C * Real.exp (-(beta * delta))) hterm
    _ = 2 * C * (((m : ℝ) - 1) * Real.exp (-(beta * delta))) := by
        rw [card_erase_cast j]; ring

/-! ## No key is ever ignored -/

/-- **Attention is never exactly sparse.**  If the scores lie within a spread `D`
of the score of `j`, then `j` keeps at least `e^{-βD}/m` of the attention: at any
finite temperature every key retains a positive share. -/
theorem scoreSoftmax_ge_of_spread {beta D : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (j : Fin m) (hD : ∀ l, s l ≤ s j + D) :
    Real.exp (-(beta * D)) / (m : ℝ) ≤ scoreSoftmax beta s j := by
  have hmpos : (0 : ℝ) < (m : ℝ) := by exact_mod_cast j.pos
  have hEpos : (0 : ℝ) < Real.exp (beta * s j) := Real.exp_pos _
  have hZpos : (0 : ℝ) < ∑ l, Real.exp (beta * s l) := scoreSoftmax_denom_pos beta s j
  have hZ : ∑ l, Real.exp (beta * s l)
      ≤ (m : ℝ) * (Real.exp (beta * s j) * Real.exp (beta * D)) := by
    have hterm : ∀ l ∈ (Finset.univ : Finset (Fin m)),
        Real.exp (beta * s l) ≤ Real.exp (beta * s j) * Real.exp (beta * D) := by
      intro l _
      have hle : beta * s l ≤ beta * s j + beta * D := by
        have := mul_le_mul_of_nonneg_left (hD l) hb
        nlinarith
      calc Real.exp (beta * s l) ≤ Real.exp (beta * s j + beta * D) := Real.exp_le_exp.2 hle
        _ = Real.exp (beta * s j) * Real.exp (beta * D) := Real.exp_add _ _
    have := Finset.sum_le_card_nsmul (Finset.univ : Finset (Fin m))
      (fun l => Real.exp (beta * s l)) (Real.exp (beta * s j) * Real.exp (beta * D)) hterm
    simpa [nsmul_eq_mul] using this
  have hexp : Real.exp (-(beta * D)) * Real.exp (beta * D) = 1 := by
    rw [← Real.exp_add]; simp
  have hmul := mul_le_mul_of_nonneg_left hZ (Real.exp_pos (-(beta * D))).le
  have hrewrite : Real.exp (-(beta * D)) *
      ((m : ℝ) * (Real.exp (beta * s j) * Real.exp (beta * D)))
      = Real.exp (beta * s j) * (m : ℝ) := by
    calc Real.exp (-(beta * D)) *
          ((m : ℝ) * (Real.exp (beta * s j) * Real.exp (beta * D)))
        = (m : ℝ) * Real.exp (beta * s j) *
            (Real.exp (-(beta * D)) * Real.exp (beta * D)) := by ring
      _ = Real.exp (beta * s j) * (m : ℝ) := by rw [hexp]; ring
  rw [scoreSoftmax, div_le_div_iff₀ hmpos hZpos]
  linarith

/-! ## The coherent-state form: a gap in squared distance -/

/-- **Retrieval in the coherent-state picture.**  If the query is closer to the key
`k j` than to every other key by a gap `δ` in *squared* distance, the Born weight
of `j` is at least `1 - (m-1)e^{-δ}`. -/
theorem bornWeight_ge_of_dist_margin {delta : ℝ} (q : EuclideanSpace ℝ (Fin n))
    (k : Fin m → EuclideanSpace ℝ (Fin n)) (j : Fin m)
    (hmargin : ∀ l, l ≠ j → ‖q - k j‖ ^ 2 + delta ≤ ‖q - k l‖ ^ 2) :
    1 - ((m : ℝ) - 1) * Real.exp (-delta) ≤ bornWeight q k j := by
  have hmar : ∀ l, l ≠ j → (-‖q - k l‖ ^ 2) + delta ≤ (-‖q - k j‖ ^ 2) := by
    intro l hl
    have := hmargin l hl
    linarith
  have h := scoreSoftmax_ge_of_margin (beta := 1) zero_le_one
    (fun i => -‖q - k i‖ ^ 2) j hmar
  rw [bornWeight_eq_scoreSoftmax_neg_dist_sq]
  simpa using h

end BookProof.ChapterAttentionRetrieval

end
