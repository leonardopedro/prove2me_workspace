-- Generated from ChapterSequentialBayes.lean — theorem BookProof.ChapterSequentialBayes.sequential_eq_batch
import Mathlib
import Definitions.Def_ChapterSequentialBayes
open BookProof.ChapterSequentialBayes


open scoped BigOperators


variable {X : Type*} [Fintype X]


theorem BookProof.ChapterSequentialBayes.sequential_eq_batch {prior ℓ₁ ℓ₂ : X → ℝ}
    (h1 : 0 < totEvidence prior ℓ₁)
    (h2 : 0 < totEvidence prior (fun x => ℓ₁ x * ℓ₂ x)) :
    bayesUpdate (bayesUpdate prior ℓ₁) ℓ₂ = bayesUpdate prior (fun x => ℓ₁ x * ℓ₂ x) := by sorry
