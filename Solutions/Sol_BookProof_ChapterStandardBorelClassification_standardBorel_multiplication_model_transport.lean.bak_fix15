-- Generated from ChapterStandardBorelClassification.lean — solution of BookProof.ChapterStandardBorelClassification.standardBorel_multiplication_model_transport
import Mathlib
import Definitions.Def_ChapterStandardBorelClassification
import Theorems.Thm_BookProof_ChapterStandardBorelClassification_transportUnitary_intertwines
import Theorems.Thm_BookProof_ChapterStandardBorelClassification_purelyAtomic_of_countable
import Theorems.Thm_BookProof_ChapterAtomicDiagonalModel_atomic_multiplication_model_diagonal
open BookProof.ChapterStandardBorelClassification



noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterAbelianClassificationList

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y] (e : X ≃ᵐ Y)
  (mu : Measure X)
variable {X : Type*} [MeasurableSpace X] [StandardBorelSpace X]
  (mu : Measure X) [IsProbabilityMeasure mu]

set_option maxHeartbeats 1000000 in
theorem solution :
    (Countable X ∧ ∃ B : HilbertBasis (atomSet mu) ℂ (Lp ℂ 2 mu),
        ∀ (g : X → ℂ) (hg : MemLp g ⊤ mu) (a : atomSet mu),
          multOp g hg (B a) = g (a : X) • B a) ∨
      (∃ e : X ≃ᵐ ℝ, IsProbabilityMeasure (Measure.map e mu) ∧
        ∃ U : Lp ℂ 2 (Measure.map e mu) ≃ₗᵢ[ℂ] Lp ℂ 2 mu,
          ∀ (g : ℝ → ℂ) (hg : MemLp g ⊤ (Measure.map e mu))
            (v : Lp ℂ 2 (Measure.map e mu)),
            U (multOp g hg v)
              = multOp (fun x => g (e x)) (memLp_top_comp_equiv e mu hg) (U v)) := by

  by_cases hcount : Countable X
  · refine Or.inl ⟨hcount, ?_⟩
    exact atomic_multiplication_model_diagonal mu (purelyAtomic_of_countable mu)
  · have huncount : ¬ Countable ℝ := by simp
    refine Or.inr ⟨PolishSpace.measurableEquivOfNotCountable hcount huncount, ?_, ?_⟩
    · constructor
      rw [Measure.map_apply
        (PolishSpace.measurableEquivOfNotCountable hcount huncount).measurable
        MeasurableSet.univ]
      simp
    · exact ⟨transportUnitary _ mu, fun g hg v => transportUnitary_intertwines _ mu hg v⟩
