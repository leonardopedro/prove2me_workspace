import Mathlib
import BookProof.ChapterAttentionMasking
import BookProof.ChapterAttentionMarkov
import BookProof.ChapterAttentionOutput

/-!
# Chapter "The Coherent State of Attention": sparse attention costs exactly the
discarded mass

Long-context transformers do not evaluate every key: they keep a set `S` of
candidate keys (a top-`k` shortlist, a sliding window, a block-sparse pattern) and
renormalize the attention over `S` alone.  `ChapterAttentionMasking` identifies
that operation as Bayesian conditioning; this module prices it.

Write `p` for the full attention distribution and `P(S) = ∑_{l ∈ S} pₗ` for the
mass the head would have put on the shortlist.

* `attendedMass_pos`, `attendedMass_le_one`, `attendedMass_univ` — the shortlist
  mass is a probability;
* **`l1dist_maskedSoftmax_eq`** — the headline: the sparse head differs from the
  dense head by exactly `2(1 − P(S))` in `ℓ¹` — no more and no less;
* `l1dist_maskedSoftmax_le_of_mass` — hence a shortlist that captures `1 − ε` of
  the mass is `2ε`-accurate;
* `norm_headOutput_masked_sub_le` — and the sparse output is within
  `2(1 − P(S))·C` of the dense output for values of norm at most `C`;
* `one_sub_attendedMass_le` — a tail bound: if every discarded key carries at most
  `ε`, the discarded mass is at most `(m − |S|)ε`;
* `l1dist_maskedSoftmax_eq_zero_iff_mass_one` and `maskedSoftmax_eq_of_mass_one` —
  sparsification is lossless exactly when the shortlist already carries all the
  mass.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionSparse

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterAttentionMasking BookProof.ChapterAttentionMarkov
  BookProof.ChapterObservableExpectation BookProof.ChapterAttentionOutput

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-! ## The mass carried by the shortlist -/

/-- The **attended mass**: the share of the dense attention that the shortlist `S`
would have received. -/
def attendedMass (beta : ℝ) (s : Fin m → ℝ) (S : Finset (Fin m)) : ℝ :=
  ∑ l ∈ S, scoreSoftmax beta s l

theorem attendedMass_pos (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)} (hS : S.Nonempty) :
    0 < attendedMass beta s S := by
  obtain ⟨i, hi⟩ := hS
  exact Finset.sum_pos' (fun l _ => (scoreSoftmax_pos beta s l).le)
    ⟨i, hi, scoreSoftmax_pos beta s i⟩

theorem attendedMass_univ (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    attendedMass beta s Finset.univ = 1 := scoreSoftmax_sum_one beta s i

theorem attendedMass_le_one (beta : ℝ) (s : Fin m → ℝ) (S : Finset (Fin m)) (i : Fin m) :
    attendedMass beta s S ≤ 1 := by
  rw [← attendedMass_univ beta s i]
  exact Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ S)
    fun l _ _ => (scoreSoftmax_pos beta s l).le

/-- The mass of the discarded keys is the complementary sum. -/
theorem one_sub_attendedMass_eq (beta : ℝ) (s : Fin m → ℝ) (S : Finset (Fin m)) (i : Fin m) :
    1 - attendedMass beta s S = ∑ l ∈ Sᶜ, scoreSoftmax beta s l := by
  have h := Finset.sum_add_sum_compl S (fun l => scoreSoftmax beta s l)
  rw [scoreSoftmax_sum_one beta s i] at h
  rw [attendedMass]
  linarith

/-- **A tail bound.**  If every discarded key carries at most `ε`, the shortlist
misses at most `(m − |S|)ε` of the attention. -/
theorem one_sub_attendedMass_le (beta : ℝ) (s : Fin m → ℝ) (S : Finset (Fin m)) (i : Fin m)
    {eps : ℝ} (h : ∀ l ∉ S, scoreSoftmax beta s l ≤ eps) :
    1 - attendedMass beta s S ≤ (m - S.card : ℝ) * eps := by
  rw [one_sub_attendedMass_eq beta s S i]
  have hle : S.card ≤ m := by
    simpa using Finset.card_le_card (Finset.subset_univ S)
  have hcard : (Sᶜ.card : ℝ) = (m : ℝ) - S.card := by
    rw [Finset.card_compl, Fintype.card_fin, Nat.cast_sub hle]
  calc ∑ l ∈ Sᶜ, scoreSoftmax beta s l ≤ ∑ _l ∈ Sᶜ, eps :=
        Finset.sum_le_sum fun l hl => h l (Finset.mem_compl.1 hl)
    _ = (Sᶜ.card : ℝ) * eps := by rw [Finset.sum_const, nsmul_eq_mul]
    _ = (m - S.card : ℝ) * eps := by rw [hcard]

/-! ## The price of sparsification -/

