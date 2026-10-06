-- Generated from ChapterSequentialBayes.lean — theorem BookProof.ChapterSequentialBayes.posterior_sequential_eq_batch
import Mathlib
import Definitions.Def_ChapterSequentialBayes
import Definitions.Def_ChapterBayesInference
open BookProof.ChapterBayesInference
open BookProof.ChapterSequentialBayes

variable {X : Type*} [Fintype X]


open scoped BigOperators



theorem BookProof.ChapterSequentialBayes.posterior_sequential_eq_batch {Y₁ Y₂ : Type*}
    (prior : X → ℝ) (L₁ : X → Y₁ → ℝ) (L₂ : X → Y₂ → ℝ) (y₁ : Y₁) (y₂ : Y₂)
    (h1 : 0 < totEvidence prior (fun x => L₁ x y₁))
    (h2 : 0 < totEvidence prior (fun x => L₁ x y₁ * L₂ x y₂)) :
    bayesUpdate (BookProof.ChapterBayesInference.posterior prior L₁ y₁) (fun x => L₂ x y₂)
      = bayesUpdate prior (fun x => L₁ x y₁ * L₂ x y₂) := by sorry
