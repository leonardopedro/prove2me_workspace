import Mathlib
import BookProof.ChapterDeepLearningSampling

/-!
# Ensemble identities for randomized training

This file continues the finite formalization of `book.tex` §§3–5 of *Aligned
deep learning as a random sampling method*.  Once random initialization and a
deterministic training procedure induce a distribution on trained models,
model averages can be computed equivalently over models or directly over random
seeds.  The same fibrewise identity expresses Bayesian evidence and
unnormalized posterior observables at seed level.
-/

open scoped BigOperators

namespace BookProof.ChapterDeepLearningEnsemble

open BookProof.ChapterDeepLearningSampling

variable {Seed Model Data : Type*}
variable [Fintype Seed] [Fintype Model] [DecidableEq Model]

/-
Expectation under the training-induced model prior equals expectation of
the trained model under the original seed distribution.
-/
theorem inducedPrior_expectation (seedProb : Seed → ℝ)
    (train : Seed → Model) (observable : Model → ℝ) :
    ∑ m, inducedPrior seedProb train m * observable m =
      ∑ s, seedProb s * observable (train s) := by
  simp only [inducedPrior, Finset.sum_mul]
  rw [Finset.sum_sigma']
  apply Finset.sum_bij (fun s _ => s.snd) <;> aesop

/-
The evidence of the induced model prior can be evaluated directly by
averaging the likelihood over training seeds.
-/
theorem evidence_eq_seed_average (seedProb : Seed → ℝ)
    (train : Seed → Model) (likelihood : Model → Data → ℝ) (d : Data) :
    evidence seedProb train likelihood d =
      ∑ s, seedProb s * likelihood (train s) d := by
  convert inducedPrior_expectation seedProb train (fun m => likelihood m d) using 1

/-
Any observable weighted by the unnormalized posterior can likewise be
computed directly over seeds.
-/
theorem posterior_numerator_eq_seed_average (seedProb : Seed → ℝ)
    (train : Seed → Model) (likelihood : Model → Data → ℝ)
    (observable : Model → ℝ) (d : Data) :
    ∑ m, inducedPrior seedProb train m * likelihood m d * observable m =
      ∑ s, seedProb s * likelihood (train s) d * observable (train s) := by
  convert inducedPrior_expectation seedProb train
    (fun m => likelihood m d * observable m) using 1 <;> simp only [mul_assoc]

/-
Under positive evidence, posterior expectations are ratios of seed-level
weighted averages.
-/
theorem posterior_expectation_eq_seed_ratio (seedProb : Seed → ℝ)
    (train : Seed → Model) (likelihood : Model → Data → ℝ)
    (observable : Model → ℝ) (d : Data) :
    ∑ m, posterior seedProb train likelihood d m * observable m =
      (∑ s, seedProb s * likelihood (train s) d * observable (train s)) /
        (∑ s, seedProb s * likelihood (train s) d) := by
  convert congr_arg
    (fun x : ℝ => x / ∑ m, inducedPrior seedProb train m * likelihood m d)
    (posterior_numerator_eq_seed_average seedProb train likelihood observable d) using 1
  · simp only [posterior, div_mul_eq_mul_div, Finset.sum_div]
    convert rfl
  · rw [← evidence_eq_seed_average]
    rfl

end BookProof.ChapterDeepLearningEnsemble