/-- On the shortlist the sparse weight is the dense weight scaled by `1/P(S)`. -/
theorem maskedSoftmax_sub_of_mem (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    {j : Fin m} (hj : j ∈ S) :
    maskedSoftmax beta s S j - scoreSoftmax beta s j
      = scoreSoftmax beta s j * (1 - attendedMass beta s S) / attendedMass beta s S := by
  have hP : 0 < attendedMass beta s S := attendedMass_pos beta s ⟨j, hj⟩
  rw [maskedSoftmax_eq_conditional beta s hj, ← attendedMass]
  field_simp

/-- **HEADLINE — sparse attention costs exactly the discarded mass.**  The `ℓ¹`
distance between the shortlisted head and the dense head is `2(1 − P(S))`. -/
theorem l1dist_maskedSoftmax_eq (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    (hS : S.Nonempty) (i : Fin m) :
    l1dist (maskedSoftmax beta s S) (scoreSoftmax beta s)
      = 2 * (1 - attendedMass beta s S) := by
  have hP : 0 < attendedMass beta s S := attendedMass_pos beta s hS
  have hP1 : attendedMass beta s S ≤ 1 := attendedMass_le_one beta s S i
  have hin : ∑ j ∈ S, |maskedSoftmax beta s S j - scoreSoftmax beta s j|
      = 1 - attendedMass beta s S := by
    have hterm : ∀ j ∈ S, |maskedSoftmax beta s S j - scoreSoftmax beta s j|
        = scoreSoftmax beta s j * (1 - attendedMass beta s S) / attendedMass beta s S := by
      intro j hj
      rw [maskedSoftmax_sub_of_mem beta s hj, abs_of_nonneg]
      exact div_nonneg (mul_nonneg (scoreSoftmax_nonneg beta s j) (by linarith)) hP.le
    rw [Finset.sum_congr rfl hterm, ← Finset.sum_div, ← Finset.sum_mul, ← attendedMass]
    field_simp
  have hout : ∑ j ∈ Sᶜ, |maskedSoftmax beta s S j - scoreSoftmax beta s j|
      = 1 - attendedMass beta s S := by
    have hterm : ∀ j ∈ Sᶜ, |maskedSoftmax beta s S j - scoreSoftmax beta s j|
        = scoreSoftmax beta s j := by
      intro j hj
      rw [maskedSoftmax_eq_zero_of_not_mem beta s (Finset.mem_compl.1 hj), zero_sub, abs_neg,
        abs_of_nonneg (scoreSoftmax_nonneg beta s j)]
    rw [Finset.sum_congr rfl hterm, ← one_sub_attendedMass_eq beta s S i]
  have hsplit := Finset.sum_add_sum_compl S
    (fun j => |maskedSoftmax beta s S j - scoreSoftmax beta s j|)
  rw [l1dist, ← hsplit, hin, hout]
  ring

/-- A shortlist capturing all but `ε` of the attention is `2ε`-accurate. -/
theorem l1dist_maskedSoftmax_le_of_mass (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    (hS : S.Nonempty) (i : Fin m) {eps : ℝ} (h : 1 - eps ≤ attendedMass beta s S) :
    l1dist (maskedSoftmax beta s S) (scoreSoftmax beta s) ≤ 2 * eps := by
  rw [l1dist_maskedSoftmax_eq beta s hS i]
  linarith

/-- Sparsification is lossless exactly when the shortlist carries all the mass. -/
theorem l1dist_maskedSoftmax_eq_zero_iff_mass_one (beta : ℝ) (s : Fin m → ℝ)
    {S : Finset (Fin m)} (hS : S.Nonempty) (i : Fin m) :
    l1dist (maskedSoftmax beta s S) (scoreSoftmax beta s) = 0
      ↔ attendedMass beta s S = 1 := by
  rw [l1dist_maskedSoftmax_eq beta s hS i]
  constructor <;> intro h <;> linarith

/-- At full mass the sparse and dense distributions coincide keywise. -/
theorem maskedSoftmax_eq_of_mass_one (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    (hS : S.Nonempty) (i : Fin m) (h : attendedMass beta s S = 1) (j : Fin m) :
    maskedSoftmax beta s S j = scoreSoftmax beta s j := by
  have hzero : l1dist (maskedSoftmax beta s S) (scoreSoftmax beta s) = 0 :=
    (l1dist_maskedSoftmax_eq_zero_iff_mass_one beta s hS i).2 h
  have hnn : ∀ l ∈ (Finset.univ : Finset (Fin m)),
      0 ≤ |maskedSoftmax beta s S l - scoreSoftmax beta s l| := fun l _ => abs_nonneg _
  have := (Finset.sum_eq_zero_iff_of_nonneg hnn).1 hzero j (Finset.mem_univ j)
  have := abs_eq_zero.1 this
  linarith

/-! ## The output of a sparse head -/

/-- The sparse head's output is within `2(1 − P(S))·C` of the dense output when the
values have norm at most `C`. -/
theorem norm_headOutput_masked_sub_le (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    (hS : S.Nonempty) (i : Fin m) {v : Fin m → E} {C : ℝ} (hv : ∀ j, ‖v j‖ ≤ C) :
    ‖observableExpectation (maskedSoftmax beta s S) v - headOutput beta s v‖
      ≤ 2 * (1 - attendedMass beta s S) * C := by
  have h := norm_observableExpectation_sub_le (E := E) (maskedSoftmax beta s S)
    (scoreSoftmax beta s) hv
  have hl1 : (∑ j, |maskedSoftmax beta s S j - scoreSoftmax beta s j|)
      = 2 * (1 - attendedMass beta s S) := l1dist_maskedSoftmax_eq beta s hS i
  rw [hl1] at h
  exact h

end BookProof.ChapterAttentionSparse

end
