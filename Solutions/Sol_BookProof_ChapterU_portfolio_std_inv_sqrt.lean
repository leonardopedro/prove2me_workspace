-- Generated from ChapterU.lean — solution of BookProof.ChapterU.portfolio_std_inv_sqrt
import Mathlib
import Definitions.Def_ChapterU
import Theorems.Thm_BookProof_ChapterU_portfolio_risk_inv_sqrt
open BookProof.ChapterU



open MeasureTheory
open scoped ENNReal ProbabilityTheory TensorProduct

variable {X : Type*} [MeasurableSpace X]
variable (R M N : Type*) [CommRing R] [AddCommGroup M] [Module R M]
  [AddCommGroup N] [Module R N]
variable {Ω : Type*} [MeasurableSpace Ω]

set_option maxHeartbeats 1000000 in
heorem portfolio_std_inv_sqrt {n : ℕ} (hn : 0 < n) (X : Fin n → Ω → ℝ) (σ : ℝ)
    (hσ : 0 ≤ σ) (P : Measure Ω) [IsProbabilityMeasure P]
    (hindep : ProbabilityTheory.iIndepFun X P)
    (hmem : ∀ i, MemLp (X i) 2 P) (hvar : ∀ i, ProbabilityTheory.variance (X i) P = σ ^ 2) :
    Real.sqrt (ProbabilityTheory.variance (fun ω => (∑ i, X i ω) / n) P) = σ / Real.sqrt n : :=
  = by
    convert congr_arg Real.sqrt ( portfolio_risk_inv_sqrt hn X σ P hindep hmem hvar ) using 1;
    rw [ Real.sqrt_div ( sq_nonneg _ ), Real.sqrt_sq hσ ]
