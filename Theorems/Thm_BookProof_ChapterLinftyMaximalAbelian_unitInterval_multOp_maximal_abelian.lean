-- Generated from ChapterLinftyMaximalAbelian.lean — theorem BookProof.ChapterLinftyMaximalAbelian.unitInterval_multOp_maximal_abelian
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLinftyMaximalAbelian


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]


theorem BookProof.ChapterLinftyMaximalAbelian.unitInterval_multOp_maximal_abelian
    (T : Lp ℂ 2 (MeasureTheory.volume.restrict (Set.Icc (0 : ℝ) 1)) →L[ℂ]
      Lp ℂ 2 (MeasureTheory.volume.restrict (Set.Icc (0 : ℝ) 1)))
    (hT : CommutesWithMultOps T) :
    ∃ (ψ : ℝ → ℂ) (hψ : MemLp ψ ⊤ (MeasureTheory.volume.restrict (Set.Icc (0 : ℝ) 1))),
      T = multOp ψ hψ := by sorry
