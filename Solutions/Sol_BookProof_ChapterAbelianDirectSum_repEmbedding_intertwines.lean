-- Generated from ChapterAbelianDirectSum.lean — solution of BookProof.ChapterAbelianDirectSum.repEmbedding_intertwines
import Mathlib
import Definitions.Def_ChapterAbelianDirectSum
import Theorems.Thm_BookProof_ChapterAbelianCyclicModel_mulRep_toLp
open BookProof.ChapterAbelianDirectSum



noncomputable section

open MeasureTheory Complex WeakDual


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H))
variable (xi : H)

set_option maxHeartbeats 1000000 in
theorem solution (g : C(X, ℂ)) (u : Lp ℂ 2 (repMeasure pi xi)) :
    repEmbedding pi xi (mulRep (repMeasure pi xi) g u) = pi g (repEmbedding pi xi u) := by

  have hdense : DenseRange
      ((ContinuousMap.toLp 2 (repMeasure pi xi) ℂ).toLinearMap :
        C(X, ℂ) → Lp ℂ 2 (repMeasure pi xi)) :=
    ContinuousMap.toLp_denseRange ℂ _ (μ := repMeasure pi xi) (by simp)
  have hcont₁ : Continuous fun v : Lp ℂ 2 (repMeasure pi xi) =>
      repEmbedding pi xi (mulRep (repMeasure pi xi) g v) :=
    (repEmbedding pi xi).continuous.comp (mulRep (repMeasure pi xi) g).continuous
  have hcont₂ : Continuous fun v : Lp ℂ 2 (repMeasure pi xi) =>
      pi g (repEmbedding pi xi v) :=
    (pi g).continuous.comp (repEmbedding pi xi).continuous
  have hfun : (fun v : Lp ℂ 2 (repMeasure pi xi) =>
        repEmbedding pi xi (mulRep (repMeasure pi xi) g v))
      = fun v : Lp ℂ 2 (repMeasure pi xi) => pi g (repEmbedding pi xi v) := by
    refine hdense.equalizer hcont₁ hcont₂ (funext fun f => ?_)
    simp only [Function.comp_apply, ContinuousLinearMap.coe_coe]
    rw [mulRep_toLp pi xi g f, repEmbedding_toLp, repEmbedding_toLp, map_mul]
    rfl
  exact congrFun hfun u
