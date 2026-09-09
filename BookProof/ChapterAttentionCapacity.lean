import Mathlib
import BookProof.ChapterAttentionRetrieval

/-!
# Chapter "The Coherent State of Attention": the capacity of the memory

`ChapterAttentionRetrieval` retrieves *one* stored value under a hypothesis on the
scores.  This module turns that into a statement about the memory as a whole: a
head storing `m` key–value pairs recovers **every** stored pair, provided the keys
are pairwise separated in the coherent-state geometry.

The scores are the physical ones of `ChapterCoherentGeometry`: probing with a query
`q` gives key `l` the score `-‖q - k l‖²`, so that the Born weights are the Softmax
of these scores at inverse temperature `1`.

* `keysSeparated` — the pairwise separation hypothesis `r ≤ ‖k i - k j‖`;
* `distScore_margin_of_separated` — probing with the stored key `k i` gives `i` a
  score margin of `r²` over every other key;
* `scoreSoftmax_distScore_ge_of_separated` — the probe concentrates on the intended
  slot: weight at least `1/(1 + (m-1)e^{-βr²})`;
* `norm_headOutput_distScore_sub_le_of_separated` — **every stored pair is
  recovered**, with error at most `2C(m-1)e^{-βr²}`, uniformly in the slot `i`;
* `exists_beta_forall_retrieval` — hence, for any tolerance `ε > 0`, a finite
  inverse temperature suffices to read the whole memory to accuracy `ε`.  This is
  the capacity statement: `m` patterns cost only `log m` in the required `β`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

open Filter Topology

noncomputable section

namespace BookProof.ChapterAttentionCapacity

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterAttentionOutput BookProof.ChapterCoherentGeometry
  BookProof.ChapterAttentionRetrieval

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-! ## Separated keys -/

/-- The score a query assigns to a key in the coherent-state geometry: minus the
squared distance.  The Born weights are the Softmax of these scores. -/
def distScore (q : EuclideanSpace ℝ (Fin n)) (k : Fin m → EuclideanSpace ℝ (Fin n))
    (l : Fin m) : ℝ := -‖q - k l‖ ^ 2

/-- The stored keys are pairwise separated by at least `r`. -/
def keysSeparated (k : Fin m → EuclideanSpace ℝ (Fin n)) (r : ℝ) : Prop :=
  ∀ i j, i ≠ j → r ≤ ‖k i - k j‖

/-- Probing the memory with the stored key `k i` gives slot `i` the score `0` and
every other slot a score of at most `-r²`: a margin of `r²`. -/
theorem distScore_margin_of_separated {k : Fin m → EuclideanSpace ℝ (Fin n)} {r : ℝ}
    (hr : 0 ≤ r) (hsep : keysSeparated k r) (i : Fin m) :
    ∀ l, l ≠ i → distScore (k i) k l + r ^ 2 ≤ distScore (k i) k i := by
  intro l hl
  have hd : r ≤ ‖k i - k l‖ := hsep i l (Ne.symm hl)
  have hsq : r ^ 2 ≤ ‖k i - k l‖ ^ 2 := by nlinarith [norm_nonneg (k i - k l)]
  have hself : distScore (k i) k i = 0 := by
    simp [distScore]
  rw [hself, distScore]
  linarith

/-! ## Every stored pair is recovered -/

/-- The probe concentrates on the intended slot. -/
theorem scoreSoftmax_distScore_ge_of_separated {k : Fin m → EuclideanSpace ℝ (Fin n)}
    {r beta : ℝ} (hb : 0 ≤ beta) (hr : 0 ≤ r) (hsep : keysSeparated k r) (i : Fin m) :
    1 / (1 + ((m : ℝ) - 1) * Real.exp (-(beta * r ^ 2)))
      ≤ scoreSoftmax beta (distScore (k i) k) i :=
  scoreSoftmax_ge_inv_of_margin hb _ i (distScore_margin_of_separated hr hsep i)

/-- **The memory reads out correctly in every slot.**  With keys separated by `r`
and values bounded by `C`, probing with the stored key `k i` returns the stored
value `v i` up to `2C(m-1)e^{-βr²}` — the same bound for every `i`. -/
theorem norm_headOutput_distScore_sub_le_of_separated
    {k : Fin m → EuclideanSpace ℝ (Fin n)} {v : Fin m → E} {r beta C : ℝ}
    (hb : 0 ≤ beta) (hr : 0 ≤ r) (hsep : keysSeparated k r) (hv : ∀ l, ‖v l‖ ≤ C)
    (i : Fin m) :
    ‖headOutput beta (distScore (k i) k) v - v i‖
      ≤ 2 * C * (((m : ℝ) - 1) * Real.exp (-(beta * r ^ 2))) :=
  norm_headOutput_sub_le_of_margin hb _ v i (distScore_margin_of_separated hr hsep i) hv

/-! ## Capacity: a finite temperature suffices -/

/-- The error bound vanishes as the temperature drops. -/
theorem tendsto_capacityError {r C : ℝ} (hr : 0 < r) (M : ℝ) :
    Tendsto (fun b : ℝ => 2 * C * (M * Real.exp (-(b * r ^ 2)))) atTop (𝓝 0) := by
  have hr2 : 0 < r ^ 2 := by positivity
  have hlin : Tendsto (fun b : ℝ => -(b * r ^ 2)) atTop atBot := by
    have h1 : Tendsto (fun b : ℝ => b * r ^ 2) atTop atTop :=
      Filter.Tendsto.atTop_mul_const hr2 tendsto_id
    exact tendsto_neg_atTop_atBot.comp h1
  have hexp : Tendsto (fun b : ℝ => Real.exp (-(b * r ^ 2))) atTop (𝓝 0) :=
    Real.tendsto_exp_atBot.comp hlin
  have := ((hexp.const_mul M).const_mul (2 * C))
  simpa using this

/-- **The capacity statement.**  For separated keys, bounded values and any
tolerance `ε > 0`, there is a finite inverse temperature beyond which *every* one
of the `m` stored pairs is recovered to within `ε`. -/
theorem exists_beta_forall_retrieval {k : Fin m → EuclideanSpace ℝ (Fin n)}
    {v : Fin m → E} {r C eps : ℝ} (hr : 0 < r) (hsep : keysSeparated k r)
    (hv : ∀ l, ‖v l‖ ≤ C) (heps : 0 < eps) :
    ∃ B : ℝ, 0 ≤ B ∧ ∀ b, B ≤ b → ∀ i : Fin m,
      ‖headOutput b (distScore (k i) k) v - v i‖ ≤ eps := by
  have htend := tendsto_capacityError (C := C) hr ((m : ℝ) - 1)
  have hev : ∀ᶠ b : ℝ in atTop, 2 * C * (((m : ℝ) - 1) * Real.exp (-(b * r ^ 2))) ≤ eps :=
    htend.eventually (eventually_le_nhds heps)
  obtain ⟨B₀, hB₀⟩ := eventually_atTop.1 hev
  refine ⟨max 0 B₀, le_max_left _ _, fun b hb i => ?_⟩
  have hb0 : 0 ≤ b := le_trans (le_max_left _ _) hb
  have hbB : B₀ ≤ b := le_trans (le_max_right _ _) hb
  exact le_trans
    (norm_headOutput_distScore_sub_le_of_separated hb0 hr.le hsep hv i) (hB₀ b hbB)

end BookProof.ChapterAttentionCapacity

end
