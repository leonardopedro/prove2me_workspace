-- Generated from ChapterU.lean — theorem BookProof.ChapterU.portfolio_risk_inv_sqrt
import Mathlib
import Definitions.Def_ChapterU
open BookProof.ChapterU

variable {X : Type*} [MeasurableSpace X]
variable (R M N : Type*) [CommRing R] [AddCommGroup M] [Module R M]
  [AddCommGroup N] [Module R N]
variable {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory
open scoped ENNReal ProbabilityTheory TensorProduct

heorem portfolio_risk_inv_sqrt {n : ℕ} (hn : 0 < n) (X : Fin n → Ω → ℝ) (σ : ℝ)
    (P : Measure Ω) [IsProbabilityMeasure P]
    (hindep : ProbabilityTheory.iIndepFun X P)
    (hmem : ∀ i, MemLp (X i) 2 P) (hvar : ∀ i, ProbabilityTheory.variance (X i) P = σ ^ 2) :
    ProbabilityTheory.variance (fun ω => (∑ i, X i ω) / n) P = σ ^ 2 / n : := by sorry
