import Definitions.Def_ChapterBayesInference
import Mathlib


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


/-
Randomized training pushes a probability distribution on seeds to a
probability distribution on models.
-/


/-
If every seed trains to an admissible model, the induced prior is supported
on admissible models.  This is the precise finite version of sampling only the
models accepted by a computational or complexity constraint.
-/


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


/-
Models outside the image of training have posterior mass zero.
-/


end BookProof.ChapterDeepLearningSampling
