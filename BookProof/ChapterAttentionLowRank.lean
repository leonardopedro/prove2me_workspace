import Mathlib

/-!
# Chapter "The Coherent State of Attention": the low-rank bottleneck of a head

A head computes its scores as `sᵢⱼ = ⟨qᵢ, kⱼ⟩` with queries and keys living in the
*head dimension* `d`, usually far smaller than the number of positions `m`.  That
factorization is a hard structural constraint, and this module states it as one.

* `rank_scoreMatrix_le` — **every score matrix a head can produce has rank at most
  `d`**: the `m × m` table of alignments factors through `ℝ^d`.
* `not_exists_scoreMatrix_one` — consequently, when `d < m` no head can realize the
  "each position attends to itself and to nothing else" pattern, whose score matrix
  is the identity and has rank `m`.  A single head is not a general router.
* `exists_scoreMatrix_one_of_le` — and the bound is sharp: at `d ≥ m` the identity
  pattern is realized by orthonormal query/key vectors.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterAttentionLowRank

variable {m d : ℕ}

/-- The score matrix of a head with query vectors `Q i` and key vectors `K j` in
the head dimension `d`. -/
def scoreMatrix (Q K : Fin m → Fin d → ℝ) : Matrix (Fin m) (Fin m) ℝ :=
  Matrix.of fun i j => ∑ a, Q i a * K j a

theorem scoreMatrix_apply (Q K : Fin m → Fin d → ℝ) (i j : Fin m) :
    scoreMatrix Q K i j = ∑ a, Q i a * K j a := rfl

theorem scoreMatrix_eq_mul (Q K : Fin m → Fin d → ℝ) :
    scoreMatrix Q K = (Matrix.of Q) * (Matrix.of K).transpose := by
  ext i j
  simp [scoreMatrix, Matrix.mul_apply, Matrix.transpose_apply]

/-- **The low-rank bottleneck**: the alignment table of a head has rank at most the
head dimension. -/
theorem rank_scoreMatrix_le (Q K : Fin m → Fin d → ℝ) :
    (scoreMatrix Q K).rank ≤ d := by
  rw [scoreMatrix_eq_mul]
  refine le_trans (Matrix.rank_mul_le_left _ _) ?_
  simpa using (Matrix.rank_le_width (A := (Matrix.of Q)))

/-- **A narrow head cannot route freely.**  When the head dimension is smaller than
the number of positions, no choice of queries and keys produces the identity score
pattern. -/
theorem not_exists_scoreMatrix_one (hd : d < m) :
    ¬ ∃ Q K : Fin m → Fin d → ℝ, scoreMatrix Q K = 1 := by
  rintro ⟨Q, K, hQK⟩
  have hrank := rank_scoreMatrix_le Q K
  rw [hQK, Matrix.rank_one] at hrank
  simp only [Fintype.card_fin] at hrank
  omega

/-- The bound is sharp: with at least as many dimensions as positions, orthonormal
queries and keys realize the identity score pattern exactly. -/
theorem exists_scoreMatrix_one_of_le (hd : m ≤ d) :
    ∃ Q K : Fin m → Fin d → ℝ, scoreMatrix Q K = 1 := by
  classical
  refine ⟨fun i a => if (a : ℕ) = (i : ℕ) then 1 else 0,
    fun j a => if (a : ℕ) = (j : ℕ) then 1 else 0, ?_⟩
  ext i j
  have hi : (i : ℕ) < d := lt_of_lt_of_le i.isLt hd
  have hsum : (∑ a : Fin d, (if (a : ℕ) = (i : ℕ) then (1 : ℝ) else 0)
      * (if (a : ℕ) = (j : ℕ) then (1 : ℝ) else 0))
      = if (i : ℕ) = (j : ℕ) then 1 else 0 := by
    rw [Finset.sum_eq_single (⟨(i : ℕ), hi⟩ : Fin d)]
    · simp
    · intro b _ hb
      have : (b : ℕ) ≠ (i : ℕ) := by
        intro h
        exact hb (Fin.ext h)
      simp [this]
    · intro h
      exact absurd (Finset.mem_univ _) h
  rw [scoreMatrix_apply, hsum, Matrix.one_apply]
  by_cases h : i = j
  · simp [h]
  · have : (i : ℕ) ≠ (j : ℕ) := fun hc => h (Fin.ext hc)
    simp [h, this]

end BookProof.ChapterAttentionLowRank

end
