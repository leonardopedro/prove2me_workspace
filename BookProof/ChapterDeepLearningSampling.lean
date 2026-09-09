import Mathlib
import BookProof.ChapterBayesInference

/-!
# Book chapter "Aligned deep learning as a random sampling method"

This file formalizes the finite mathematical core of §§3–5 of the chapter at
`book.tex` lines 9855–10155.  A randomized training procedure is represented by
a deterministic map from random seeds to models.  Pushing the seed distribution
forward gives the emergent prior on trained models.  Conditioning this prior by
a nonnegative likelihood gives the usual Bayesian posterior.

The statements here do not formalize the chapter's empirical claims about actual
neural networks.  They isolate the exact probability identities those claims use.
-/

open scoped BigOperators

namespace BookProof.ChapterDeepLearningSampling

variable {Seed Model Data : Type*}
variable [Fintype Seed] [DecidableEq Model]

/-- Distribution on trained models induced by random initialization and a
training map: sum the seed masses over each fibre. -/
def inducedPrior (seedProb : Seed → ℝ) (train : Seed → Model) (m : Model) : ℝ :=
  ∑ s with train s = m, seedProb s

/-
The induced mass of an event is the seed mass of its preimage.
-/
theorem sum_inducedPrior_event
    (seedProb : Seed → ℝ) (train : Seed → Model)
    (A : Finset Model) :
    ∑ m ∈ A, inducedPrior seedProb train m = ∑ s with train s ∈ A, seedProb s := by
  simp only [inducedPrior]
  exact Finset.sum_fiberwise_eq_sum_filter Finset.univ A train seedProb

/-
Randomized training pushes a probability distribution on seeds to a
probability distribution on models.
-/
theorem inducedPrior_isProbability [Fintype Model]
    (seedProb : Seed → ℝ) (train : Seed → Model)
    (hnonneg : ∀ s, 0 ≤ seedProb s) (hsum : ∑ s, seedProb s = 1) :
    (∀ m, 0 ≤ inducedPrior seedProb train m) ∧
      ∑ m, inducedPrior seedProb train m = 1 := by
  refine ⟨fun m => Finset.sum_nonneg fun s hs => hnonneg s, ?_⟩
  rw [← hsum, sum_inducedPrior_event]
  simp

/-
If every seed trains to an admissible model, the induced prior is supported
on admissible models.  This is the precise finite version of sampling only the
models accepted by a computational or complexity constraint.
-/
theorem inducedPrior_supported (seedProb : Seed → ℝ) (train : Seed → Model)
    (admissible : Model → Prop)
    (htrain : ∀ s, admissible (train s)) {m : Model} (hm : ¬ admissible m) :
    inducedPrior seedProb train m = 0 := by
  exact Finset.sum_eq_zero fun s hs => False.elim <| hm <| by aesop

variable [Fintype Model]

/-- Likelihood of observed data under the induced model prior. -/
def evidence (seedProb : Seed → ℝ) (train : Seed → Model)
    (likelihood : Model → Data → ℝ) (d : Data) : ℝ :=
  ∑ m, inducedPrior seedProb train m * likelihood m d

/-- Posterior obtained by conditioning the emergent prior on observed data. -/
noncomputable def posterior (seedProb : Seed → ℝ) (train : Seed → Model)
    (likelihood : Model → Data → ℝ) (d : Data) (m : Model) : ℝ :=
  inducedPrior seedProb train m * likelihood m d /
    evidence seedProb train likelihood d

/-
With positive evidence, Bayesian conditioning of the training-induced prior
is normalized.
-/
theorem posterior_sum_one (seedProb : Seed → ℝ) (train : Seed → Model)
    (likelihood : Model → Data → ℝ) (d : Data)
    (hd : 0 < evidence seedProb train likelihood d) :
    ∑ m, posterior seedProb train likelihood d m = 1 := by
  unfold posterior
  rw [← Finset.sum_div, div_eq_iff] <;> aesop

/-
Models outside the image of training have posterior mass zero.
-/
theorem posterior_eq_zero_of_not_mem_range (seedProb : Seed → ℝ)
    (train : Seed → Model) (likelihood : Model → Data → ℝ) (d : Data)
    {m : Model} (hm : m ∉ Set.range train) :
    posterior seedProb train likelihood d m = 0 := by
  unfold posterior;
  unfold inducedPrior
  aesop

end BookProof.ChapterDeepLearningSampling
