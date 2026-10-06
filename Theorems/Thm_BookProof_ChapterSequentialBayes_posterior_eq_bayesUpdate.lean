-- Generated from ChapterSequentialBayes.lean — theorem BookProof.ChapterSequentialBayes.posterior_eq_bayesUpdate
import Mathlib
import Definitions.Def_ChapterSequentialBayes
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterSequentialBayes

variable {X : Type*} [Fintype X]


open scoped BigOperators



theorem BookProof.ChapterSequentialBayes.posterior_eq_bayesUpdate {Y : Type*}
    (prior : X → ℝ) (L : X → Y → ℝ) (y : Y) :
    BookProof.ChapterBayesInference.posterior prior L y = bayesUpdate prior (fun x => L x y) := by sorry
