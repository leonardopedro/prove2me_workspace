import Definitions.Def_ChapterBayesInference
import Mathlib


/-!
# Book chapter "Consciousness as a representation of a Bayesian prior"

This file formalizes the elementary Bayesian core of §"A deterministic prior is
still subjective" (`book.tex` lines 9208–9267).  A deterministic prior is a
Dirac mass.  Conditioning it on data of positive likelihood leaves it a Dirac
mass; choosing a different deterministic prior can therefore give a different
posterior from the same likelihood and observation.

The philosophical discussion surrounding these identities remains prose.
-/

open scoped BigOperators

namespace BookProof.ChapterPriorDependence

variable {Hyp Data : Type*} [DecidableEq Hyp]

/-- Deterministic (Dirac) prior concentrated at `a`. -/
def diracPrior (a : Hyp) (x : Hyp) : ℝ := if x = a then 1 else 0



variable [Fintype Hyp]



/-
Evidence under a deterministic prior is just the likelihood at its support.
-/


/-
Positive-likelihood Bayesian updating preserves a deterministic prior.
-/


/-
Two distinct deterministic prior assumptions yield distinct posteriors for
the same data whenever the first supported hypothesis has positive likelihood.
-/


end BookProof.ChapterPriorDependence
