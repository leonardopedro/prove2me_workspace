import Mathlib
import BookProof.ChapterSoftmaxFluctuation

/-!
# Chapter "The Coherent State of Attention": sharpening is monotone

`ChapterSoftmaxFluctuation` differentiates a single attention weight in the
inverse temperature and finds the response law
`dpⱼ/dβ = pⱼ · (sⱼ − ⟨s⟩)`.  This module reads that law as a **monotonicity
statement about sharpening**: lowering the temperature never takes attention away
from the best key and never gives attention to the worst one.

* `deriv_scoreSoftmax_beta` — the response law in `deriv` form;
* `min_le_meanScore` — the mean score is squeezed between the extreme scores
  (the companion of `meanScore_le_max`);
* `scoreSoftmax_monotone_of_max` — **the winner's share is monotone in `β`**;
* `scoreSoftmax_antitone_of_min` — the loser's share is antitone in `β`;
* `scoreSoftmax_max_ge_inv_card` / `scoreSoftmax_min_le_inv_card` — comparing with
  the infinite-temperature value `1/m`: at any positive `β` the best key already
  carries at least the uniform share, the worst key at most it;
* `scoreSoftmax_max_ge_of_le` / `scoreSoftmax_min_le_of_le` — the two-temperature
  form of the same statements.

Nothing here needs a *strict* maximizer: the bounds are the honest weak ones, and
they degenerate to equalities exactly on constant scores.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterSoftmaxTemperatureMonotone

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterSoftmaxFluctuation

variable {m : ℕ}

/-! ## The response law, and the mean score between the extremes -/

/-- The response law of `hasDerivAt_scoreSoftmax`, in `deriv` form. -/
theorem deriv_scoreSoftmax_beta (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    deriv (fun b : ℝ => scoreSoftmax b s j) beta
      = scoreSoftmax beta s j * (s j - meanScore beta s) :=
  (hasDerivAt_scoreSoftmax beta s j).deriv

/-- The mean score is never below the worst score: the companion of
`meanScore_le_max`. -/
theorem min_le_meanScore (beta : ℝ) (s : Fin m → ℝ) (i : Fin m)
    (hmin : ∀ l, s i ≤ s l) : s i ≤ meanScore beta s := by
  have hsum : ∑ l, scoreSoftmax beta s l = 1 := scoreSoftmax_sum_one beta s i
  calc s i = ∑ l, scoreSoftmax beta s l * s i := by rw [← Finset.sum_mul, hsum, one_mul]
    _ ≤ meanScore beta s :=
        Finset.sum_le_sum fun l _ =>
          mul_le_mul_of_nonneg_left (hmin l) (scoreSoftmax_nonneg beta s l)

/-! ## Sharpening is monotone -/

/-- Every attention weight is a differentiable function of the inverse
temperature. -/
theorem differentiable_scoreSoftmax (s : Fin m → ℝ) (j : Fin m) :
    Differentiable ℝ fun b : ℝ => scoreSoftmax b s j := fun b =>
  (hasDerivAt_scoreSoftmax b s j).differentiableAt

/-- **The winner's share is monotone in `β`.**  If `j` carries a maximal score,
its attention weight never decreases when the temperature drops. -/
theorem scoreSoftmax_monotone_of_max (s : Fin m → ℝ) (j : Fin m) (hmax : ∀ l, s l ≤ s j) :
    Monotone fun b : ℝ => scoreSoftmax b s j := by
  refine monotone_of_deriv_nonneg (differentiable_scoreSoftmax s j) fun b => ?_
  rw [deriv_scoreSoftmax_beta b s j]
  have hmean : meanScore b s ≤ s j := meanScore_le_max b s j hmax
  exact mul_nonneg (scoreSoftmax_nonneg b s j) (by linarith)

/-- **The loser's share is antitone in `β`.**  If `i` carries a minimal score, its
attention weight never increases when the temperature drops. -/
theorem scoreSoftmax_antitone_of_min (s : Fin m → ℝ) (i : Fin m) (hmin : ∀ l, s i ≤ s l) :
    Antitone fun b : ℝ => scoreSoftmax b s i := by
  refine antitone_of_deriv_nonpos (differentiable_scoreSoftmax s i) fun b => ?_
  rw [deriv_scoreSoftmax_beta b s i]
  have hmean : s i ≤ meanScore b s := min_le_meanScore b s i hmin
  exact mul_nonpos_of_nonneg_of_nonpos (scoreSoftmax_nonneg b s i) (by linarith)

/-! ## Comparing two temperatures -/

/-- The two-temperature form: a maximal key gains attention as `β` grows. -/
theorem scoreSoftmax_max_ge_of_le {beta gamma : ℝ} (hbg : beta ≤ gamma) (s : Fin m → ℝ)
    (j : Fin m) (hmax : ∀ l, s l ≤ s j) :
    scoreSoftmax beta s j ≤ scoreSoftmax gamma s j :=
  scoreSoftmax_monotone_of_max s j hmax hbg

/-- The two-temperature form: a minimal key loses attention as `β` grows. -/
theorem scoreSoftmax_min_le_of_le {beta gamma : ℝ} (hbg : beta ≤ gamma) (s : Fin m → ℝ)
    (i : Fin m) (hmin : ∀ l, s i ≤ s l) :
    scoreSoftmax gamma s i ≤ scoreSoftmax beta s i :=
  scoreSoftmax_antitone_of_min s i hmin hbg

/-- **At any positive inverse temperature the best key already carries at least the
uniform share `1/m`.** -/
theorem scoreSoftmax_max_ge_inv_card {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ) (j : Fin m)
    (hmax : ∀ l, s l ≤ s j) : 1 / (m : ℝ) ≤ scoreSoftmax beta s j := by
  have h := scoreSoftmax_max_ge_of_le hb s j hmax
  rwa [scoreSoftmax_zero] at h

/-- **At any positive inverse temperature the worst key carries at most the uniform
share `1/m`.** -/
theorem scoreSoftmax_min_le_inv_card {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ) (i : Fin m)
    (hmin : ∀ l, s i ≤ s l) : scoreSoftmax beta s i ≤ 1 / (m : ℝ) := by
  have h := scoreSoftmax_min_le_of_le hb s i hmin
  rwa [scoreSoftmax_zero] at h

/-- On constant scores the monotonicity degenerates: every weight stays at `1/m`
for every temperature. -/
theorem scoreSoftmax_const_of_const {s : Fin m → ℝ} {c : ℝ} (hs : ∀ l, s l = c)
    (beta : ℝ) (j : Fin m) : scoreSoftmax beta s j = 1 / (m : ℝ) := by
  have hfun : s = fun _ => c := funext hs
  subst hfun
  exact scoreSoftmax_const beta c j

end BookProof.ChapterSoftmaxTemperatureMonotone

end
